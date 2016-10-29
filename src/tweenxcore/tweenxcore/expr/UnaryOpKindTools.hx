package tweenxcore.expr;
import haxe.EnumTools;
import haxe.EnumTools.EnumValueTools;
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
				
			case UnaryOpKind.Repeat(repeat):
				var func = easing.toFunction();
				function (value:Float):Float
				{
					return func(value.lerp(0, repeat).repeat());
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
}