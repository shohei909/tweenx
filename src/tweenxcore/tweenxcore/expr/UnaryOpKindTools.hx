package tweenxcore.expr;
import haxe.EnumTools;
import haxe.EnumTools.EnumValueTools;
import haxe.macro.Context;
import haxe.macro.Expr;
import tweenxcore.Tools.Easing;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ExprMaker.ExprMakeTools;
import tweenxcore.expr.RoundTripKindTools;
using tweenxcore.Tools.FloatTools;
using tweenxcore.expr.ComplexEasingKindTools;

class UnaryOpKindTools 
{

    public static inline function toFunction(kind:UnaryOpKind, easing:ComplexEasingKind):Float->Float
    {
        return switch (kind)
        {
            case UnaryOpKind.Clamp(min, max):
                var func = easing.toFunction();
                function (rate:Float):Float
                {
                    return func(rate).clamp(min, max);
                }
                
            case UnaryOpKind.Lerp(from, to):
                var func = easing.toFunction();
                function (rate:Float):Float
                {
                    return func(rate).lerp(from, to);
                }
                
            case UnaryOpKind.Repeat(repeat):
                var func = easing.toFunction();
                function (rate:Float):Float
                {
                    return func(rate.lerp(0, repeat).repeat(0.0, 1.0));
                }
                
            case UnaryOpKind.RoundTrip(roundTrip):
                RoundTripKindTools.toFunction(roundTrip, easing);
                
            case UnaryOpKind.Op(easing2, op):
                BinaryOpKindTools.toFunction(op, easing, easing2);
        }
    }
    
    public static function toJsonable(kind:UnaryOpKind):Dynamic
    {
        return switch (kind)
        {
            case UnaryOpKind.Clamp(min, max):
                ["Clamp", min, max];
                
            case UnaryOpKind.Lerp(from, to):
                ["Lerp", from, to];
                
            case UnaryOpKind.Repeat(repeat):
                ["Repeat", repeat];
                
            case UnaryOpKind.RoundTrip(roundTrip):
                [
                    "RoundTrip", 
                    EnumValueTools.getName(roundTrip)
                ];
                
            case UnaryOpKind.Op(easing2, op):
                [
                    "Op", 
                    ComplexEasingKindTools.toJsonable(easing2),
                    BinaryOpKindTools.toJsonable(op),
                ];
        }
    }
    
    public static function fromJsonable(data:Dynamic):UnaryOpKind
    {
        return switch (data)
        {
            case ["Clamp", min, max]:
                UnaryOpKind.Clamp(cast(min, Float), cast(max, Float));
                
            case ["Lerp", from, to]:
                UnaryOpKind.Lerp(cast(from, Float), cast(to, Float));
                
            case ["Repeat", repeat]:
                UnaryOpKind.Repeat(cast(repeat, Float));
                
            case ["RoundTrip", roundTrip]:
                UnaryOpKind.RoundTrip(
                    EnumTools.createByName(RoundTripKind, roundTrip)
                );
                
            case ["Op", easing2, op]:
                UnaryOpKind.Op(
                    ComplexEasingKindTools.fromJsonable(easing2),
                    BinaryOpKindTools.fromJsonable(op)
                );
                
            case _:
                throw "unsupported UnaryOpKind data: " + data;
        }
    }
    
    public static function toExpr(kind:UnaryOpKind, easing:ComplexEasingKind, valueExpr:ExprOf<Float>):ExprOf<Float>
    {
        return switch (kind)
        {
            case UnaryOpKind.Clamp(min, max):
                var expr = easing.toExpr(valueExpr);
                macro tweenxcore.Tools.FloatTools.clamp($expr, ${ExprMakeTools.floatToExpr(min)}, ${ExprMakeTools.floatToExpr(max)});
                
            case UnaryOpKind.Lerp(from, to):
                var expr = easing.toExpr(valueExpr);
                macro tweenxcore.Tools.FloatTools.lerp($expr, ${ExprMakeTools.floatToExpr(from)}, ${ExprMakeTools.floatToExpr(to)});
                
            case UnaryOpKind.Repeat(repeat):
                var expr = macro tweenxcore.Tools.FloatTools.repeat(
                    tweenxcore.Tools.FloatTools.lerp($valueExpr, 0, ${ExprMakeTools.floatToExpr(repeat)}), 0, 1
                );
                easing.toExpr(expr);
                
            case UnaryOpKind.RoundTrip(roundTrip):
                RoundTripKindTools.toExpr(roundTrip, easing, valueExpr);
                
            case UnaryOpKind.Op(easing2, op):
                BinaryOpKindTools.toExpr(op, easing, easing2, valueExpr);
        }
    }
    
    public static function toFunctionExpr(kind:UnaryOpKind, easing:ComplexEasingKind):ExprOf<Float->Float>
    {
        return switch (kind)
        {
            case UnaryOpKind.Clamp(min, max):
                var expr = easing.toExpr(macro rate);
                macro function (rate:Float) return tweenxcore.Tools.FloatTools.clamp($expr, ${ExprMakeTools.floatToExpr(min)}, ${ExprMakeTools.floatToExpr(max)});
                
            case UnaryOpKind.Lerp(from, to):
                var expr = easing.toExpr(macro rate);
                macro function (rate:Float) return tweenxcore.Tools.FloatTools.lerp($expr, ${ExprMakeTools.floatToExpr(from)}, ${ExprMakeTools.floatToExpr(to)});
                
            case UnaryOpKind.Repeat(repeat):
                var repeatExpr = ExprMakeTools.floatToExpr(repeat);
                var arg = macro tweenxcore.Tools.FloatTools.repeat(
                    tweenxcore.Tools.FloatTools.lerp(rate, 0, $repeatExpr), 0, 1
                );
                var expr = easing.toExpr(arg);
                macro function (rate:Float):Float return $expr;
                
            case UnaryOpKind.RoundTrip(roundTrip):
                RoundTripKindTools.toFunctionExpr(roundTrip, easing);
                
            case UnaryOpKind.Op(easing2, op):
                BinaryOpKindTools.toFunctionExpr(op, easing, easing2);
        }
    }
}
