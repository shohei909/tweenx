package tweenx909.rule;
import tweenx909.TweenX;

/**
 * ...
 * @author shohei909
 */
class ArgbX {
	public var a:Float;
	public var r:Float;
	public var g:Float;
	public var b:Float;
	
	public function new( alpha:Float, red:Float, green:Float, blue:Float ) {
		this.a = alpha;
		this.r = red; 
		this.g = green; 
		this.b = blue;
	}
	
	static public var inputClass(default, null):Dynamic = ArgbX;
	static public function calc(from:ArgbX, to:ArgbX, t1:Float, t2:Float, tween:TweenX) {
		var a = Std.int( (from.a * t2 + to.a * t1) * 0xFF );
		if ( a < 0 ) 		a = 0;
		else if( a > 0xFF )	a = 0xFF;
		
		var r = Std.int( (from.r * t2 + to.r * t1) * 0xFF );
		if ( r < 0 ) 		r = 0;
		else if( r > 0xFF )	r = 0xFF;
		
		var g = Std.int( (from.g * t2 + to.g * t1) * 0xFF );
		if ( g < 0 ) 		g = 0;
		else if( g > 0xFF )	g = 0xFF;
		
		var b = Std.int( (from.b * t2 + to.b * t1) * 0xFF );
		if ( b < 0 ) 		b = 0;
		else if( b > 0xFF )	b = 0xFF;
		
		return a << 24 | r << 16 | g << 8 | b;
	}
	static public function defaultFrom( value:Int, to:ArgbX, tween:TweenX ) { 
		return ArgbX.of( value );
	}
	
	static public function of( color:Int ) {
		return new ArgbX(
			((color >>> 24) & 0xFF) / 0xFF,
			((color >> 16) & 0xFF) / 0xFF,
			((color >> 08) & 0xFF) / 0xFF,
			(color & 0xFF) / 0xFF
		);
	}
}