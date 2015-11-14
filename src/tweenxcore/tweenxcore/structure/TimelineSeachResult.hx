package tweenxcore.structure;
using tweenxcore.Tools;

class TimelineSeachResult<T>{
    public var data(default, null):T;
    public var index(default, null):Int;
    public var baseRate(default, null):Float;
    public var nextRate(default, null):Float;

    public inline function new(data:T, index:Int, baseRate:Float, nextRate:Float) {
        this.data = data;
        this.index = index;
        this.baseRate = baseRate;
        this.nextRate = nextRate;
    }

    public inline function innerRate(rate:Float)
    {
        return rate.inverseLerp(baseRate, nextRate);
    }
}
