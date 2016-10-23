package tweenxcore.expr;

enum SimpleEasingKind 
{
	Linear;
	Curve(easing:StandardEasingKind, inOut:InOutKind);
	Bezier(controls:Array<Float>);
}
