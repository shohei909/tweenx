package tweenxcore.expr;
import tweenxcore.Tools.Easing;

class StandardEasingKindTools 
{
	public static inline function toFunction(easing:StandardEasingKind, inOut:InOutKind):Float->Float
	{
		return switch [easing, inOut]
		{
			case [Quad   , In    ]: Easing.quadIn;
			case [Quad   , Out   ]: Easing.quadOut;
			case [Quad   , InOut ]: Easing.quadInOut;
			case [Quad   , OutIn ]: Easing.quadOutIn;
			
			case [Cubic  , In    ]: Easing.cubicIn;
			case [Cubic  , Out   ]: Easing.cubicOut;
			case [Cubic  , InOut ]: Easing.cubicInOut;
			case [Cubic  , OutIn ]: Easing.cubicOutIn;
			
			case [Quart  , In    ]: Easing.quartIn;
			case [Quart  , Out   ]: Easing.quartOut;
			case [Quart  , InOut ]: Easing.quartInOut;
			case [Quart  , OutIn ]: Easing.quartOutIn;
			
			case [Quint  , In    ]: Easing.quintIn;
			case [Quint  , Out   ]: Easing.quintOut;
			case [Quint  , InOut ]: Easing.quintInOut;
			case [Quint  , OutIn ]: Easing.quintOutIn;
			
			case [Sine   , In    ]: Easing.sineIn;
			case [Sine   , Out   ]: Easing.sineOut;
			case [Sine   , InOut ]: Easing.sineInOut;
			case [Sine   , OutIn ]: Easing.sineOutIn;
			
			case [Circ   , In    ]: Easing.circIn;
			case [Circ   , Out   ]: Easing.circOut;
			case [Circ   , InOut ]: Easing.circInOut;
			case [Circ   , OutIn ]: Easing.circOutIn;
			
			case [Expo   , In    ]: Easing.expoIn;
			case [Expo   , Out   ]: Easing.expoOut;
			case [Expo   , InOut ]: Easing.expoInOut;
			case [Expo   , OutIn ]: Easing.expoOutIn;
			
			case [Back   , In    ]: Easing.backIn;
			case [Back   , Out   ]: Easing.backOut;
			case [Back   , InOut ]: Easing.backInOut;
			case [Back   , OutIn ]: Easing.backOutIn;
			
			case [Bounce , In    ]: Easing.bounceIn;
			case [Bounce , Out   ]: Easing.bounceOut;
			case [Bounce , InOut ]: Easing.bounceInOut;
			case [Bounce , OutIn ]: Easing.bounceOutIn;
			
			case [Elastic, In    ]: Easing.elasticIn;
			case [Elastic, Out   ]: Easing.elasticOut;
			case [Elastic, InOut ]: Easing.elasticInOut;
			case [Elastic, OutIn ]: Easing.elasticOutIn;
			
			case [Warp   , In    ]: Easing.warpIn;
			case [Warp   , Out   ]: Easing.warpOut;
			case [Warp   , InOut ]: Easing.warpInOut;
			case [Warp   , OutIn ]: Easing.warpOutIn;
		}
	}
}