package tweenxcore.structure;
using tweenxcore.Tools;

class TimelineSearchResult<T>{
    public var data(default, null):T;
    public var index(default, null):Int;
    public var rangeLeft(default, null):Float;
    public var rangeRight(default, null):Float;

    public inline function new(data:T, index:Int, rangeLeft:Float, rangeRight:Float) {
        this.data = data;
        this.index = index;
        this.rangeLeft = rangeLeft;
        this.rangeRight = rangeRight;
    }

    public inline function innerRate(rate:Float)
    {
        return rate.inverseLerp(rangeLeft, rangeRight);
    }
}
