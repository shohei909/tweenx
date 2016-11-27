package tweenxcore.expr;
import haxe.macro.Expr.ExprOf;
import tweenxcore.Tools.FloatTools;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ExprMaker.ExprMakeTools;
using tweenxcore.expr.ComplexEasingKindTools;

class TernaryOpKindTools 
{

    public static inline function toFunction(kind:TernaryOpKind, easing1:ComplexEasingKind, easing2:ComplexEasingKind, easing3:ComplexEasingKind):Float->Float
    {
        return switch (kind)
        {
            case TernaryOpKind.Crossfade(start, end):
                var func1 = easing1.toFunction();
                var func2 = easing2.toFunction();
                var func3 = easing3.toFunction();
                FloatTools.crossfadeEasing.bind(_, func1, func2, func3, start, end);
        }
    }
    
    public static function toJsonable(kind:TernaryOpKind):Dynamic
    {
        return switch (kind)
        {
            case TernaryOpKind.Crossfade(start, end):
                ["Crossfade", start, end];
        }
    }
    
    public static function fromJsonable(data:Dynamic):TernaryOpKind
    {
        return switch (data)
        {
            case ["Crossfade", start, end]:
                TernaryOpKind.Crossfade(cast(start, Float), cast(end, Float));
                
            case _:
                throw "unsupported TernaryOpKind data: " + data;
        }
    }
    
    public static function toExpr(kind:TernaryOpKind, easing1:ComplexEasingKind, easing2:ComplexEasingKind, easing3:ComplexEasingKind, valueExpr:ExprOf<Float>):ExprOf<Float>
    {
        return switch (kind)
        {
            case TernaryOpKind.Crossfade(start, end):
                var func1 = easing1.toFunctionExpr();
                var func2 = easing2.toFunctionExpr();
                var func3 = easing3.toFunctionExpr();
                macro tweenxcore.Tools.FloatTools.crossfadeEasing($valueExpr, $func1, $func2, $func3, ${ExprMakeTools.floatToExpr(start)}, ${ExprMakeTools.floatToExpr(end)});
        }
    }
    
    public static function toFunctionExpr(kind:TernaryOpKind, easing1:ComplexEasingKind, easing2:ComplexEasingKind, easing3:ComplexEasingKind):ExprOf<Float->Float> 
    {
        
        return switch (kind)
        {
            case TernaryOpKind.Crossfade(start, end):
                var func1 = easing1.toFunctionExpr();
                var func2 = easing2.toFunctionExpr();
                var func3 = easing3.toFunctionExpr();
                macro tweenxcore.Tools.FloatTools.crossfadeEasing.bind(_, $func1, $func2, $func3, ${ExprMakeTools.floatToExpr(start)}, ${ExprMakeTools.floatToExpr(end)});
        }
    }
}