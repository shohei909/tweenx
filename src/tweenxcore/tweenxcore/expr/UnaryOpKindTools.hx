package tweenxcore.expr;
import tweenxcore.Tools.Easing;
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
				function (value:Float):Float
				{
					return func(value).clamp(min, max);
				}
				
			case UnaryOpKind.Lerp(from, to):
				var func = easing.toFunction();
				function (value:Float):Float
				{
					return func(value).lerp(from, to);
				}
				
			case UnaryOpKind.Repeat(count):
				var func = easing.toFunction();
				function (value:Float):Float
				{
					return func(value.lerp(0, count).repeat());
				}
				
			case UnaryOpKind.RoundTrip(roundTrip):
				RoundTripKindTools.toFunction(roundTrip, easing);
				
			case UnaryOpKind.Op(easing2, op):
				BinaryOpKindTools.toFunction(op, easing, easing2);
		}
	}
}