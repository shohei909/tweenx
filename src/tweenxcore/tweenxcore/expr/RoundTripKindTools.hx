package tweenxcore.expr;
import haxe.macro.Expr.ExprOf;
import tweenxcore.expr.ComplexEasingKind;
using tweenxcore.expr.ComplexEasingKindTools;
using tweenxcore.Tools.FloatTools;

class RoundTripKindTools 
{

    public static inline function toFunction(kind:RoundTripKind, easing:ComplexEasingKind):Float->Float
    {
        return switch (kind)
        {
            case RoundTripKind.Yoyo:
                var func = easing.toFunction();
                function (value:Float):Float
                {
                    return value.yoyo(func);
                }
                
            case RoundTripKind.Zigzag:
                var func = easing.toFunction();
                function (value:Float):Float
                {
                    return value.zigzag(func);
                }
        }
    }    
    
    public static function toExpr(kind:RoundTripKind, easing:ComplexEasingKind, valueExpr:ExprOf<Float>):ExprOf<Float>
    {
        return switch (kind)
        {
            case RoundTripKind.Yoyo:
                var expr = easing.toFunctionExpr();
                macro tweenxcore.Tools.FloatTools.yoyo($valueExpr, $expr);
                
            case RoundTripKind.Zigzag:
                var expr = easing.toFunctionExpr();
                macro tweenxcore.Tools.FloatTools.zigzag($valueExpr, $expr);
        }
    }
    
    public static function toFunctionExpr(kind:RoundTripKind, easing:ComplexEasingKind):ExprOf<Float->Float>
    {
        return switch (kind)
        {
            case RoundTripKind.Yoyo:
                var expr = easing.toFunctionExpr();
                macro tweenxcore.Tools.FloatTools.yoyo.bind(_, $expr);
                
            case RoundTripKind.Zigzag:
                var expr = easing.toFunctionExpr();
                macro tweenxcore.Tools.FloatTools.zigzag.bind(_, $expr);
        }
    }
}
