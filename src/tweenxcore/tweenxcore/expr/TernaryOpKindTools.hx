package tweenxcore.expr;
import tweenxcore.Tools.FloatTools;
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
				function (value:Float):Float
				{
					return FloatTools.crossfadeEasing(value, func1, func2, func3, start, end);
				}
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
}