package tweenx909.advanced;
import tweenx909.TweenX;

/** @private */
@:noCompletion
class GroupX {
    public var current:Float = 0;
    public var tweens:Array<TweenX>;
    public var source:Iterable<CommandX>;
    public var type:GroupTypeX;
    public var defaults:DefaultsX;

    public function new(source:Iterable<CommandX>, type:GroupTypeX, defaults:DefaultsX) {
        this.source     = source;
        this.type        = type;
        if (defaults != null) this.defaults = defaults.clone();
    }
}

private enum GroupTypeX {
    SERIAL;
    LAG(lag:Float);
}
