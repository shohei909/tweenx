package tweenxcore.expr;
import haxe.macro.Expr.ExprOf;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ExprMaker.ExprMakeTools;
import tweenxcore.expr.SimpleEasingKind;
using tweenxcore.expr.ComplexEasingKindTools;
using tweenxcore.Tools.FloatTools;

class PolylineKindTools 
{

	public static inline function toFunction(kind:PolylineKind, controls:Array<Float>):Float->Float
	{
		return switch (kind)
		{
			case PolylineKind.Bezier:
				FloatTools.bezier.bind(_, controls);
		}
	}	
	
	public static function toExpr(kind:PolylineKind, controls:Array<Float>, valueExpr:ExprOf<Float>):ExprOf<Float> 
	{
		return switch (kind)
		{
			case PolylineKind.Bezier:
				macro tweenxcore.Tools.FloatTools.bezier($valueExpr, ${ExprMakeTools.floatArrayToExpr(controls)});
		}
	}
	
	public static function toFunctionExpr(kind:PolylineKind, controls:Array<Float>):ExprOf<Float->Float>
	{
		return switch (kind)
		{
			case PolylineKind.Bezier:
				macro tweenxcore.Tools.FloatTools.bezier.bind(_, ${ExprMakeTools.floatArrayToExpr(controls)});
		}
	}
}
