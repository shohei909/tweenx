package tweenx909.core.color;
import tweenx909.core.tools.FloatTools;
import tweenx909.core.tools.FloatTools.*;

/**
 * ...
 * @author shohei909
 */
class ArgbColor extends RgbColor
{
	public var a:Float;

	public function new(alpha:Float, red:Float, green:Float, blue:Float) {
		this.a = alpha;
		super(red, green, blue);
	}

	public static function argbToInt(a:Float, r:Float, g:Float, b:Float):Int {
		return (Std.int(clamp(a) * 0xFF) << 24) | RgbColor.rgbToInt(r, g, b);
	}

	public static function of(color:Int) {
        return new ArgbColor(
            ((color >>> 24) & 0xFF) / 0xFF,
            ((color >> 16) & 0xFF) / 0xFF,
            ((color >> 8) & 0xFF) / 0xFF,
            (color & 0xFF) / 0xFF
       );
    }

	public static function fromAhsv(a:Float, h:Float, s:Float, v:Float, hueIndex:Int = 0) {
		return RgbColor.fromHsv(h, s, v).toArgb(a);
	}

	public function toAhsv():AhsvColor {
		return AhsvColor.fromArgb(a, r, g, b);
	}
}
