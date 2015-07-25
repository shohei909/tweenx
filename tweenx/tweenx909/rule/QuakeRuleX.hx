package tweenx909.rule;
import tweenx909.TweenX;

/**
 * ...
 * @author shohei909
 */

class QuakeRuleX {
	public static var inputClass(default,null):Dynamic = QuakeRuleX;
	public static function calc(_from:QuakeRuleX, _to:QuakeRuleX, t1:Float, t2:Float, tween:TweenX):Float {
		var p:Float = 
			if (t1 < 0.5)  _from.ease(t1 * 2);
			else				_to.ease(t2 * 2);
		return _from.value * t2 + _to.value * t1 + p * (Math.random() * 2 - 1) * (_from.scale * t2 + _to.scale * t1);
	}
	public static function defaultFrom(value:Float, _to:QuakeRuleX, tween:TweenX):QuakeRuleX { 
		return new QuakeRuleX(value, _to.scale, _to.ease); 
	} 
	
	public var ease:Float->Float;
	public var value:Float;
	public var scale:Float;
	
	public function new(value:Float, scale:Float, ease:Float->Float = null) {
		this.value = value;
		this.scale = scale;
		if (ease == null) this.ease = EaseX.warpOut;
		else this.ease = ease;
	}
}