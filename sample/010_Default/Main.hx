import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.StageScaleMode;
import openfl.geom.Matrix;
import openfl.Lib;
import tweenx909.advanced.DefaultsX;

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
		square.y = CELL_SIZE * 9;
		
		
		//以下の各動作設定のデフォルト値です
		TweenX.defaultTime		= 0.3;
		TweenX.defaultEase		= EaseX.linear;
		TweenX.defaultDelay 	= 0;
		TweenX.defaultInterval 	= 0;
		TweenX.defaultRepeat 	= 1;
		TweenX.defaultYoyo 		= false;
		TweenX.defaultZigZag 	= false;
		TweenX.defaultAutoPlay 	= true; //トゥイーンの自動開始
		
		//現在のデフォルトを取得
		var defaults:DefaultsX = TweenX.dumpDefaults();
		
		//ダンプしたデフォルトの値を変更する
		defaults.ease(EaseX.bounceOut).time(1);
		
		//デフォルトを変更
		TweenX.setDefaults(defaults);
		
		//デフォルト値の初期化
		TweenX.initDefaults();
		
		//グループ化したトゥイーンの内部にデフォルト値を適用する。
		TweenX.serial([
			TweenX.to(square).x(360),
			TweenX.to(square).alpha(0),
		], defaults);
	}
}

private class Square extends Shape {
	public function new(size:Float) {
		super();

		graphics.beginFill(0x335F73);
		graphics.drawRect(0, 0, size, size);
	}
}