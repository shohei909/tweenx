package core;
import component.basic.RateId;
import component.complex.ComplexEasingId;
import core.output.OutputMode;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.InOutKind;

enum GlobalCommand 
{
	ChangeEasing(id:ComplexEasingId, easing:ComplexEasingKind);
	ChangeInOut(id:ComplexEasingId, inOut:InOutKind);
	ChangeRate(id:RateId, rate:Float);
	ChangeAnimationTime(rate:Float);
	ChangeOutputMode(mode:OutputMode);
}
