package tweenxcore.expr;

enum SimpleEasingKind 
{
	Linear;
	Standard(easing:StandardEasingKind, inOut:InOutKind);
	Bezier(controls:Array<Float>);
}
