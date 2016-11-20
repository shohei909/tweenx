package tweenxcore.color;
using tweenxcore.Tools;

class AhsvColor extends HsvColor implements ITransparentColor {
    /** alpha */
    public var a:Float;

    public function new(alpha:Float, hue:Float, saturation:Float, value:Float) {
        this.a = alpha;
        super(hue, saturation, value);
    }

    public static inline function ahsvToArgbInt(a:Float, h:Float, s:Float, v:Float):Int {
        return (Std.int(a.clamp() * 0xFF) << 24) | HsvColor.hsvToRgbInt(h, s, v);
    }

    public static inline function of(color:Int, hueIndex:Int = 0) {
        var a = ((color >>> 24) & 0xFF) / 0xFF;
        return HsvColor.of(color & 0xFFFFFF, hueIndex).toHsvWithAlpha(a);
    }

    public static inline function fromArgb(a:Float, r:Float, g:Float, b:Float, hueIndex:Int = 0) {
        return HsvColor.fromRgb(r, g, b, hueIndex).toHsvWithAlpha(a);
    }

    public inline function getAlpha():Float {
        return a;
    }
    
    public inline function toArgb():ArgbColor {
        return ArgbColor.fromAhsv(a, h, s, v);
    }
    
    public inline function toAhsv():AhsvColor {
        return new AhsvColor(a, h, s, v);
    }
    
    public inline function toArgbInt():Int {
        return ahsvToArgbInt(a, h, s, v);
    }
    
    public inline function toArgbHexString():String {
        return StringTools.hex(toArgbInt(), 8);
    }
    
    public inline function toRgbaCssString():String {
        return toArgb().toRgbaCssString();
    }
}
