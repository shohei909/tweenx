import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.StageScaleMode;
import openfl.geom.Matrix;
import openfl.Lib;

import tweenx909.TweenX;
import tweenx909.EaseX;
using tweenx909.ChainX;

class Main extends Sprite {
	static inline var CELL_SIZE = 20;
	public function new() {
		super();
		Lib.current.stage.scaleMode = StageScaleMode.SHOW_ALL;

		
		//Draw background
		graphics.lineStyle(1, 0xEEEEEE);
		var end = CELL_SIZE * 20;
		for (i in 0...21) {
			var p = i * CELL_SIZE;
			graphics.moveTo(0, p);
			graphics.lineTo(end, p);
			graphics.moveTo(p, 0);
			graphics.lineTo(p, end);
		}
		
		//Make square
		var square = new Square(CELL_SIZE * 2);
		addChild(square);
		
		var defaults = TweenX.dumpDefaults();
		defaults.time(1).ease(EaseX.quartOut);
		
		//Tween!!
		TweenX.serial([
			TweenX.to(square).x(360).y(  0),
			TweenX.to(square).x(360).y(360).yoyo().repeat(2),
			TweenX.to(square).x(  0).y(360).zigzag().repeat(3),
			TweenX.to(square).x(  0).y(  0),
		], defaults).repeat();
	}
}

private class Square extends Shape {
	public function new(size:Float) {
		super();

		graphics.beginFill(0x335F73);
		graphics.drawRect(0, 0, size, size);
	}
}