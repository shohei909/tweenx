package sample;

import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.display.StageScaleMode;
import openfl.events.MouseEvent;
import openfl.Lib;
import tweenx909.TweenX;

class SamplePlayer extends Sprite {
    var child:Sprite;

    public function new () {
        super();
		Lib.current.stage.scaleMode = StageScaleMode.SHOW_ALL;
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
    }

    public function onDown(e:MouseEvent) {
        if (child != null) {
            removeChild(child);
        }

        addChild(child = start());
    }

    function start():Sprite {
        return null;
    }
}

class GridSprite extends Sprite {
	public static inline var CELL_SIZE = 15;
	public static inline var CELL_W = 30;
    public static inline var CELL_H = 10;

    public function new() {
		super();

		//Draw background
		graphics.lineStyle(1, 0xF1F1F1);
		var end = CELL_SIZE * CELL_W;
		for (i in 0...CELL_H + 1) {
			var p = i * CELL_SIZE;
			graphics.moveTo(0, p);
			graphics.lineTo(end, p);
        }

        var end = CELL_SIZE * CELL_H;
		for (i in 0...CELL_W + 1) {
			var p = i * CELL_SIZE;
			graphics.moveTo(p, 0);
			graphics.lineTo(p, end);
		}
	}
}

class Square extends Shape {
	public function new(x:Float, y:Float) {
		super();

        this.x = x;
        this.y = y;
        var size = GridSprite.CELL_SIZE * 2;
		graphics.beginFill(0x4EDAE1);
		graphics.drawRect(0, 0, size, size);
	}
}
