package tweenx909.rule;
using tweenxcore.Tools.Easing;

/**
 * ...
 * @author shohei909
 */
class QuakeX
{
    public var ease:Float->Float;
    public var value:Float;
    public var scale:Float;

    public function new(value:Float, scale:Float, ease:Float->Float = null) {
        this.value = value;
        this.scale = scale;
        if (ease == null) this.ease = Easing.warpOut;
        else this.ease = ease;
    }
}
