package tweenxcore.expr;
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
}
