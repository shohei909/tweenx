package tweenxcore.expr;

enum SimpleEasingKind 
{
    Linear;
    Standard(easing:StandardEasingKind, inOut:InOutKind);
    Line(kind:LineKind, controls:Array<Float>);
}
