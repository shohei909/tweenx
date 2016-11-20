package core;
import component.basic.RateId;
import component.complex.ComplexEasingId;
import core.easing.EasingCommand;
import core.localize.LocaleKind;
import core.output.OutputMode;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.InOutKind;

enum RootCommand 
{
    ChangeEasing(id:ComplexEasingId, command:EasingCommand);
    ChangeAnimationTime(rate:Float);
    ChangeOutputMode(mode:OutputMode);
    ChangeLocale(locale:LocaleKind);
}
