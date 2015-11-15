package tweenx909.rule;
import tweenx909.TweenX;

/**
 * ...
 * @author shohei909
 */
typedef RuleX<T1,T2> = {
    public var inputClass(default,null):Dynamic;
    public function calc(_from:T1, _to:T1, t1:Float, t2:Float,tween:TweenX):T2;
    public function defaultFrom(value:T2, _to:T1, tween:TweenX):T1;
}
