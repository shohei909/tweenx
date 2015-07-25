import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.StageScaleMode;
import openfl.geom.Matrix;
import openfl.Lib;
import tweenx909.object.HsvColorX;
import tweenx909.object.RgbColorX;

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
		
		//Tween!!
		function draw(x:Float, y:Float, color:Int) {
			graphics.beginFill(color);
			graphics.drawRect(x, y, 8, 40);
		}
		
		TweenX.serial([
			TweenX.tweenFunc(draw, [0, 100, RgbColorX.of(0x3373EE) 	], [380, 100, RgbColorX.of(0xEE7333) 	]),
			TweenX.tweenFunc(draw, [0, 180, HsvColorX.of(0x3373EE) 	], [380, 180, HsvColorX.of(0xEE7333) 	]),
			TweenX.tweenFunc(draw, [0, 260, new HsvColorX(0,0.7,0.9) 	], [380, 260, new HsvColorX(2,0.7,0.9) ]),
		]);
	}
}