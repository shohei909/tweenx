package core;
import component.basic.RateId;
import component.complex.ComplexEasingId;
import core.easing.EasingCommand;
import core.output.OutputMode;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.InOutKind;

enum GlobalCommand 
{
	ChangeEasing(id:ComplexEasingId, command:EasingCommand);
	ChangeAnimationTime(rate:Float);
	ChangeOutputMode(mode:OutputMode);
}
