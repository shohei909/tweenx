package tweenxcore.structure;
import haxe.ds.Option;

class FloatChangeRepeatPart extends FloatChangePart
{
    public var isMinerChange(default, null):Bool;
    public var repeatIndex(default, null):Float;
    public var repeatLimit(default, null):Int;

    public inline function new (previousValue:Float, currentValue:Float, repeatIndex:Int, repeatLimit:Int, isMinerChange:Bool)
    {
        super(previousValue, currentValue);
        this.repeatIndex = repeatIndex;
        this.repeatLimit = repeatLimit;
        this.isMinerChange = isMinerChange;
    }

    public inline function isFirstEntrance():Bool {
        return (repeatIndex == 0 && previous <= 0 && 0 < current) ||
            (repeatIndex == repeatLimit - 1 && current < 1.0 && 1.0 <= previous);
    }

    public inline function isLastExit():Bool {
        return (repeatIndex == 0 && current <= 0.0 && 0.0 < previous) ||
            (repeatIndex == repeatLimit - 1 && previous < 1.0 && 1.0 <= current);
    }
}
