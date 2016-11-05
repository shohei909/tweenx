package tweenxcore.expr;

enum BinaryOpKind 
{
    Composite;
    Multiply;
    Mix(strength:Float);
    Connect(switchTime:Float, switchValue:Float);
    OneTwo(switchTime:Float);
    Op(easing:ComplexEasingKind, operation:TernaryOpKind);
}
