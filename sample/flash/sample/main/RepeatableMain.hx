package sample.main;

import flash.display.Sprite;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import flash.filters.BlurFilter;
import sample.component.PlayButton;
import sample.component.PlayButtonShadow;
import sample.component.SamplePlayer;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.Timeline;
using tweenxcore.Tools;

class RepeatableMain extends SamplePlayer {
    static inline var WAIT_FRAME_END = 60;
    static inline var READY_FRAME_END = 3;
    var filterTimeline:Timeline<BlurFilter>;
    var uiLayer:Sprite;
    var backLayer:Sprite;
    var playButton:PlayButton;
    var playButtonShadow:PlayButtonShadow;
    var state:RepeatableMainState;

    static function main()
    {
        Lib.current.stage.scaleMode = StageScaleMode.SHOW_ALL;
        Lib.current.stage.quality = StageQuality.MEDIUM;
        Lib.current.addChild(new RepeatableMain());
    }

    function new()
    {
        super();
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, clickToStart);
        Lib.current.stage.addEventListener(Event.ENTER_FRAME, onFrame);

        addChild(backLayer = new Sprite());

        var cell = 15;
        var stageWidth = Lib.current.stage.stageWidth;
        var stageHeight = Lib.current.stage.stageHeight;
        var w = Math.ceil(stageWidth / cell);
        var h = Math.ceil(stageHeight / cell);

        #if grid_background
        SamplePlayer.drawGrid(backLayer.graphics, cell, w, h);
        #end

        backLayer.cacheAsBitmap = true;

        filterTimeline = new Timeline();
        for (i in 0...4) {
            filterTimeline.add(new BlurFilter());
        }

        addChild(uiLayer = new Sprite());
        uiLayer.addChild(playButton = new PlayButton());
        playButton.x = stageWidth / 2;
        playButton.y = stageHeight / 2;
        uiLayer.addChild(playButtonShadow = new PlayButtonShadow());
        playButtonShadow.x = stageWidth / 2;
        playButtonShadow.y = stageHeight - 2;

        state = WaitToClick(WAIT_FRAME_END);

        updateState(new FloatChange(0, 1));
    }

    function onFrame(e:Event):Void {
        state = switch (state) {
            case Playing(frameCount):
                if (frameCount < Sample.MOTION_END) {
                    Playing(frameCount + 1);
                } else {
                    cacheAsBitmap = true;
                    #if !endless
                    WaitToClick(0);
                    #else
                    state;
                    #end
                }
            case WaitToClick(frameCount):
                if (frameCount < WAIT_FRAME_END) {
                    var change = new FloatChange(frameCount, frameCount + 1);
                    change.handlePart(0, WAIT_FRAME_END, onWaitToClick);
                    WaitToClick(frameCount + 1);
                } else {
                    state;
                }
            case ReadyToStart(frameCount):
                if (frameCount < READY_FRAME_END) {
                    var change = new FloatChange(frameCount, frameCount + 1);
                    change.handlePart(READY_FRAME_END, 0, updateState);
                    ReadyToStart(frameCount + 1);
                } else {
                    startToPlay();
                }
        }
    }

    function onWaitToClick(change:FloatChange) {
        updateState(change.mapFloatChange(Easing.quartOut));
    }

    function updateState(change:FloatChange) {
        change.handlePart(0.0, 0.6, updateBackLayer);
        change.handlePart(0.1, 1.0, updateUiLayer);
    }

    function updateUiLayer(change:FloatChange) {
        uiLayer.alpha = change.current;
        if (state.match(ReadyToStart(_))) {
            return;
        }
        var scale = change.current.yoyo(Easing.backIn).lerp(1, 1.03);
        playButton.scaleX = scale;
        playButton.scaleY = scale;
        playButtonShadow.scaleX = scale;
    }

    function updateBackLayer(change:FloatChange) {
        backLayer.alpha = change.current.lerp(1, 0.6);
        backLayer.filters = [filterTimeline.search(change.current).data];
    }

    function startToPlay():RepeatableMainState {
        if (child != null) {
            backLayer.removeChild(child);
        }

        uiLayer.alpha = 0;
        backLayer.filters = [];
        backLayer.addChild(child = new Sample());
        return Playing(0);
    }

    function clickToStart(e:MouseEvent) {
        cacheAsBitmap = false;
        state = switch (state) {
            case Playing(_):
                startToPlay();

            case WaitToClick(frameCount):
                var rate = 1 - (frameCount / WAIT_FRAME_END).clamp();
                ReadyToStart(Std.int(rate * READY_FRAME_END));

            case ReadyToStart(_):
                state;
        }
    }
}

private enum RepeatableMainState {
    WaitToClick(frameCount:Float);
    ReadyToStart(frameCount:Float);
    Playing(frameCount:Float);
}
