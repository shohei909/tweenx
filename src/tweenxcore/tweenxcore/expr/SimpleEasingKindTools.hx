package tweenxcore.expr;
import haxe.EnumTools;
import haxe.EnumTools.EnumValueTools;
import haxe.macro.Expr;
import tweenxcore.Tools.Easing;
import tweenxcore.Tools.FloatTools;
import tweenxcore.expr.PolylineKindTools;

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
				
			case SimpleEasingKind.Polyline(polyline, controls):
				PolylineKindTools.toFunction(polyline, controls);
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
				
			case SimpleEasingKind.Polyline(kind, controls):
				([
					"Polyline",
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
					
				case ["Polyline", kind, controls]:
					SimpleEasingKind.Polyline(
						EnumTools.createByName(PolylineKind, kind),
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
				
			case SimpleEasingKind.Polyline(polyline, controls):
				PolylineKindTools.toExpr(polyline, controls, valueExpr);
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
				
			case SimpleEasingKind.Polyline(polyline, controls):
				PolylineKindTools.toFunctionExpr(polyline, controls);
		}
	}
}
