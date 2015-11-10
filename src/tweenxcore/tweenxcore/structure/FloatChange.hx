package tweenxcore.structure;
import haxe.ds.Option;
using tweenxcore.tools.Tools;

class FloatChange {

    // ===============
    // Properties
    // ===============

    public var previous(default, null):Float;
    public var current(default, null):Float;

    public inline function new(previousValue:Float, currentValue:Float) {
        this.previous = previousValue;
        this.current = currentValue;
    }

    // ===============
    // Methods
    // ===============

    public inline function direction():Direction {
        return if (previous < current) {
            Direction.Forward;
        } else if (current < previous) {
            Direction.Backward;
        } else {
            Direction.Stopped;
        }
    }

    public inline function map(func:Float->Float)
    {
        return new FloatChange(func(previous), func(current));
    }

    public inline function part(from:Float, to:Float, updatePart:FloatChangePart->Void):Void
    {
        if (from < to) {
            _part(
                previous,
                current,
                from,
                to,
                updatePart
            );
        } else if (from > to) {
            _part(
                -previous,
                -current,
                -from,
                -to,
                updatePart
            );
        }
    }

    static inline function _part(
        previous:Float,
        current:Float,
        from:Float,
        to:Float,
        updatePart:FloatChangePart->Void)
    {
        if ((from < previous && previous < to) || (from < current && current < to)) {
            updatePart(
                new FloatChangePart(
                    previous.inverseLerp(from, to).clamp(),
                    current.inverseLerp(from, to).clamp()
                )
            );
        }
    }
}
