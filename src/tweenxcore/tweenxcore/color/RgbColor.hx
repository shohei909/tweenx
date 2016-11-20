package tweenxcore.color;
import tweenxcore.color.AhsvColor;
import tweenxcore.color.ArgbColor;
import tweenxcore.color.RgbColor;
using tweenxcore.Tools.FloatTools;

class RgbColor implements IColor {
    /** red */
    public var r:Float;
    /** green */
    public var g:Float;
    /** blue */
    public var b:Float;

    public inline function new(red:Float, green:Float, blue:Float) {
        this.r = red;
        this.g = green;
        this.b = blue;
    }

    public static inline function rgbToInt(r:Float, g:Float, b:Float):Int {
        r = r.clamp();
        g = g.clamp();
        b = b.clamp();

        return (Std.int(r * 0xFF) << 16) | (Std.int(g * 0xFF) << 8) | Std.int(b * 0xFF);
    }

    public static inline function of(color:Int) {
        return new RgbColor(
            ((color >> 16) & 0xFF) / 0xFF,
            ((color >> 8) & 0xFF) / 0xFF,
            (color & 0xFF) / 0xFF
        );
    }

    public static function fromHsv(h:Float, s:Float, v:Float) {
        h = (h - Math.floor(h)) * 6;
        var hi = Math.floor(h);

        s = s.clamp();
        v = v.clamp();

        var m = v * (1 - s);
        var f = h - hi;

        var r = 0.0, g = 0.0, b = 0.0;
        switch(hi) {
            case 0:    r = v; g = v * (1 - s * (1 - f)); b = m;
            case 1:    r = v * (1 - s * f); g = v; b = m;
            case 2:    r = m; g = v; b = v * (1 - s * (1 - f));
            case 3:    r = m; g = v * (1 - s * f); b = v;
            case 4:    r = v * (1 - s * (1 - f)); g = m; b = v;
            case 5:    r = v; g = m; b = v * (1 - s * f);
        }

        return new RgbColor(r, g, b);
    }

    public inline function getRed():Float {
        return r;
    }
    
    public inline function getGreen():Float {
        return g;
    }
    
    public inline function getBlue():Float {
        return b;
    }
    
    public inline function getHue():Float {
        return toHsv().h;
    }
    
    public inline function getSaturation():Float {
        return toHsv().s;
    }
    
    public inline function getBrightness():Float {
        return toHsv().v;
    }
    
    public inline function toRgb():RgbColor {
        return new RgbColor(r, g, b);
    }
    
    public inline function toHsv():HsvColor {
        return HsvColor.fromRgb(r, g, b);
    }
    
    public inline function toRgbWithAlpha(alpha:Float):ArgbColor {
        return new ArgbColor(alpha, r, g, b);
    }
    
    public inline function toHsvWithAlpha(alpha:Float):AhsvColor {
        return AhsvColor.fromArgb(alpha, r, g, b);
    }

    public inline function toRgbInt():Int {
        return rgbToInt(r, g, b);
    }

    public inline function toRgbHexString():String {
        return StringTools.hex(toRgbInt(), 6);
    }
    
    public inline function toRgbCssString():String {
        return "rgb(" + Std.int(r * 0xFF) + "," + Std.int(g * 0xFF) + "," + Std.int(b * 0xFF) + ")";
    }
}
