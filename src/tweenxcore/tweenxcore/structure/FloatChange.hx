package tweenxcore.structure;
import tweenxcore.structure.FloatChangeRepeatPart;
import tweenxcore.structure.FloatChangeRepeatPart;
using tweenxcore.Tools;

/**
 * Change of Float
 */
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

    public inline function direction():Direction 
    {
        return if (previous < current) {
            Direction.Forward;
        } else if (current < previous) {
            Direction.Backward;
        } else {
            Direction.Stopped;
        }
    }

    public function mapFloatChange(func:Float->Float):FloatChange
    {
        return new FloatChange(func(previous), func(current));
    }

    public function isCrossOver(threshold:Float, boundaryMode:BoundaryMode = BoundaryMode.High):Bool
    {
        return switch (boundaryMode) {
            case BoundaryMode.Low:
                (previous < threshold && threshold <= current) || (current < threshold && threshold <= previous);

            case BoundaryMode.High:
                (previous <= threshold && threshold < current) || (current <= threshold && threshold < previous);
        }
    }

    
    
    public inline function handlePart(from:Float, to:Float, updatePart:FloatChangePart->Void):Void
    {
        if (
            (
                (from < previous && current < to) ||
                (from < current && previous < to) ||
                (to < previous && current < from) ||
                (to < current && previous < from)
            ) &&
            (previous != current)
        ) {
            updatePart(
                new FloatChangePart(
                    previous.inverseLerp(from, to).clamp(),
                    current.inverseLerp(from, to).clamp()
                )
            );
        }
    }

    public inline function handleRepeatPart(
        firstPartFrom:Float,
        firstPartTo:Float,
        repeatLimit:Int,
        updateRepeatPart:FloatChangeRepeatPart->Void):Void
    {
        if (firstPartFrom != firstPartTo) {
            var p = previous.inverseLerp(firstPartFrom, firstPartTo);
            var c = current.inverseLerp(firstPartFrom, firstPartTo);

            if ((0 < c && p < repeatLimit) || (0 < p && c < repeatLimit)) {
                inline function update(previousValue:Float, currentValue:Float, index:Int, minor:Bool) {
                    if (previousValue != currentValue) {
                        updateRepeatPart(new FloatChangeRepeatPart(previousValue, currentValue, index, repeatLimit, minor));
                    }
                }

                p = p.clamp(0, repeatLimit);
                c = c.clamp(0, repeatLimit);

                var pCount = Std.int(p);
                var cCount = Std.int(c);
                var hasNext = true;

                if (p < c) {
                    do {
                        if (cCount == pCount) {
                            update(p - pCount, c - pCount, pCount, hasNext = false);
                        } else {
                            hasNext = (pCount + 1 != c);
                            update(p - pCount, 1, pCount, hasNext);
                        }
                        p = (pCount += 1);
                    } while (hasNext);
                } else {
                    do {
                        if (pCount == cCount) {
                            update(p - pCount, c - pCount, pCount, hasNext = false);
                        } else {
                            hasNext = (pCount - 1 != c);
                            update(p - pCount, 0, pCount, hasNext);
                        }
                        p = pCount;
                        pCount -= 1;
                    } while (hasNext);
                }
            }
        }
    }

    public inline function handleTimelinePart(
        timelineFrom:Float,
        timelineTo:Float,
        updatePartTimeline:Timeline<FloatChangeTimelinePart->Void>):Void
    {
        if (timelineFrom != timelineTo) {
            var p = previous.inverseLerp(timelineFrom, timelineTo);
            var c = current.inverseLerp(timelineFrom, timelineTo);
            if ((0 < p && c < 1) || (0 < c && p < 1)) {
                var length = updatePartTimeline.length;
                inline function update(previousValue:Float, currentValue:Float, index:Int, isMinor:Bool) {
                    var part = new FloatChangeTimelinePart(
                        previousValue,
                        currentValue,
                        index,
                        updatePartTimeline.rangeLeft(index),
                        updatePartTimeline.rangeRight(index),
                        isMinor
                    );
                    updatePartTimeline.dataAt(index)(part);
                }
                p = p.clamp(0, 1);
                c = c.clamp(0, 1);

                var pResult = updatePartTimeline.search(p);
                var cResult = updatePartTimeline.search(c);
                var pCount = pResult.index;
                var cCount = cResult.index;
                var pRate = pResult.innerRate(p);
                var cRate = cResult.innerRate(c);
                var hasNext = false;

                if (p < c) {
                    do {
                        if (pCount == cCount) {
                            update(pRate, cRate, pCount, hasNext = false);
                        } else {
                            hasNext = (pCount + 1 != cCount) || (cRate != 0);
                            update(pRate, 1, pCount, hasNext);
                        }
                        pRate = 0;
                        pCount += 1;
                    } while (hasNext);
                } else {
                    do {
                        if (pCount == cCount) {
                            update(pRate, cRate, pCount, hasNext = false);
                        } else {
                            hasNext = (pCount - 1 != cCount) || (cRate != 1);
                            update(pRate, 0, pCount, hasNext);
                        }
                        pRate = 1;
                        pCount -= 1;
                    } while (hasNext);
                }
            }
        }
    }
}
