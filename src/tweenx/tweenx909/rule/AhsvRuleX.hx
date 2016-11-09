package tweenx909.rule;
import tweenxcore.color.AhsvColor;
import tweenx909.TweenX;

/**
 * ...
 * @author shohei909
 */
class AhsvRuleX {
    public static var inputClass(default, null):Dynamic = AhsvColor;

    public static function calc(_from:AhsvColor, _to:AhsvColor, t1:Float, t2:Float, tween:TweenX):Int {
        var a = _from.a * t2 + _to.a * t1;
        var h = _from.h * t2 + _to.h * t1;
        var s = _from.s * t2 + _to.s * t1;
        var v = _from.v * t2 + _to.v * t1;

        return AhsvColor.ahsvToArgbInt(a, h, s, v);
    }

    public static function defaultFrom(value:Int, _to:AhsvColor, tween:TweenX) {
        return AhsvColor.of(value);
    }
}
