package core.easing;
import component.basic.RateId;
import component.complex.ComplexEasingId;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.InOutKind;

enum EasingCommand 
{
    Replace(easing:ComplexEasingKind);
    InOut(inOut:InOutKind);
    Rate(index:Int, rate:Float);
    AddRate(index:Int);
    RemoveRate(index:Int);
    Move(fromId:ComplexEasingId);
    Paste(fromId:ComplexEasingId);
}