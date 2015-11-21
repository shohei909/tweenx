package tweenxcore.structure;
import haxe.ds.Option;

class FloatChangeTimelinePart extends FloatChangePart
{
    public var isMinerChange(default, null):Bool;
    public var index(default, null):Float;
    public var rangeLeft(default, null):Float;
    public var rangeRight(default, null):Float;

    public inline function new (previousValue:Float, currentValue:Float, index:Int, rangeLeft:Float, rangeRight:Float, isMinerChange:Bool)
    {
        super(previousValue, currentValue);
        this.index = index;
        this.rangeLeft = rangeLeft;
        this.rangeRight = rangeRight;
    }
}
