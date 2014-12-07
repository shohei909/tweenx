package tweenx909.rule;
import tweenx909.TweenX;

/**
 * ...
 * @author shohei909
 */
class AhsvX {
	public var a:Float;
	public var h:Float;
	public var s:Float;
	public var v:Float;
	
	public function new( alpha:Float, hue:Float, saturation:Float, value:Float ) {
		this.a = alpha;
		this.h = hue; 
		this.s = saturation; 
		this.v = value;
	}
	
	static public var inputClass(default, null):Dynamic = AhsvX;
	static public function calc(_from:AhsvX, _to:AhsvX, t1:Float, t2:Float, tween:TweenX):Int {
		var a = _from.a * t2 + _to.a * t1;
		if ( a > 1 ) a = 1;
		if ( a < 0 ) a = 0;
		
		var h = _from.h * t2 + _to.h * t1;
		var s = _from.s * t2 + _to.s * t1;
		var v = _from.v * t2 + _to.v * t1;
		
		h = (h - Math.floor(h)) * 6;
		var hi = Math.floor( h );
		if ( s > 1 ) s = 1;
		if ( s < 0 ) s = 0;
		if ( v > 1 ) v = 1;
		if ( v < 0 ) v = 0;
		
		
		var m = v * (1 - s);
		var f = h - hi;
		
		var r = .0, g = .0, b = .0;
		switch( hi ) {
			case 0: r = v; g = v * (1 - s * (1 - f)); b = m;	
			case 1:	r = v * (1 - s * f); g = v; b = m;
			case 2:	r = m; g = v; b = v * (1 - s * (1 - f));
			case 3:	r = m; g = v * (1 - s * f); b = v;
			case 4:	r = v * (1 - s * (1 - f)); g = m; b = v;
			case 5:	r = v; g = m; b = v * (1 - s * f);
		}
		
		return (Std.int(a * 0xFF) << 24) | (Std.int(r * 0xFF) << 16) | (Std.int(g * 0xFF) << 8) | Std.int(b * 0xFF);
	}
	static public function defaultFrom( value:Int, _to:AhsvX, tween:TweenX ) { 
		return AhsvX.of( value );
	}
	
	static public function of( color:Int, hueIndex:Int = 0 ) {
		var a = ((color >>> 24) & 0xFF) / 0xFF;
		var r = ((color >> 16) & 0xFF) / 0xFF;
		var g = ((color >> 8) & 0xFF) / 0xFF;
		var b = (color & 0xFF) / 0xFF;
		
		var max, min, diff, h;
		if (r < g) {
			if ( g < b ) {
				max = b;
				min = r;
				h = (4 + (r - g) / (diff = max - min)) / 6; 
			}else {
				max = g;
				min = (r < b) ? r : b;
				h = (2 + (b - r) / (diff = max - min)) / 6; 
			}
		}else {
			if ( r < b ) { 	
				max = b;
				min = g;
				h = (4 + (r - g) / (diff = max - min)) / 6; 
			}else {
				max = r;
				min = (g < b) ? g : b;
				h = (g - b) / (diff = max - min) / 6; 
			}
		}
		
		if ( h < 0 ) h += 1;
		var s = diff / max;
		return new AhsvX(a,h + hueIndex,s,max);
	}
}