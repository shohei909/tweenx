package tweenxcore.structure;


class FloatChangePart extends FloatChange {
    public inline function isEntrance():Bool {
        return (previous <= 0 && 0 < current) || (current < 1.0 && 1.0 <= previous);
    }

    public inline function isExit():Bool {
        return (current <= 0.0 && 0.0 < previous) || (previous < 1.0 && 1.0 <= current);
    }
}
