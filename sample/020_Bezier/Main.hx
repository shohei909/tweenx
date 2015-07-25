import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.ColorTransform;
import openfl.geom.Matrix;
import tweenx909.FloatToolsX;
import tweenx909.rule.QuakeRuleX;

import tweenx909.TweenX;
import tweenx909.EaseX;
using tweenx909.ChainX;
using tweenx909.FloatToolsX;

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
		
		var bitmapData = new BitmapData(400, 400, true, 0);
		addChild(new Bitmap(bitmapData));
		
		//Make square
		var start = new Circle(10, 0x335F73);
		start.x = 20;
		start.y = 20;
		addChild(start);
		listen(start);
		
		var ctrl0 = new Circle(10, 0xEE7333);
		ctrl0.x = 100;
		ctrl0.y = 300;
		addChild(ctrl0);
		listen(ctrl0);
		
		var ctrl1 = new Circle(10, 0xEE7333);
		ctrl1.x = 300;
		ctrl1.y = 100;
		addChild(ctrl1);
		listen(ctrl1);
		
		var end = new Circle(10, 0x335F73);
		end.x = 380;
		end.y = 380;
		addChild(end);
		listen(end);
		
		var colorTransform = new ColorTransform(1, 1.01, 1.01, 0.998, 4, 2, 0);
		var shape = new Shape();
		var count = 0;
		var length = 120;
		var prevX = start.x;
		var prevY = start.y;
		
		addEventListener(
			Event.ENTER_FRAME,
			function (e:Event) {
				bitmapData.colorTransform(bitmapData.rect, colorTransform);
				shape.graphics.clear();
				
				var rate = count.repeat(0, length).yoyo(EaseX.expoInOut); 
				
				shape.graphics.lineStyle(1, 0x335F73);
				shape.graphics.moveTo(prevX, prevY);
				
				shape.graphics.lineTo(
					prevX = rate.bezier3(start.x, ctrl0.x, ctrl1.x, end.x),
					prevY = rate.bezier3(start.y, ctrl0.y, ctrl1.y, end.y)
				);
				
				shape.graphics.lineStyle(1, 0xEE7333, 0.5);
				
				if (count % 60 == 0) {
					shape.graphics.moveTo(start.x, start.y);
					shape.graphics.lineTo(ctrl0.x, ctrl0.y);
					shape.graphics.lineTo(ctrl1.x, ctrl1.y);
					shape.graphics.lineTo(end.x, end.y);
				}
				
				bitmapData.draw(shape);
				count++;
			}
		);
	}
	
	function listen(obj:Sprite) {
		var down = false;
		obj.buttonMode = true;
		obj.addEventListener(MouseEvent.MOUSE_DOWN, function (e) { down = true; } );
		stage.addEventListener(MouseEvent.MOUSE_UP, function (e) { down = false; } );
		
		stage.addEventListener(
			MouseEvent.MOUSE_MOVE, 
			function (e) { 
				if (down) {
					obj.x = mouseX.clamp(10, 390);
					obj.y = mouseY.clamp(10, 390);
				}
			}
		);
	}
}

private class Square extends Shape {
	public function new(size:Float) {
		super();
		graphics.beginFill(0x335F73);
		graphics.drawRect(0, 0, size, size);
	}
}

private class Circle extends Sprite {
	public function new(size:Float, color:Int) {
		super();
		var shape = new Shape();
		shape.graphics.beginFill(color);
		shape.graphics.drawCircle(0, 0, size);
		addChild(shape);
	}
}
