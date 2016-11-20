package tweenxcore.expr;

enum UnaryOpKind 
{
    Repeat(repeat:Float);
    Lerp(from:Float, to:Float);
    Clamp(min:Float, max:Float);
    RoundTrip(kind:RoundTripKind);
    Op(easing:ComplexEasingKind, operation:BinaryOpKind);
}
