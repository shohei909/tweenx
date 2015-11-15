package tweenx909.rule;
import tweenx909.TweenX;

/**
 * @author shohei909
 */
class TimelineRuleX {
    public         var length(default, null):Float;
    private     var data:Array<Dynamic>;
    private     var timeline:Array<Float>;

    public function new(data:Iterable<Dynamic>, ?intervals:Iterable<Float>) {
        this.data     = Lambda.array(data);

        if (intervals == null){
            var arr:Array<Float> = [];
            for (i in 0...(this.data.length)) arr.push(i);
            this.timeline = arr;
        } else {
            var arr:Array<Float> = [];
            var n:Float = 0;
            for (i in intervals) arr.push(n += i);
            this.timeline = arr;
        }

        if (this.timeline.length != this.data.length) throw "times length must be same with data length.";
        length = timeline[timeline.length - 1 ] + 1;
    }

    public static var inputClass(default, null):Dynamic = TimelineRuleX;

    public static function calc(_from:TimelineRuleX, _to:TimelineRuleX, t1:Float, t2:Float, tween:TweenX) {
        var t    = t1 * _to.length;
        var ts     = _to.timeline;
        var l     = ts.length;
        var min = 0;
        var max = l;
        var n = (max >> 1);

        while (max - min > 1) {
            var val = ts[n ];
            if (t < val)     max = n;
            else            min = n;
            n = min + ((max - min) >> 1);
        }

        return _to.data[min ];
    }

    public static function defaultFrom(value:Dynamic, _to:TimelineRuleX, tween:TweenX) { return null; }
}
