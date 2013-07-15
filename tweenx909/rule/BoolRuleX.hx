package tweenx909.rule;
import tweenx909.TweenX;

/**
 * Bool値に対するルール。
 * falseを0,trueを1とみなしてトゥイーンした後、
 * 0以下の数値をfalse、その他の数値をtrueとみなしてターゲットに値を反映
 * @author shohei909
 */

class BoolRuleX{
	static public var inputClass(default,null):Dynamic = Bool;
	static public function calc(from:Bool, to:Bool, t1:Float, t2:Float, tween:TweenX ):Bool {
		return 0 < (from?1:0) * t2 + (to?1:0) * t1;
	}
	static public function defaultFrom( value:Bool, to:Bool, tween:TweenX ):Bool { return value; }
}