package tweenx909.rule;
import tweenxcore.color.ArgbColor;
import tweenx909.TweenX;

/**
 * ...
 * @author shohei909
 */
class ArgbRuleX {
    public static var inputClass(default, null):Dynamic = ArgbColor;

    public static function calc(_from:ArgbColor, _to:ArgbColor, t1:Float, t2:Float, tween:TweenX):Int {
        var a = _from.a * t2 + _to.a * t1;
        var r = _from.r * t2 + _to.r * t1;
        var g = _from.g * t2 + _to.g * t1;
        var b = _from.b * t2 + _to.b * t1;

        return ArgbColor.argbToInt(a, r, g, b);
    }

    public static function defaultFrom(value:Int, _to:ArgbColor, tween:TweenX) {
        return ArgbColor.of(value);
    }
}
