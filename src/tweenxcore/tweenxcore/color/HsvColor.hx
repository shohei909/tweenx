package tweenxcore.color;
import tweenxcore.color.RgbColor;
using tweenxcore.Tools;

class HsvColor implements IColor {
    /** hue */
    public var h:Float;
    /** saturation */
    public var s:Float;
    /** value (brightness) */
    public var v:Float;

    public inline function new(hue:Float, saturation:Float, value:Float) {
        this.h = hue;
        this.s = saturation;
        this.v = value;
    }

    public static function hsvToRgbInt(h:Float, s:Float, v:Float):Int {
        h = (h - Math.floor(h)) * 6;
        var hi = Math.floor(h);

        s = s.clamp();
        v = v.clamp();

        var m = v * (1 - s);
        var f = h - hi;

        var r = 0.0, g = 0.0, b = 0.0;
        switch(hi) {
            case 0: r = v; g = v * (1 - s * (1 - f)); b = m;
            case 1: r = v * (1 - s * f); g = v; b = m;
            case 2: r = m; g = v; b = v * (1 - s * (1 - f));
            case 3: r = m; g = v * (1 - s * f); b = v;
            case 4: r = v * (1 - s * (1 - f)); g = m; b = v;
            case 5: r = v; g = m; b = v * (1 - s * f);
        }

        return (Std.int(r * 0xFF) << 16) | (Std.int(g * 0xFF) << 8) | Std.int(b * 0xFF);
    }

    public static inline function of(color:Int, hueIndex:Int = 0) {
        var r = ((color >> 16) & 0xFF) / 0xFF;
        var g = ((color >> 8) & 0xFF) / 0xFF;
        var b = (color & 0xFF) / 0xFF;
        return fromRgb(r, g, b, hueIndex);
    }

    public static function fromRgb(r:Float, g:Float, b:Float, hueIndex:Int = 0):HsvColor {
        var max, min, diff, h;
        if (r < g) {
            if (g < b) {
                max = b;
                min = r;
                h = (4 + (r - g) / (diff = max - min)) / 6;
            }else {
                max = g;
                min = (r < b) ? r : b;
                h = (2 + (b - r) / (diff = max - min)) / 6;
            }
        } else {
            if (r < b) {
                max = b;
                min = g;
                h = (4 + (r - g) / (diff = max - min)) / 6;
            }else {
                max = r;
                min = (g < b) ? g : b;
                h = (g - b) / (diff = max - min) / 6;
            }
        }

        if (h < 0) h += 1;
        var s = diff / max;

        if (Math.isNaN(h))
        {
            h = 0;
        }
        if (Math.isNaN(s))
        {
            s = 0;
        }
        return new HsvColor(h + hueIndex, s, max);
    }

    
    
    public inline function getRed():Float {
        return toRgb().r;
    }
    
    public inline function getGreen():Float {
        return toRgb().g;
    }
    
    public inline function getBlue():Float {
        return toRgb().b;
    }
    
    public inline function getHue():Float {
        return h;
    }
    
    public inline function getSaturation():Float {
        return s;
    }
    
    public inline function getBrightness():Float {
        return v;
    }
    
    public inline function toRgb():RgbColor {
        return RgbColor.fromHsv(h, s, v);
    }

    public inline function toHsv():HsvColor {
        return new HsvColor(h, s, v);
    }
    
    public inline function toHsvWithAlpha(alpha:Float):AhsvColor {
        return new AhsvColor(alpha, h, s, v);
    }
    
    public inline function toRgbWithAlpha(alpha:Float):ArgbColor {
        return ArgbColor.fromAhsv(alpha, h, s, v);
    }
    
    public inline function toRgbInt():Int {
        return hsvToRgbInt(h, s, v);
    }

    public inline function toRgbHexString():String {
        return StringTools.hex(toRgbInt(), 6);
    }
    
    public inline function toRgbCssString():String {
        return toRgb().toRgbCssString();
    }
}
