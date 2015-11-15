package tweenx909.rule;
import tweenxcore.color.RgbColor;
import tweenx909.TweenX;

/**
 * ...
 * @author shohei909
 */
class RgbRuleX {
    public static var inputClass(default, null):Dynamic = RgbColor;

    public static function calc(_from:RgbColor, _to:RgbColor, t1:Float, t2:Float, tween:TweenX):Int {
        var r = _from.r * t2 + _to.r * t1;
        var g = _from.g * t2 + _to.g * t1;
        var b = _from.b * t2 + _to.b * t1;
        return RgbColor.rgbToInt(r, g, b);
    }

    public static function defaultFrom(value:Int, _to:RgbColor, tween:TweenX):RgbColor {
        return RgbColor.of(value);
    }
}
