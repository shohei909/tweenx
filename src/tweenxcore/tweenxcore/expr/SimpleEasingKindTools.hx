package tweenxcore.expr;
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
				
			case SimpleEasingKind.Bezier(controls):
				FloatTools.bezier.bind(_, controls);
		}
	}	
}