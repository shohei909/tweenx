package tweenxcore.expr;
import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;
import tweenxcore.Tools.FloatTools;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ExprMaker.ExprMakeTools;
using tweenxcore.expr.ComplexEasingKindTools;

class BinaryOpKindTools 
{
    public static inline function toFunction(kind:BinaryOpKind, easing1:ComplexEasingKind, easing2:ComplexEasingKind):Float->Float
    {
        return switch (kind)
        {
            case BinaryOpKind.Composite:
                var func1 = easing1.toFunction();
                var func2 = easing2.toFunction();
                function (rate:Float):Float
                {
                    return func1(func2(rate));
                }
                
            case BinaryOpKind.Multiply:
                var func1 = easing1.toFunction();
                var func2 = easing2.toFunction();
                function (rate:Float):Float
                {
                    return func1(rate) * func2(rate);
                }
                
            case BinaryOpKind.Mix(strength):
                var func1 = easing1.toFunction();
                var func2 = easing2.toFunction();
                FloatTools.mixEasing.bind(_, func1, func2, strength);
                
            case BinaryOpKind.Connect(switchTime, switchValue):
                var func1 = easing1.toFunction();
                var func2 = easing2.toFunction();
                FloatTools.connectEasing.bind(_, func1, func2, switchTime, switchValue);
                
            case BinaryOpKind.OneTwo(switchTime):
                var func1 = easing1.toFunction();
                var func2 = easing2.toFunction();
                FloatTools.oneTwoEasing.bind(_, func1, func2, switchTime);
                
            case BinaryOpKind.Op(easing3, op):
                TernaryOpKindTools.toFunction(op, easing1, easing2, easing3);
        }
    }
    
    public static function toJsonable(kind:BinaryOpKind):Dynamic
    {
        return switch (kind)
        {
            case BinaryOpKind.Composite:
                "Composite";
                
            case BinaryOpKind.Multiply:
                "Multiply";
                
            case BinaryOpKind.Mix(strength):
                ["Mix", strength];
                
            case BinaryOpKind.Connect(switchTime, switchValue):
                ["Connect", switchTime, switchValue];
                
            case BinaryOpKind.OneTwo(switchTime):
                ["OneTwo", switchTime];
                
            case BinaryOpKind.Op(easing3, op):
                [
                    "Op", 
                    ComplexEasingKindTools.toJsonable(easing3),
                    TernaryOpKindTools.toJsonable(op),
                ];
        }
    }
    
    public static function fromJsonable(data:Dynamic):BinaryOpKind
    {
        return if (Std.isOfType(data, String))
        {
            switch (data)
            {
                case "Composite":
                    BinaryOpKind.Composite;
                    
                case "Multiply":
                    BinaryOpKind.Multiply;
                    
                case _:
                    throw "unsupported BinaryOpKind data: " + data;
            }
        }
        else
        {
            switch (data)
            {
                case ["Mix", strength]:
                    BinaryOpKind.Mix(cast(strength, Float));
                    
                case ["Connect", switchTime, switchValue]:
                    BinaryOpKind.Connect(cast(switchTime, Float), cast(switchValue, Float));
                    
                case ["OneTwo", switchTime]:
                    BinaryOpKind.OneTwo(cast(switchTime, Float));
                    
                case ["Op", easing3, op]:
                    BinaryOpKind.Op(
                        ComplexEasingKindTools.fromJsonable(easing3),
                        TernaryOpKindTools.fromJsonable(op)
                    );
                case _:
                    throw "unsupported BinaryOpKind data: " + data;
            }
        }
    }
    
    public static function toExpr(kind:BinaryOpKind, easing1:ComplexEasingKind, easing2:ComplexEasingKind, valueExpr:ExprOf<Float>):ExprOf<Float>
    {
        return switch (kind)
        {
            case BinaryOpKind.Composite:
                var expr2 = easing2.toExpr(valueExpr);
                easing1.toExpr(expr2);
                
            case BinaryOpKind.Multiply:
                var expr1 = easing1.toExpr(valueExpr);
                var expr2 = easing2.toExpr(valueExpr);
                macro $expr1 * $expr2;
                
            case BinaryOpKind.Mix(strength):
                var func1 = easing1.toFunctionExpr();
                var func2 = easing2.toFunctionExpr();
                macro tweenxcore.Tools.FloatTools.mixEasing($valueExpr, $func1, $func2, ${ExprMakeTools.floatToExpr(strength)});
                
            case BinaryOpKind.Connect(switchTime, switchValue):
                var func1 = easing1.toFunctionExpr();
                var func2 = easing2.toFunctionExpr();
                macro tweenxcore.Tools.FloatTools.connectEasing($valueExpr, $func1, $func2, ${ExprMakeTools.floatToExpr(switchTime)}, ${ExprMakeTools.floatToExpr(switchValue)});
                
            case BinaryOpKind.OneTwo(switchTime):
                var func1 = easing1.toFunctionExpr();
                var func2 = easing2.toFunctionExpr();
                macro tweenxcore.Tools.FloatTools.oneTwoEasing($valueExpr, $func1, $func2, ${ExprMakeTools.floatToExpr(switchTime)});
                
            case BinaryOpKind.Op(easing3, op):
                TernaryOpKindTools.toExpr(op, easing1, easing2, easing3, valueExpr);
        }
    }
    
    public static function toFunctionExpr(kind:BinaryOpKind, easing1:ComplexEasingKind, easing2:ComplexEasingKind):ExprOf<Float->Float>
    {
        return switch (kind)
        {
            case BinaryOpKind.Composite:
                var expr2 = easing2.toExpr(macro rate);
                var expr1 = easing1.toExpr(expr2);
                macro function (rate:Float):Float return $expr1;
                
                
            case BinaryOpKind.Multiply:
                var expr1 = easing1.toExpr(macro rate);
                var expr2 = easing2.toExpr(macro rate);
                macro function (rate:Float):Float return $expr1 * $expr2;                
                
            case BinaryOpKind.Mix(strength):
                var func1 = easing1.toFunctionExpr();
                var func2 = easing2.toFunctionExpr();
                macro tweenxcore.Tools.FloatTools.mixEasing.bind(_, $func1, $func2, ${ExprMakeTools.floatToExpr(strength)});
                
            case BinaryOpKind.Connect(switchTime, switchValue):
                var func1 = easing1.toFunctionExpr();
                var func2 = easing2.toFunctionExpr();
                macro tweenxcore.Tools.FloatTools.connectEasing.bind(_, $func1, $func2, ${ExprMakeTools.floatToExpr(switchTime)}, ${ExprMakeTools.floatToExpr(switchValue)});
                
            case BinaryOpKind.OneTwo(switchTime):
                var func1 = easing1.toFunctionExpr();
                var func2 = easing2.toFunctionExpr();
                macro tweenxcore.Tools.FloatTools.oneTwoEasing.bind(_, $func1, $func2, ${ExprMakeTools.floatToExpr(switchTime)});
                
            case BinaryOpKind.Op(easing3, op):
                TernaryOpKindTools.toFunctionExpr(op, easing1, easing2, easing3);
        }
    }
}
