import nme.display.Sprite;
import nme.display.Shape;
import nme.geom.Matrix;
import tweenx909.rule.QuakeX;

import tweenx909.TweenX;
import tweenx909.EaseX;
using tweenx909.ChainX;

class Main extends Sprite {
	static inline var CELL_SIZE = 20;
	public function new() {
		super();
		
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
		
		//Make square
		var square = new Square( CELL_SIZE * 2 );
		addChild( square );
		square.y = CELL_SIZE * 9;
		
		//Tween!!
		TweenX.from( square, { x:180, y:180 } );
		TweenX.to( square, { 
							x:new QuakeX( 180, 80, EaseX.linear ), 
							y:new QuakeX( 180, 80, EaseX.linear ) 
						}).time( 2 );
	}
}

private class Square extends Shape {
	public function new( size:Float ) {
		super();
		graphics.beginFill( 0x335F73 );
		graphics.drawRect( 0, 0, size, size );
	}
}