package tweenxcore.expr;
import haxe.EnumTools;
import haxe.EnumTools.EnumValueTools;
import haxe.macro.Expr;
import tweenxcore.Tools.Easing;
import tweenxcore.Tools.FloatTools;
import tweenxcore.expr.LineKindTools;

class SimpleEasingKindTools 
{
    public static inline function toFunction(easing:SimpleEasingKind):Float->Float
    {
        return switch (easing)
        {
            case SimpleEasingKind.Linear:
                Easing.linear;
                
            case SimpleEasingKind.Standard(easing, inOut):
                StandardEasingKindTools.toFunction(easing, inOut);
                
            case SimpleEasingKind.Line(polyline, controls):
                LineKindTools.toFunction(polyline, controls);
        }
    }    
    
    public static function toJsonable(easing:SimpleEasingKind):Dynamic 
    {
        return switch (easing)
        {
            case SimpleEasingKind.Linear:
                "Linear";
                
            case SimpleEasingKind.Standard(easing, inOut):
                ([
                    "Standard",
                    EnumValueTools.getName(easing),
                    EnumValueTools.getName(inOut),
                ]:Array<Dynamic>);
                
            case SimpleEasingKind.Line(kind, controls):
                ([
                    "Line",
                    EnumValueTools.getName(kind),
                    controls
                ]:Array<Dynamic>);
        }
    }
    
    public static function fromJsonable(data:Dynamic):SimpleEasingKind 
    {
        return if (Std.is(data, String))
        {
            switch (data)
            {
                case "Linear":
                    SimpleEasingKind.Linear;
                    
                case _:
                    throw "unsupported SimpleEasingKind data: " + data;
            }
        }
        else
        {
            switch (data)
            {
                case ["Standard", easing, inOut]:
                    SimpleEasingKind.Standard(
                        EnumTools.createByName(StandardEasingKind, easing),
                        EnumTools.createByName(InOutKind, inOut)
                    );
                    
                case ["Line", kind, controls]:
                    SimpleEasingKind.Line(
                        EnumTools.createByName(LineKind, kind),
                        [for (c in (controls:Array<Float>)) cast(c, Float)]
                    );
                    
                case _:
                    throw "unsupported SimpleEasingKind data: " + data;
            }
        }
    }
    
    public static function toExpr(easing:SimpleEasingKind, valueExpr:ExprOf<Float>):ExprOf<Float>
    {
        return switch (easing)
        {
            case SimpleEasingKind.Linear:
                macro tweenxcore.Tools.Easing.linear($valueExpr);
                
            case SimpleEasingKind.Standard(easing, inOut):
                StandardEasingKindTools.toExpr(easing, inOut, valueExpr);
                
            case SimpleEasingKind.Line(polyline, controls):
                LineKindTools.toExpr(polyline, controls, valueExpr);
        }
    }
    
    public static function toFunctionExpr(easing:SimpleEasingKind):ExprOf<Float->Float>
    {
        return switch (easing)
        {
            case SimpleEasingKind.Linear:
                macro tweenxcore.Tools.Easing.linear;
                
            case SimpleEasingKind.Standard(easing, inOut):
                StandardEasingKindTools.toFunctionExpr(easing, inOut);
                
            case SimpleEasingKind.Line(polyline, controls):
                LineKindTools.toFunctionExpr(polyline, controls);
        }
    }
}
