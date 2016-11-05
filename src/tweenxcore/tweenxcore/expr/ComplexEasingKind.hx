package tweenxcore.expr;

enum ComplexEasingKind 
{
    Simple(kind:SimpleEasingKind);
    Op(easing:ComplexEasingKind, operation:UnaryOpKind);
}

