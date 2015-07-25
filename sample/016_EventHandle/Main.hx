import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.geom.Matrix;

import tweenx909.TweenX;
import tweenx909.EaseX;
using tweenx909.ChainX;

class Main extends Sprite {
	static inline var CELL_SIZE = 20;
	public function new() {
		super();
		
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
		square.y = CELL_SIZE * 8;
		
		var tween = TweenX.to(square)
							.x(360)
							.ease(EaseX.bounceOut)
							.delay(0.5)
							.repeat(2)
							.time(1.5)
							.zigzag()
							.interval(0.5);
			
		var player = new TweenXPlayer(tween, 401);
		player.y = 401 - TweenXPlayer.HEIGHT;
		addChild(player);
	}
}

private class Square extends Shape {
	public function new(size:Float) {
		super();
		graphics.beginFill(0x335F73);
		graphics.drawRect(0, 0, size, size);
	}
}