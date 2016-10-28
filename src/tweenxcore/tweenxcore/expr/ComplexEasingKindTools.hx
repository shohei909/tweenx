package tweenxcore.expr;
import tweenxcore.Tools.Easing;

class ComplexEasingKindTools 
{
	public static inline function toFunction(easing:ComplexEasingKind):Float->Float
	{
		return switch (easing)
		{
			case ComplexEasingKind.Simple(kind):
				SimpleEasingKindTools.toFunction(kind);
			
			case ComplexEasingKind.Op(easing, op):
				UnaryOpKindTools.toFunction(op, easing);
		}
	}	
}
