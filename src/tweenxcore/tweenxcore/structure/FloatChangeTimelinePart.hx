package tweenxcore.structure;
import haxe.ds.Option;

class FloatChangeTimelinePart extends FloatChangePart
{
    @:deprecated("use isMinorChange")
    @:noCompletion
    @:noDoc
    public var isMinerChange(get, never):Bool;
    private function get_isMinerChange():Bool {
        return isMinorChange;
    }
    
    public var isMinorChange(default, null):Bool;
    public var index(default, null):Int;
    public var rangeLeft(default, null):Float;
    public var rangeRight(default, null):Float;

    public inline function new (previousValue:Float, currentValue:Float, index:Int, rangeLeft:Float, rangeRight:Float, isMinorChange:Bool)
    {
        super(previousValue, currentValue);
        this.index = index;
        this.rangeLeft = rangeLeft;
        this.rangeRight = rangeRight;
        this.isMinorChange = isMinorChange;
    }
}
