package tweenxcore.color;
import tweenx909.TweenX;
using tweenxcore.Tools;

class HsvColor {
    public var h:Float;
    public var s:Float;
    public var v:Float;

    public function new(hue:Float, saturation:Float, value:Float) {
        this.h = hue;
        this.s = saturation;
        this.v = value;
    }

    public static function hsvToInt(h:Float, s:Float, v:Float):Int {
        h = (h - Math.floor(h)) * 6;
        var hi = Math.floor(h);

        s = s.clamp();
        v = v.clamp();

        var m = v * (1 - s);
        var f = h - hi;

        var r = 0.0, g = 0.0, b = 0.0;
        switch(hi) {
            case 0: r = v; g = v * (1 - s * (1 - f)); b = m;
            case 1:    r = v * (1 - s * f); g = v; b = m;
            case 2:    r = m; g = v; b = v * (1 - s * (1 - f));
            case 3:    r = m; g = v * (1 - s * f); b = v;
            case 4:    r = v * (1 - s * (1 - f)); g = m; b = v;
            case 5:    r = v; g = m; b = v * (1 - s * f);
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
        return new HsvColor(h + hueIndex, s, max);
    }

    public inline function toInt():Int {
        return hsvToInt(h, s, v);
    }

    public inline function toRgb():RgbColor {
        return RgbColor.fromHsv(h, s, v);
    }

    public inline function toAhsv(a:Float):AhsvColor {
        return new AhsvColor(a, h, s, v);
    }
}
