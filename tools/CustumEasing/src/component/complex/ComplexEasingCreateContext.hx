package component.complex;
import tweenxcore.expr.BinaryOpKind;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.InOutKind;
import tweenxcore.expr.SimpleEasingKind;
import tweenxcore.expr.StandardEasingKind;
import tweenxcore.expr.UnaryOpKind;

class ComplexEasingCreateContext 
{
    private var prevEasing:ComplexEasingKind;

    public function new(prevEasing:ComplexEasingKind) 
    {
        this.prevEasing = prevEasing;
    }
    
    public function getInOut():InOutKind
    {
        return _getInOut(prevEasing);
    }
    
    private static function _getInOut(easing:ComplexEasingKind):InOutKind
    {
        return switch (easing)
        {
            case ComplexEasingKind.Op(nextEasing, _):
                _getInOut(nextEasing);
                
            case ComplexEasingKind.Simple(SimpleEasingKind.Standard(_, inOut)):
                inOut;
                
            case ComplexEasingKind.Simple(_):
                InOutKind.In;
        }
    }
    
    public function getEasing():ComplexEasingKind
    {
        return prevEasing;
    }    
    
    public function getControls():Array<Float>
    {
        return _getControls(prevEasing);
    }
    
    private static function _getControls(easing:ComplexEasingKind):Array<Float>
    {
        return switch (easing)
        {
            case ComplexEasingKind.Op(nextEasing, _):
                _getControls(nextEasing);
                
            case ComplexEasingKind.Simple(SimpleEasingKind.Line(_, controls)):
                controls.copy();
                
            case ComplexEasingKind.Simple(_):
                [0, 0, 1, 1];
        }
    }
    
    
}