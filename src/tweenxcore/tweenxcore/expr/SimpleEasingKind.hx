package tweenxcore.expr;

enum SimpleEasingKind 
{
	Linear;
	Standard(easing:StandardEasingKind, inOut:InOutKind);
	Polyline(kind:PolylineKind, controls:Array<Float>);
}
