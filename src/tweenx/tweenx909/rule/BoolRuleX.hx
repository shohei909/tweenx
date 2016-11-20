package tweenx909.rule;
import tweenx909.TweenX;

/**
 * Bool値に対するルール。
 * falseを0,trueを1とみなしてトゥイーンした後、
 * 0以下の数値をfalse、その他の数値をtrueとみなしてターゲットに値を反映
 * @author shohei909
 */

class BoolRuleX{
    public static var inputClass(default,null):Dynamic = Bool;
    public static function calc(_from:Bool, _to:Bool, t1:Float, t2:Float, tween:TweenX):Bool {
        return 0 < (_from?1:0) * t2 + (_to?1:0) * t1;
    }
    public static function defaultFrom(value:Bool, _to:Bool, tween:TweenX):Bool { return value; }
}
