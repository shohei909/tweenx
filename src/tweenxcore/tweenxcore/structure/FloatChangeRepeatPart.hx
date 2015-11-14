package tweenxcore.structure;
import haxe.ds.Option;

class FloatChangeRepeatPart extends FloatChangePart
{
    public var isMinerChange(default, null):Bool;
    public var repeatCount(default, null):Float;
    public var repeatLimit(default, null):Int;

    public inline function new (previousValue:Float, currentValue:Float, repeatCount:Int, repeatLimit:Int, isMinerChange:Bool)
    {
        super(previousValue, currentValue);
        this.repeatCount = repeatCount;
        this.repeatLimit = repeatLimit;
        this.isMinerChange = isMinerChange;
    }

    public inline function isRepeatPartEntrance():Bool {
        return (repeatCount == 0 && previous <= 0 && 0 < current) ||
            (repeatCount == repeatLimit - 1 && current < 1.0 && 1.0 <= previous);
    }

    public inline function isRepeatPartExit():Bool {
        return (repeatCount == 0 && current <= 0.0 && 0.0 < previous) ||
            (repeatCount == repeatLimit - 1 && previous < 1.0 && 1.0 <= current);
    }
}
