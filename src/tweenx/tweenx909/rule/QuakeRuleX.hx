package tweenx909.rule;

import tweenx909.EaseX;
import tweenx909.TweenX;
import tweenx909.rule.QuakeX;

/**
 * ...
 * @author shohei909
 */

class QuakeRuleX {
    public static var inputClass(default,null):Dynamic = QuakeX;
    public static function calc(_from:QuakeX, _to:QuakeX, t1:Float, t2:Float, tween:TweenX):Float {
        var p:Float =
            if (t1 < 0.5) _from.ease(t1 * 2);
            else _to.ease(t2 * 2);
        return _from.value * t2 + _to.value * t1 + p * (Math.random() * 2 - 1) * (_from.scale * t2 + _to.scale * t1);
    }
    public static function defaultFrom(value:Float, _to:QuakeX, tween:TweenX):QuakeX {
        return new QuakeX(value, _to.scale, _to.ease);
    }
}
