package tweenxcore.expr;

enum ComplexEasingKind 
{
	Leaf(kind:SimpleEasingKind);
	Op(easing:ComplexEasingKind, operation:UnaryOpKind);
}

