package tweenxcore.expr;

enum UnaryOpKind 
{
	Repeat(count:Int);
	Lerp(from:Float, to:Float);
	Clamp(min:Float, max:Float);
	RoundTrip(kind:RoundTripKind);
	Op(easing:ComplexEasingKind, operation:BinaryOpKind);
}
