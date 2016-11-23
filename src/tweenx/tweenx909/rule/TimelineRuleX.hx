package tweenx909.rule;
import tweenx909.TweenX;
import tweenxcore.structure.BoundaryMode;
import tweenxcore.structure.Timeline;
import tweenxcore.structure.TimelineSearchResult;

/**
 * @author shohei909
 */
class TimelineRuleX {
    public static var inputClass(default, null):Dynamic = Timeline;

    public static function calc(_from:Searchable, _to:Searchable, t1:Float, t2:Float, tween:TweenX):Dynamic {
        return _to.search(t1).data;
    }

    public static function defaultFrom(value:Dynamic, _to:Timeline<Dynamic>, tween:TweenX):Dynamic { return null; }
}

private typedef Searchable = {
    public function search(rate:Float, ?boundaryMode:BoundaryMode):TimelineSearchResult<Dynamic>;
}
