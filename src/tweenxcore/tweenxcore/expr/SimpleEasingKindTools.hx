package tweenxcore.expr;
import haxe.EnumTools;
import haxe.EnumTools.EnumValueTools;
import tweenxcore.Tools.Easing;
import tweenxcore.Tools.FloatTools;

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
				
			case SimpleEasingKind.Polyline(Bezier, controls):
				FloatTools.bezier.bind(_, controls);
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
}
