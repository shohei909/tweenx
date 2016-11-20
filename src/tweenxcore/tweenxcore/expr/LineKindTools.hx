package tweenxcore.expr;
import haxe.macro.Expr.ExprOf;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ExprMaker.ExprMakeTools;
import tweenxcore.expr.SimpleEasingKind;
using tweenxcore.expr.ComplexEasingKindTools;
using tweenxcore.Tools.FloatTools;

class LineKindTools 
{

    public static inline function toFunction(kind:LineKind, controls:Array<Float>):Float->Float
    {
        return switch (kind)
        {
            case LineKind.Bezier:
                FloatTools.bezier.bind(_, controls);
                
            case LineKind.Polyline:
                FloatTools.polyline.bind(_, controls);
                
            case LineKind.UniformQuadraticBSpline:
                FloatTools.uniformQuadraticBSpline.bind(_, controls);
        }
    }    
    
    public static function toExpr(kind:LineKind, controls:Array<Float>, valueExpr:ExprOf<Float>):ExprOf<Float> 
    {
        return switch (kind)
        {
            case LineKind.Bezier:
                macro tweenxcore.Tools.FloatTools.bezier($valueExpr, ${ExprMakeTools.floatArrayToExpr(controls)});
                
            case LineKind.Polyline:
                macro tweenxcore.Tools.FloatTools.polyline($valueExpr, ${ExprMakeTools.floatArrayToExpr(controls)});
                
            case LineKind.UniformQuadraticBSpline:
                macro tweenxcore.Tools.FloatTools.uniformQuadraticBSpline($valueExpr, ${ExprMakeTools.floatArrayToExpr(controls)});
                
        }
    }
    
    public static function toFunctionExpr(kind:LineKind, controls:Array<Float>):ExprOf<Float->Float>
    {
        return switch (kind)
        {
            case LineKind.Bezier:
                macro tweenxcore.Tools.FloatTools.bezier.bind(_, ${ExprMakeTools.floatArrayToExpr(controls)});
                
            case LineKind.Polyline:
                macro tweenxcore.Tools.FloatTools.polyline.bind(_, ${ExprMakeTools.floatArrayToExpr(controls)});
                
            case LineKind.UniformQuadraticBSpline:
                macro tweenxcore.Tools.FloatTools.uniformQuadraticBSpline.bind(_, ${ExprMakeTools.floatArrayToExpr(controls)});
        }
    }
}
