package;
import tweenxcore.Tools.Easing;
import tweenxcore.Tools.FloatTools;
import tweenxcore.color.HsvColor;
import tweenxcore.color.RgbColor;

class Style {
    public static var SQUARE_SIZE:Int  = 15;
    public static var START_FRAME:Int  = 15;
    public static var FINISH_FRAME:Int = 10;
    public static var GRID_SCALE:Int   = 15;
    public static var GRID_COLOR:RgbColor         = RgbColor.of(0xF1F1EF);
    public static var THEME_COLOR:RgbColor        = RgbColor.of(0x4EDAE1);
    public static var DARKEN_THEME_COLOR:RgbColor = RgbColor.of(0x0E9AB1);
    public static var BUTTON_SIZE:Int = 33;
    public static var DELAY_FRAME:Int = 120;
    
    public static function startEasing(rate:Float):Float {
        return FloatTools.connectEasing(
            rate, 
            fastOut, 
            Easing.quintIn, 
            0.62, 
            -0.30
        );
    }
    
    public static function finishEasing(rate:Float):Float {
        return FloatTools.mixEasing(
            rate,
            Easing.linear, 
            fastOut,
            0.8
        );
    }
    
    private static function fastOut(rate:Float):Float {
        return Easing.cubicOut(Easing.cubicOut(rate));
    }
}
