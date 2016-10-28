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
					return func2(func1(value));
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
}