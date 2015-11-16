import openfl.display.Sprite;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFormat;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangeRepeatPart;
import tweenxcore.Tools.Easing;
using tweenxcore.Tools;

class Sample extends Sprite {
    public static var MOTION_END:Float = 240;
    public static inline var CELL_SIZE = 20;
    public var charts:Array<Chart>;
    public var frameCount:Int;

    public function new() {
        super();
        Lib.current.stage.scaleMode = StageScaleMode.SHOW_ALL;

        addEventListener(Event.EXIT_FRAME, onFrame);
        var eases:Array<Array<Array<Dynamic>>> = [
            [
                [ "linear", Easing.linear ],
            ],
            [
                [ "quadIn",         Easing.quadIn ],
                [ "quadOut",        Easing.quadOut ],
                [ "quadInOut",      Easing.quadInOut ],
                [ "quadOutIn",      Easing.quadOutIn ],
            ],
            [
                [ "cubicIn",        Easing.cubicIn ],
                [ "cubicOut",       Easing.cubicOut ],
                [ "cubicInOut",     Easing.cubicInOut ],
                [ "cubicOutIn",     Easing.cubicOutIn ],
            ],
            [
                [ "quartIn",        Easing.quartIn ],
                [ "quartOut",       Easing.quartOut ],
                [ "quartInOut",     Easing.quartInOut ],
                [ "quartOutIn",     Easing.quartOutIn ],
            ],
            [
                [ "quintIn",        Easing.quintIn ],
                [ "quintOut",       Easing.quintOut ],
                [ "quintInOut",     Easing.quintInOut ],
                [ "quintOutIn",     Easing.quintOutIn ],
            ],
            [
                [ "sineIn",         Easing.sineIn ],
                [ "sineOut",        Easing.sineOut ],
                [ "sineInOut",      Easing.sineInOut ],
                [ "sineOutIn",      Easing.sineOutIn ],
            ],
            [
                [ "circIn",         Easing.circIn ],
                [ "circOut",        Easing.circOut ],
                [ "circInOut",      Easing.circInOut ],
                [ "circOutIn",      Easing.circOutIn ],
            ],
            [
                [ "expoIn",         Easing.expoIn ],
                [ "expoOut",        Easing.expoOut ],
                [ "expoInOut",      Easing.expoInOut ],
                [ "expoOutIn",      Easing.expoOutIn ],
            ],
            [
                [ "backIn",         Easing.backIn ],
                [ "backOut",        Easing.backOut ],
                [ "backInOut",      Easing.backInOut ],
                [ "backOutIn",      Easing.backOutIn ],
            ],
            [
                [ "bounceIn",       Easing.bounceIn ],
                [ "bounceOut",      Easing.bounceOut ],
                [ "bounceInOut",    Easing.bounceInOut ],
                [ "bounceOutIn",    Easing.bounceOutIn ],
            ],
            [
                [ "elasticIn",      Easing.elasticIn ],
                [ "elasticOut",     Easing.elasticOut ],
                [ "elasticInOut",   Easing.elasticInOut ],
                [ "elasticOutIn",   Easing.elasticOutIn ],
            ],
            [
                [ "warpIn",         Easing.warpIn ],
                [ "warpOut",        Easing.warpOut ],
                [ "warpInOut",      Easing.warpInOut ],
                [ "warpOutIn",      Easing.warpOutIn ],
            ],
        ];

        var y = CELL_SIZE, i = 0, sx =  CELL_SIZE * 0.5;
        charts = [];

        for (arr in eases) {
            var x = sx;
            for (e in arr) {
                var chart = new Chart(e[0], e[1]);
                addChild(chart);
                chart.x = x;
                chart.y = y;
                charts.push(chart);

                x += CELL_SIZE * 4.5;
            }

            if (++i % 6 == 0) {
                y = CELL_SIZE;
                sx = CELL_SIZE * ((4.5 * 4 + 1) * (i / 6) + 0.5);
            } else {
                y += CELL_SIZE * 4;
            }
        }

        addEventListener(Event.EXIT_FRAME, onFrame);
    }

    function onFrame(e) {
        var change = new FloatChange(frameCount, frameCount += 1);
        change.handlePart(0, 120, update);
    }

    function update(change:FloatChange) {
        var curvedChange = change.map(Easing.cubicInOut);
        var body = 0.3;
        var margin = 1 - body;
        var length = charts.length;

        for (i in 0...length) {
            var start = (i / (length - 1)).lerp(0, margin);
            curvedChange.handlePart(start, start + body, charts[i].update);
        }
    }
}

private class Chart extends Sprite {
    var easing:Float->Float;
    public static inline var H:Float = Sample.CELL_SIZE * 3;
    public static inline var W:Float = Sample.CELL_SIZE * 4;

    public function new(title:String = "ease", easing:Float->Float) {
        super();
        this.easing = easing;
        this.mouseEnabled = false;
        this.mouseChildren = false;

        graphics.lineStyle(1, 0xEEEEEE);

        var end;
        end = Sample.CELL_SIZE * 4;
        for (i in 0...4) {
            var p = i * Sample.CELL_SIZE;
            graphics.moveTo(0, p);
            graphics.lineTo(end, p);
        }

        end = Sample.CELL_SIZE * 3;
        for (i in 0...5) {
            var p = i * Sample.CELL_SIZE;
            graphics.moveTo(p, 0);
            graphics.lineTo(p, end);
        }

        graphics.lineStyle(1, 0x335F73);
        graphics.moveTo(0, H);

        var tf = new TextField();
        tf.defaultTextFormat = new TextFormat("_sans", 11, 0x666666);
        tf.text     = title + " ";
        tf.height     = tf.textHeight + 4;
        tf.width     = tf.textWidth     + 4;
        tf.y         = 4 - tf.height;
        addChild(tf);
    }

    public function update(change:FloatChange) {
        var repeat = 128;
        change.handleRepeatPart(0, 1 / repeat, repeat, draw);
    }

    function draw(change:FloatChangeRepeatPart) {
        if (change.isPartExit()) {
            var c = (change.current + change.repeatCount) / change.repeatLimit;
            graphics.lineTo(W * c, H * (1 - easing(c)));
        }
    }
}
