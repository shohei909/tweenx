package tweenxcore.expr;
import haxe.macro.Expr;
import tweenxcore.Tools.Easing;
import tweenxcore.expr.SimpleEasingKind;

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
    
    public static function toExpr(easing:StandardEasingKind, inOut:InOutKind, valueExpr:ExprOf<Float>):ExprOf<Float>
    {
        return switch [easing, inOut]
        {
            case [Quad   , In    ]: macro tweenxcore.Tools.Easing.quadIn($valueExpr);
            case [Quad   , Out   ]: macro tweenxcore.Tools.Easing.quadOut($valueExpr);
            case [Quad   , InOut ]: macro tweenxcore.Tools.Easing.quadInOut($valueExpr);
            case [Quad   , OutIn ]: macro tweenxcore.Tools.Easing.quadOutIn($valueExpr);
            
            case [Cubic  , In    ]: macro tweenxcore.Tools.Easing.cubicIn($valueExpr);
            case [Cubic  , Out   ]: macro tweenxcore.Tools.Easing.cubicOut($valueExpr);
            case [Cubic  , InOut ]: macro tweenxcore.Tools.Easing.cubicInOut($valueExpr);
            case [Cubic  , OutIn ]: macro tweenxcore.Tools.Easing.cubicOutIn($valueExpr);
            
            case [Quart  , In    ]: macro tweenxcore.Tools.Easing.quartIn($valueExpr);
            case [Quart  , Out   ]: macro tweenxcore.Tools.Easing.quartOut($valueExpr);
            case [Quart  , InOut ]: macro tweenxcore.Tools.Easing.quartInOut($valueExpr);
            case [Quart  , OutIn ]: macro tweenxcore.Tools.Easing.quartOutIn($valueExpr);
            
            case [Quint  , In    ]: macro tweenxcore.Tools.Easing.quintIn($valueExpr);
            case [Quint  , Out   ]: macro tweenxcore.Tools.Easing.quintOut($valueExpr);
            case [Quint  , InOut ]: macro tweenxcore.Tools.Easing.quintInOut($valueExpr);
            case [Quint  , OutIn ]: macro tweenxcore.Tools.Easing.quintOutIn($valueExpr);
            
            case [Sine   , In    ]: macro tweenxcore.Tools.Easing.sineIn($valueExpr);
            case [Sine   , Out   ]: macro tweenxcore.Tools.Easing.sineOut($valueExpr);
            case [Sine   , InOut ]: macro tweenxcore.Tools.Easing.sineInOut($valueExpr);
            case [Sine   , OutIn ]: macro tweenxcore.Tools.Easing.sineOutIn($valueExpr);
            
            case [Circ   , In    ]: macro tweenxcore.Tools.Easing.circIn($valueExpr);
            case [Circ   , Out   ]: macro tweenxcore.Tools.Easing.circOut($valueExpr);
            case [Circ   , InOut ]: macro tweenxcore.Tools.Easing.circInOut($valueExpr);
            case [Circ   , OutIn ]: macro tweenxcore.Tools.Easing.circOutIn($valueExpr);
            
            case [Expo   , In    ]: macro tweenxcore.Tools.Easing.expoIn($valueExpr);
            case [Expo   , Out   ]: macro tweenxcore.Tools.Easing.expoOut($valueExpr);
            case [Expo   , InOut ]: macro tweenxcore.Tools.Easing.expoInOut($valueExpr);
            case [Expo   , OutIn ]: macro tweenxcore.Tools.Easing.expoOutIn($valueExpr);
            
            case [Back   , In    ]: macro tweenxcore.Tools.Easing.backIn($valueExpr);
            case [Back   , Out   ]: macro tweenxcore.Tools.Easing.backOut($valueExpr);
            case [Back   , InOut ]: macro tweenxcore.Tools.Easing.backInOut($valueExpr);
            case [Back   , OutIn ]: macro tweenxcore.Tools.Easing.backOutIn($valueExpr);
            
            case [Bounce , In    ]: macro tweenxcore.Tools.Easing.bounceIn($valueExpr);
            case [Bounce , Out   ]: macro tweenxcore.Tools.Easing.bounceOut($valueExpr);
            case [Bounce , InOut ]: macro tweenxcore.Tools.Easing.bounceInOut($valueExpr);
            case [Bounce , OutIn ]: macro tweenxcore.Tools.Easing.bounceOutIn($valueExpr);
            
            case [Elastic, In    ]: macro tweenxcore.Tools.Easing.elasticIn($valueExpr);
            case [Elastic, Out   ]: macro tweenxcore.Tools.Easing.elasticOut($valueExpr);
            case [Elastic, InOut ]: macro tweenxcore.Tools.Easing.elasticInOut($valueExpr);
            case [Elastic, OutIn ]: macro tweenxcore.Tools.Easing.elasticOutIn($valueExpr);
            
            case [Warp   , In    ]: macro tweenxcore.Tools.Easing.warpIn($valueExpr);
            case [Warp   , Out   ]: macro tweenxcore.Tools.Easing.warpOut($valueExpr);
            case [Warp   , InOut ]: macro tweenxcore.Tools.Easing.warpInOut($valueExpr);
            case [Warp   , OutIn ]: macro tweenxcore.Tools.Easing.warpOutIn($valueExpr);
        }
    }
    
    public static function toFunctionExpr(easing:StandardEasingKind, inOut:InOutKind):ExprOf<Float->Float>
    {
        return switch [easing, inOut]
        {
            case [Quad   , In    ]: macro tweenxcore.Tools.Easing.quadIn;
            case [Quad   , Out   ]: macro tweenxcore.Tools.Easing.quadOut;
            case [Quad   , InOut ]: macro tweenxcore.Tools.Easing.quadInOut;
            case [Quad   , OutIn ]: macro tweenxcore.Tools.Easing.quadOutIn;
            
            case [Cubic  , In    ]: macro tweenxcore.Tools.Easing.cubicIn;
            case [Cubic  , Out   ]: macro tweenxcore.Tools.Easing.cubicOut;
            case [Cubic  , InOut ]: macro tweenxcore.Tools.Easing.cubicInOut;
            case [Cubic  , OutIn ]: macro tweenxcore.Tools.Easing.cubicOutIn;
            
            case [Quart  , In    ]: macro tweenxcore.Tools.Easing.quartIn;
            case [Quart  , Out   ]: macro tweenxcore.Tools.Easing.quartOut;
            case [Quart  , InOut ]: macro tweenxcore.Tools.Easing.quartInOut;
            case [Quart  , OutIn ]: macro tweenxcore.Tools.Easing.quartOutIn;
            
            case [Quint  , In    ]: macro tweenxcore.Tools.Easing.quintIn;
            case [Quint  , Out   ]: macro tweenxcore.Tools.Easing.quintOut;
            case [Quint  , InOut ]: macro tweenxcore.Tools.Easing.quintInOut;
            case [Quint  , OutIn ]: macro tweenxcore.Tools.Easing.quintOutIn;
            
            case [Sine   , In    ]: macro tweenxcore.Tools.Easing.sineIn;
            case [Sine   , Out   ]: macro tweenxcore.Tools.Easing.sineOut;
            case [Sine   , InOut ]: macro tweenxcore.Tools.Easing.sineInOut;
            case [Sine   , OutIn ]: macro tweenxcore.Tools.Easing.sineOutIn;
            
            case [Circ   , In    ]: macro tweenxcore.Tools.Easing.circIn;
            case [Circ   , Out   ]: macro tweenxcore.Tools.Easing.circOut;
            case [Circ   , InOut ]: macro tweenxcore.Tools.Easing.circInOut;
            case [Circ   , OutIn ]: macro tweenxcore.Tools.Easing.circOutIn;
            
            case [Expo   , In    ]: macro tweenxcore.Tools.Easing.expoIn;
            case [Expo   , Out   ]: macro tweenxcore.Tools.Easing.expoOut;
            case [Expo   , InOut ]: macro tweenxcore.Tools.Easing.expoInOut;
            case [Expo   , OutIn ]: macro tweenxcore.Tools.Easing.expoOutIn;
            
            case [Back   , In    ]: macro tweenxcore.Tools.Easing.backIn;
            case [Back   , Out   ]: macro tweenxcore.Tools.Easing.backOut;
            case [Back   , InOut ]: macro tweenxcore.Tools.Easing.backInOut;
            case [Back   , OutIn ]: macro tweenxcore.Tools.Easing.backOutIn;
            
            case [Bounce , In    ]: macro tweenxcore.Tools.Easing.bounceIn;
            case [Bounce , Out   ]: macro tweenxcore.Tools.Easing.bounceOut;
            case [Bounce , InOut ]: macro tweenxcore.Tools.Easing.bounceInOut;
            case [Bounce , OutIn ]: macro tweenxcore.Tools.Easing.bounceOutIn;
            
            case [Elastic, In    ]: macro tweenxcore.Tools.Easing.elasticIn;
            case [Elastic, Out   ]: macro tweenxcore.Tools.Easing.elasticOut;
            case [Elastic, InOut ]: macro tweenxcore.Tools.Easing.elasticInOut;
            case [Elastic, OutIn ]: macro tweenxcore.Tools.Easing.elasticOutIn;
            
            case [Warp   , In    ]: macro tweenxcore.Tools.Easing.warpIn;
            case [Warp   , Out   ]: macro tweenxcore.Tools.Easing.warpOut;
            case [Warp   , InOut ]: macro tweenxcore.Tools.Easing.warpInOut;
            case [Warp   , OutIn ]: macro tweenxcore.Tools.Easing.warpOutIn;
        }
    }
}
