import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import openfl.geom.Matrix;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFormat;
import tweenx909.advanced.UpdateModeX;

import tweenx909.TweenX;
import tweenx909.EaseX;
using tweenx909.ChainX;

class Main extends Sprite {
	public static inline var CELL_SIZE = 20;

	public function new() {
		super();
		Lib.current.stage.scaleMode = StageScaleMode.SHOW_ALL;


		TweenX.updateMode = UpdateModeX.MANUAL;
		addEventListener(Event.EXIT_FRAME, onFrame);

		var eases:Array<Array<Array<Dynamic>>> = [
			[
				[ "linear", EaseX.linear ],
			],
			[
				[ "quadIn", 		EaseX.quadIn ],
				[ "quadOut", 		EaseX.quadOut ],
				[ "quadInOut", 		EaseX.quadInOut ],
				[ "quadOutIn", 		EaseX.quadOutIn ],
			],
			[
				[ "cubicIn", 		EaseX.cubicIn ],
				[ "cubicOut", 		EaseX.cubicOut ],
				[ "cubicInOut", 	EaseX.cubicInOut ],
				[ "cubicOutIn", 	EaseX.cubicOutIn ],
			],
			[
				[ "quartIn", 		EaseX.quartIn ],
				[ "quartOut", 		EaseX.quartOut ],
				[ "quartInOut", 	EaseX.quartInOut ],
				[ "quartOutIn", 	EaseX.quartOutIn ],
			],
			[
				[ "quintIn", 		EaseX.quintIn ],
				[ "quintOut", 		EaseX.quintOut ],
				[ "quintInOut", 	EaseX.quintInOut ],
				[ "quintOutIn", 	EaseX.quintOutIn ],
			],
			[
				[ "sineIn", 		EaseX.sineIn ],
				[ "sineOut", 		EaseX.sineOut ],
				[ "sineInOut", 		EaseX.sineInOut ],
				[ "sineOutIn", 		EaseX.sineOutIn ],
			],
			[
				[ "circIn", 		EaseX.circIn ],
				[ "circOut", 		EaseX.circOut ],
				[ "circInOut", 		EaseX.circInOut ],
				[ "circOutIn", 		EaseX.circOutIn ],
			],
			[
				[ "expoIn", 		EaseX.expoIn ],
				[ "expoOut", 		EaseX.expoOut ],
				[ "expoInOut", 		EaseX.expoInOut ],
				[ "expoOutIn", 		EaseX.expoOutIn ],
			],
			[
				[ "backIn", 		EaseX.backIn ],
				[ "backOut", 		EaseX.backOut ],
				[ "backInOut", 		EaseX.backInOut ],
				[ "backOutIn", 		EaseX.backOutIn ],
			],
			[
				[ "bounceIn", 		EaseX.bounceIn ],
				[ "bounceOut", 		EaseX.bounceOut ],
				[ "bounceInOut", 	EaseX.bounceInOut ],
				[ "bounceOutIn", 	EaseX.bounceOutIn ],
			],
			[
				[ "elasticIn", 		EaseX.elasticIn ],
				[ "elasticOut", 	EaseX.elasticOut ],
				[ "elasticInOut", 	EaseX.elasticInOut ],
				[ "elasticOutIn", 	EaseX.elasticOutIn ],
			],
			[
				[ "warpIn", 		EaseX.warpIn ],
				[ "warpOut", 		EaseX.warpOut ],
				[ "warpInOut", 		EaseX.warpInOut ],
				[ "warpOutIn", 		EaseX.warpOutIn ],
			],
		];

		var y = CELL_SIZE, i = 0, sx =  CELL_SIZE * 0.5;
		var ts = [];
		for (arr in eases) {
			var x = sx;
			for (e in arr) {
				var chart = new Chart(e[0]);
				addChild(chart);
				chart.x = x;
				chart.y = y;

				var t = TweenX.parallel([
					TweenX.to(chart, { "ny": CELL_SIZE * 3 }).ease(e[1]),
					TweenX.to(chart, { "nx": CELL_SIZE * 4 })
				]).onUpdate(chart.update);

				ts.push(t);

				x += CELL_SIZE * 4.5;
			}

			if (++i % 6 == 0) {
				y 	= CELL_SIZE;
				sx  = CELL_SIZE * ((4.5 * 4 + 1) * (i / 6) + 0.5);
			} else {
				y += CELL_SIZE * 4;
			}
		}

		TweenX.lag(ts, 0.06).ease(EaseX.cubicInOut);
		TweenX.updateMode = UpdateModeX.MANUAL;
		addEventListener(Event.EXIT_FRAME, onFrame);
	}

	function onFrame(e) {
		for(i in 0...16) TweenX.manualUpdate(1 / 60 / 16);
	}
}

private class Chart extends Sprite {
	public var px:Float = 0;
	public var py:Float = 0;
	public var nx:Float = 0;
	public var ny:Float = 0;
	public static inline var H:Float = Main.CELL_SIZE * 3;
	public static inline var W:Float = Main.CELL_SIZE * 4;

	public function new(title:String = "ease") {
		super();

		graphics.lineStyle(1, 0xEEEEEE);

		var end;
		end = Main.CELL_SIZE * 4;
		for (i in 0...4) {
			var p = i * Main.CELL_SIZE;
			graphics.moveTo(0, p);
			graphics.lineTo(end, p);
		}

		end = Main.CELL_SIZE * 3;
		for (i in 0...5) {
			var p = i * Main.CELL_SIZE;
			graphics.moveTo(p, 0);
			graphics.lineTo(p, end);
		}

		graphics.lineStyle(1, 0x335F73);

		var tf = new TextField();
		tf.defaultTextFormat = new TextFormat("_sans", 11, 0x666666);
		tf.text 	= title + " ";
		tf.height 	= tf.textHeight + 4;
		tf.width 	= tf.textWidth 	+ 4;
		tf.y 		= 4 - tf.height;
		addChild(tf);
	}

	public function update() {
		graphics.moveTo(px, H - py);
		graphics.lineTo(px = nx, H - (py = ny));
	}
}
