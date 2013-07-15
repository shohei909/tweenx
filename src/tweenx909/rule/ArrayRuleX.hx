package tweenx909.rule;
import tweenx909.TweenX;

class ArrayRuleX{
	static public var inputClass(default,null):Dynamic = Array;
	static public function calc(from:Iterable<Dynamic>, to:Iterable<Dynamic>, t1:Float, t2:Float, tween:TweenX):Iterable<Dynamic> {
		var fi 	= from.iterator();
		var arr = [];
		for ( t in to ) {
			var f = fi.next();
			arr.push( _calc( f, t, t1, t2, tween ) );
		}
		return arr;
	}
	static private inline function _calc( from:Dynamic, to:Dynamic, t1:Float, t2:Float, tween:TweenX ):Dynamic {
		if ( Std.is( to, Float ) ) {
			return from * t2 + to * t1;
		}else {
			var result:Dynamic = null, ok:Bool = false;
			for ( r in TweenX.rules ) {
				if ( Std.is( to, r.inputClass ) ) {
					ok = true;
					result = r.calc( from, to, t1, t2, tween );
					break;
				}
			}
			if (! ok ) {
				var eh:ErrorHandler = tween;
				throw eh.error( "The tween rule for " + Type.getClassName(Type.getClass(to)) + " is not defined" );
			}
			return result;
		}
	}
	
	static public function defaultFrom( value:Iterable<Dynamic>, to:Iterable<Dynamic>, tween:TweenX ):Iterable<Dynamic> { 
		var eh:ErrorHandler = tween;
		if ( value != null ) {
			var arr = [];
			for ( t in to ) { arr.push( null ); }
		}else if( Lambda.count( value ) != Lambda.count( to ) ){
			throw eh.error( "The array length must be same with start." );
		}
		
		var result = [];
		var it = to.iterator();
		for ( v in value ) {
			var t = it.next();
			result.push( _defaultFrom( v, t, tween ) );
		}
		return result; 
	}
	
	static private function _defaultFrom( value:Dynamic, to:Dynamic, tween:TweenX ):Dynamic {
        if ( Std.is(to, Float) ) return value;
        for ( r in TweenX.rules ) {
            if ( Std.is( to, r.inputClass) ) {
                return r.defaultFrom( value, to, tween );
            }
        }
		var eh:ErrorHandler = tween;
		throw eh.error( "The tween rule for " + Type.getClassName(Type.getClass(to)) + " is not defined" );
        return null;
    }
}

private typedef ErrorHandler = { 
	private function error( str:String ):String; 
};