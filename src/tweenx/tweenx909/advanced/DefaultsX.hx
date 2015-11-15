package tweenx909.advanced;
import tweenx909.TweenX;

/**
 * ...
 * @author shohei909
 */
class DefaultsX {
    private var _ease:Float->Float;
    private var _time:Float            = TweenX.DEFAULT_TIME;
    private var _delay:Float        = TweenX.DEFAULT_DELAY;
    private var _interval:Float        = TweenX.DEFAULT_INTERVAL;
    private var _repeat:Int            = TweenX.DEFAULT_REPEAT;
    private var _yoyo:Bool            = TweenX.DEFAULT_YOYO;
    private var _zigzag:Bool        = TweenX.DEFAULT_ZIGZAG;
    private var _autoPlay:Bool        = TweenX.DEFAULT_AUTO_PLAY;
    //private var _autoFrom:Bool    = TweenX.DEFAULT_AUTO_FROM;

    public function new() {
        _ease = TweenX.DEFAULT_EASE;
    }

    public function dump() {
        _time        = TweenX.defaultTime;
        _ease        = TweenX.defaultEase;
        _delay        = TweenX.defaultDelay;
        _interval    = TweenX.defaultInterval;
        _repeat        = TweenX.defaultRepeat;
        _yoyo        = TweenX.defaultYoyo;
        _zigzag        = TweenX.defaultZigZag;
        _autoPlay    = TweenX.defaultAutoPlay;
        //_autoFrom    = TweenX.defaultAutoFrom;
        return this;
    }

    public function apply() {
        TweenX.defaultTime        = _time;
        TweenX.defaultEase        = _ease;
        TweenX.defaultDelay     = _delay;
        TweenX.defaultInterval     = _interval;
        TweenX.defaultRepeat     = _repeat;
        TweenX.defaultYoyo         = _yoyo;
        TweenX.defaultZigZag     = _zigzag;
        TweenX.defaultAutoPlay     = _autoPlay;
        //TweenX.defaultAutoFrom    = _autoFrom;
    }

    public function clone() {
        var child = new DefaultsX();

        child._time            = _time;
        child._ease            = _ease;
        child._delay        = _delay;
        child._interval        = _interval;
        child._repeat        = _repeat;
        child._yoyo            = _yoyo;
        child._zigzag        = _zigzag;
        child._autoPlay        = _autoPlay;
        //child._autoFrom        = _autoFrom;

        return child;
    }

    public function time(value:Float) {
        _time = value;
        return this;
    }
    public function ease(value:Float->Float) {
        _ease = value;
        return this;
    }
    public function delay(value:Float) {
        _delay = value;
        return this;
    }
    public function interval(value:Float) {
        _interval = value;
        return this;
    }
    public function repeat(value:Int = 0) {
        _repeat = value;
        return this;
    }
    public function yoyo(value:Bool = true) {
        _yoyo = value;
        return this;
    }
    public function zigzag(value:Bool = true) {
        _zigzag = value;
        return this;
    }
    public function autoPlay(value:Bool = true) {
        _autoPlay = value;
        return this;
    }

    /*public function autoFrom(value:Bool = true) {
        _autoFrom = value;
        return this;
    }*/
}
