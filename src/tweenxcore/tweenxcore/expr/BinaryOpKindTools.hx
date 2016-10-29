package tweenxcore.expr;
import tweenxcore.Tools.FloatTools;
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
				function (value:Float):Float
				{
					return func1(func2(value));
				}
				
			case BinaryOpKind.Multiply:
				var func1 = easing1.toFunction();
				var func2 = easing2.toFunction();
				function (value:Float):Float
				{
					return func1(value) * func2(value);
				}
				
			case BinaryOpKind.Mix(strength):
				var func1 = easing1.toFunction();
				var func2 = easing2.toFunction();
				function (value:Float):Float
				{
					return FloatTools.mixEasing(value, func1, func2, strength);
				}
				
			case BinaryOpKind.Connect(switchTime, switchValue):
				var func1 = easing1.toFunction();
				var func2 = easing2.toFunction();
				function (value:Float):Float
				{
					return FloatTools.connectEasing(value, func1, func2, switchTime, switchValue);
				}
				
			case BinaryOpKind.OneTwo(switchTime):
				var func1 = easing1.toFunction();
				var func2 = easing2.toFunction();
				function (value:Float):Float
				{
					return FloatTools.oneTwoEasing(value, func1, func2, switchTime);
				}
				
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
		return if (Std.is(data, String))
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
}