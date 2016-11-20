package tweenxcore.expr;
import haxe.macro.Expr;
import tweenxcore.Tools.Easing;

class ComplexEasingKindTools 
{
    public static inline function toFunction(easing:ComplexEasingKind):Float->Float
    {
        return switch (easing)
        {
            case ComplexEasingKind.Simple(kind):
                SimpleEasingKindTools.toFunction(kind);
            
            case ComplexEasingKind.Op(easing, op):
                UnaryOpKindTools.toFunction(op, easing);
        }
    }    
    
    public static function toJsonable(easing:ComplexEasingKind):Dynamic
    {
        return switch (easing)
        {
            case ComplexEasingKind.Simple(kind):
                [
                    "Simple",
                    SimpleEasingKindTools.toJsonable(kind),
                ];
                
            case ComplexEasingKind.Op(easing, op):
                [
                    "Op",
                    ComplexEasingKindTools.toJsonable(easing),
                    UnaryOpKindTools.toJsonable(op),
                ];
        }
    }
    
    public static function fromJsonable(data:Dynamic):ComplexEasingKind
    {
        return switch (data)
        {
            case ["Simple", kind]:
                ComplexEasingKind.Simple(
                    SimpleEasingKindTools.fromJsonable(kind)
                );
                
            case ["Op", easing, op]:
                ComplexEasingKind.Op(
                    ComplexEasingKindTools.fromJsonable(easing),
                    UnaryOpKindTools.fromJsonable(op)
                );
                
            case _:
                throw "unsupported ComplexEasingKind data: " + data;
        }
    }
    
    public static function toExpr(easing:ComplexEasingKind, valueExpr:ExprOf<Float>):ExprOf<Float> 
    {
        return switch (easing)
        {
            case ComplexEasingKind.Simple(kind):
                SimpleEasingKindTools.toExpr(kind, valueExpr);
            
            case ComplexEasingKind.Op(easing, op):
                UnaryOpKindTools.toExpr(op, easing, valueExpr);
        }
    }
    
    public static function toFunctionExpr(easing:ComplexEasingKind):ExprOf<Float->Float> 
    {
        return switch (easing)
        {
            case ComplexEasingKind.Simple(kind):
                SimpleEasingKindTools.toFunctionExpr(kind);
            
            case ComplexEasingKind.Op(easing, op):
                UnaryOpKindTools.toFunctionExpr(op, easing);
        }
    }
}
