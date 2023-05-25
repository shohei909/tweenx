package tweenx909.rule;
import tweenx909.TweenX;

class ArrayRuleX {
    public static var inputClass(default,null):Dynamic = Array;
    public static function calc(_from:Iterable<Dynamic>, _to:Iterable<Dynamic>, t1:Float, t2:Float, tween:TweenX):Iterable<Dynamic> {
        var fi     = _from.iterator();
        var arr = [];
        for (t in _to) {
            var f = fi.next();
            arr.push(_calc(f, t, t1, t2, tween));
        }
        return arr;
    }
    static private inline function _calc(_from:Dynamic, _to:Dynamic, t1:Float, t2:Float, tween:TweenX):Dynamic {
        if (Std.isOfType(_to, Float)) {
            return _from * t2 + _to * t1;
        }else {
            var result:Dynamic = null, ok:Bool = false;
            for (r in TweenX.rules) {
                if (Std.isOfType(_to, r.inputClass)) {
                    ok = true;
                    result = r.calc(_from, _to, t1, t2, tween);
                    break;
                }
            }
            if (! ok) {
                var eh:ErrorHandler = tween;
                throw eh.error("The tween rule for " + Type.getClassName(Type.getClass(_to)) + " is not defined");
            }
            return result;
        }
    }

    public static function defaultFrom(value:Iterable<Dynamic>, _to:Iterable<Dynamic>, tween:TweenX):Iterable<Dynamic> {
        var eh:ErrorHandler = tween;
        if (value != null) {
            var arr = [];
            for (t in _to) { arr.push(null); }
        }else if (Lambda.count(value) != Lambda.count(_to)){
            throw eh.error("The array length must be same with start.");
        }

        var result = [];
        var it = _to.iterator();
        for (v in value) {
            var t = it.next();
            result.push(_defaultFrom(v, t, tween));
        }
        return result;
    }

    static private function _defaultFrom(value:Dynamic, _to:Dynamic, tween:TweenX):Dynamic {
        if (Std.isOfType(_to, Float)) return value;
        for (r in TweenX.rules) {
            if (Std.isOfType(_to, r.inputClass)) {
                return r.defaultFrom(value, _to, tween);
            }
        }
        var eh:ErrorHandler = tween;
        throw eh.error("The tween rule for " + Type.getClassName(Type.getClass(_to)) + " is not defined");
        return null;
    }
}

private typedef ErrorHandler = {
    function error(str:String):String;
};
