package tweenx909.rule;
import tweenxcore.color.HsvColor;
import tweenx909.TweenX;

/**
 * ...
 * @author shohei909
 */
class HsvRuleX {
    public static var inputClass(default, null):Dynamic = HsvColor;

    public static function calc(_from:HsvColor, _to:HsvColor, t1:Float, t2:Float, tween:TweenX):Int {
        var h = _from.h * t2 + _to.h * t1;
        var s = _from.s * t2 + _to.s * t1;
        var v = _from.v * t2 + _to.v * t1;

        return HsvColor.hsvToRgbInt(h, s, v);
    }

    public static function defaultFrom(value:Int, _to:HsvColor, tween:TweenX) {
        return HsvColor.of(value);
    }
}
