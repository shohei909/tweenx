package tweenxcore.structure;
import haxe.ds.Option;

class FloatChangeRepeatPart extends FloatChangePart
{
    @:deprecated("use isMinorChange")
    @:noCompletion
    @:noDoc
    public var isMinerChange(get, never):Bool;
    private function get_isMinerChange():Bool {
        return isMinorChange;
    }
    
    public var isMinorChange(default, null):Bool;
    public var repeatIndex(default, null):Int;
    public var repeatLength(default, null):Int;

    public inline function new (previousValue:Float, currentValue:Float, repeatIndex:Int, repeatLength:Int, isMinorChange:Bool)
    {
        super(previousValue, currentValue);
        this.repeatIndex = repeatIndex;
        this.repeatLength = repeatLength;
        this.isMinorChange = isMinorChange;
    }

    public inline function isFirstEntrance():Bool {
        return (repeatIndex == 0 && previous <= 0 && 0 < current) ||
            (repeatIndex == repeatLength - 1 && current < 1.0 && 1.0 <= previous);
    }

    public inline function isLastExit():Bool {
        return (repeatIndex == 0 && current <= 0.0 && 0.0 < previous) ||
            (repeatIndex == repeatLength - 1 && previous < 1.0 && 1.0 <= current);
    }
}
