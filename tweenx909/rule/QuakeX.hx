package tweenx909.rule;
import tweenx909.TweenX;

/**
 * ...
 * @author shohei909
 */

class QuakeX {
	static public var inputClass(default,null):Dynamic = QuakeX;
	static public function calc(_from:QuakeX, _to:QuakeX, t1:Float, t2:Float, tween:TweenX):Float {
		var p:Float = 
			if ( t1 < 0.5 )	 _from.ease( t1 * 2 );
			else				_to.ease( t2 * 2 );
		return _from.value * t2 + _to.value * t1 + p * (Math.random() * 2 - 1) * (_from.scale * t2 + _to.scale * t1);
	}
	static public function defaultFrom( value:Float, _to:QuakeX, tween:TweenX ):QuakeX { 
		return new QuakeX( value, _to.scale, _to.ease ); 
	} 
	
	public var ease:Float->Float;
	public var value:Float;
	public var scale:Float;
	
	public function new( value:Float, scale:Float, ?ease:Float->Float ) {
		this.value = value;
		this.scale = scale;
		if ( ease == null )	 	this.ease = none;
		else					this.ease = ease;
	}
	function none( t:Float ) { return t <= 0 ? 0 : 1; }
}