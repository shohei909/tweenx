import nme.display.Sprite;
import nme.display.Shape;
import nme.display.StageScaleMode;
import nme.geom.Matrix;
import nme.Lib;
import tweenx909.rule.HsvX;
import tweenx909.rule.RgbX;

import tweenx909.TweenX;
import tweenx909.EaseX;
using tweenx909.ChainX;

class Main extends Sprite {
	static inline var CELL_SIZE = 20;
	public function new() {
		super();
		Lib.current.stage.scaleMode = StageScaleMode.SHOW_ALL;
		
		//Draw background
		graphics.lineStyle( 1, 0xEEEEEE );
		var end = CELL_SIZE * 20;
		for ( i in 0...21 ) {
			var p = i * CELL_SIZE;
			graphics.moveTo( 0, p );
			graphics.lineTo( end, p );
			graphics.moveTo( p, 0 );
			graphics.lineTo( p, end );
		}
		
		//Tween!!
		function draw( x:Float, y:Float, color:Int ) {
			graphics.beginFill( color );
			graphics.drawRect( x, y, 8, 40 );
		}
		
		TweenX.serial([
			TweenX.tweenFunc( draw, [0, 100, RgbX.of( 0x3373EE ) 	], [380, 100, RgbX.of( 0xEE7333 ) 	] ),
			TweenX.tweenFunc( draw, [0, 180, HsvX.of( 0x3373EE ) 	], [380, 180, HsvX.of( 0xEE7333 ) 	] ),
			TweenX.tweenFunc( draw, [0, 260, new HsvX( 0,0.7,0.9 ) 	], [380, 260, new HsvX( 2,0.7,0.9 )	] ),
		]);
	}
}