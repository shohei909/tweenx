package tweenx909.advanced;
import haxe.PosInfos;
import tweenx909.EventX;
import tweenx909.TweenX;

/**
 * @author shohei909
 */

class StandardTweenX<T> extends TweenX {
    private var _autoFrom:Null<Bool> = true;
    public function new(type:TweenTypeX, ?time:Float, ?ease:Float->Float, ?delay:Float, ?repeat:Int, ?yoyo:Bool, ?zigzag:Bool, ?interval:Float, ?autoPlay:Bool, ?posInfos:PosInfos) {
        switch(type) {
            case ARRAY(targets, fromArr, toArr):
                var _from    = fromArr.pop();
                var _to          = toArr.pop();
                for (t in targets) {
                    toArr.push(clone(_to));
                    fromArr.push(clone(_from));
                }
            default:
        }
        super(type, time, ease, delay, repeat, yoyo, zigzag, interval, autoPlay, posInfos);
    }

    static private function clone(obj:Dynamic) {
        var result = {};
        for (key in Reflect.fields(obj)) Reflect.setProperty(result, key, Reflect.getProperty(obj, key));
        return result;
    }

    private inline function checkField(target:Dynamic, key:String) {
        #if flash9
        if (! Reflect.hasField(target, key))
            throw error(Type.getClassName(Type.getClass(target)) + " does not have field '" + key + "'");
        #else
        if (! Std.isOfType(Reflect.field(target, key), Dynamic))
            throw error(Type.getClassName(Type.getClass(target)) + " does not have field '" + key + "'");
        #end
    }

    private function _getTarget():T { return cast this; }
    private function _setTo(key:String, value:Dynamic):Void {
        checkInited();
        switch(_type) {
            case FROM_TO(target, _from, _to):
                checkField(target, key);
                Reflect.deleteField(_to, "$$$$" + key);
                TweenX.setField(_to, key, value);
            case ARRAY(targets, fromArr, toArr):
                var i = 0;
                for (t in targets){
                    checkField(t, key);
                    var _to = toArr[i++ ];
                    Reflect.deleteField(_to, "$$$$" + key);
                    TweenX.setField(_to, key, value);
                }
            default:
        }
    }
    private function _setRelativeTo(key:String, value:Dynamic):Void {
        checkInited();
        switch(_type) {
            case FROM_TO(target, _from, _to):
                checkField(target, key);
                Reflect.deleteField(_to, "$$$$" + key);
                TweenX.setField(_to, key, TweenX.field(target, key) + value);
            case ARRAY(targets, fromArr, toArr):
                var i = 0;
                for (t in targets){
                    checkField(t, key);
                    var _to = toArr[i++ ];
                    Reflect.deleteField(_to, "$$$$" + key);
                    TweenX.setField(_to, key, TweenX.field(t, key) + value);
                }
            default:
        }
    }
    private function _setRelativeTo2(key:String, value:Dynamic):Void {
        checkInited();
        switch(_type) {
            case FROM_TO(target, _from, _to):
                checkField(target, key);
                Reflect.deleteField(_to, key);
                TweenX.setField(_to, "$$$$" + key, value);
            case ARRAY(targets, fromArr, toArr):
                var i = 0;
                for (t in targets){
                    checkField(t, key);
                    var _to = toArr[i++ ];
                    Reflect.deleteField(_to, key);
                    TweenX.setField(_to, "$$$$" + key, value);
                }
            default:
        }
    }

    override private function _initFromTo(target, _from, _to) {
        if (_autoFrom == null) _autoFrom = TweenX.defaultAutoFrom;
        _initFrom(target, _from, _to);

        var data = {};
        var fs = TweenX.fields(_from);
        for (key in fs){
            if (! Reflect.hasField(_to, key)){
                TweenX.setField(_to, key, TweenX.field(_from, key));
            }

            var t = _getPosition(_time, (_repeat % 2) == 0);
            TweenX.setField(data, key, _calc(TweenX.field(_from,key), TweenX.field(_to,key), t, 1 - t));
        }

        var id = TweenX.hashObject(target);
        if (TweenX._initLog[id ] == null) {
            TweenX._initLog[id ] = [{ target:target, data: data } ];
        }else {
            var flag = false;
            for (log in TweenX._initLog[id ]) {
                if (log.target == target) {
                    for(key in TweenX.fields(data)){ TweenX.setField(log.data, key, TweenX.field(data, key)); }
                    flag = true;
                    break;
                }
            }
            if (! flag) {
                TweenX._initLog[id ].push({ target:target, data:data });
            }
        }
    }

    private inline function _initFrom(target, _from, _to) {
        var data = null;
        for (key0 in TweenX.fields(_to)) {
            if (! Std.isOfType(TweenX.field(_to, key0), Float)) _fastMode = false;

            var relative     = (key0.substr(0, 4) == "$$$$");
            var key         = relative ?  key0.substr(4) : key0;

            var fromValue:Dynamic, toValue:Dynamic = TweenX.field(_to, key0);
            if (! Reflect.hasField(_from, key)) {
                if (_autoFrom){
                    if (data == null) {
                        data = {};
                        var logs = TweenX._initLog[TweenX.hashObject(target) ];
                        if (logs != null)
                            for (log in logs)
                                if (log.target == target) data = log.data;
                    }

                    if (Reflect.hasField(data, key)) {
                        fromValue = _defaultFrom(TweenX.field(data, key), toValue);
                    } else {
                        fromValue = _defaultFrom(TweenX.field(target, key), toValue);
                    }
                } else {
                    fromValue = _defaultFrom(TweenX.field(target, key), toValue);
                }
                TweenX.setField(_from, key, fromValue);
            }else {
                fromValue = TweenX.field(_from, key);
            }

            if (relative) {
                TweenX.setField(_to, key, toValue + fromValue);
                Reflect.deleteField(_to, key0);
            }
        }
    }

    private function _defaultFrom(value:Dynamic, _to:Dynamic):Dynamic {
        if (Std.isOfType(_to, Float)) return value;
        for (r in TweenX._rules) {
            if (Std.isOfType(_to, r.inputClass)) {
                return r.defaultFrom(value, _to, this);
            }
        }
        throw error("The tween rule for " + Type.getClassName(Type.getClass(_to)) + " is not defined");
        return null;
    }


    override public function play(#if (tweenx_debug) ?posInfo:PosInfos #end) {
        super.play(#if (tweenx_debug) posInfo #end);
        return this;
    }
    override public function stop() {
        super.stop();
        return this;
    }
    override public function update(time:Float #if (tweenx_debug) ,?posInfo:PosInfos #end) {
        super.update(time #if (tweenx_debug) ,posInfo #end);
        return this;
    }
    override public function goto(time:Float = 0, andPlay:Bool = false #if (tweenx_debug) ,?posInfo:PosInfos #end) {
        super.goto(time, andPlay #if (tweenx_debug) ,posInfo #end);
        return this;
    }
    override public function onDelay(handler:Void -> Void) {
        super.onDelay(handler);
        return this;
    }
    override public function onFinish(handler:Void -> Void) {
        super.onFinish(handler);
        return this;
    }
    override public function onFoot(handler:Void -> Void) {
        super.onFoot(handler);
        return this;
    }
    override public function onHead(handler:Void -> Void) {
        super.onHead(handler);
        return this;
    }
    override public function onInterval(handler:Void -> Void) {
        super.onInterval(handler);
        return this;
    }
    override public function onStop(handler:Void -> Void) {
        super.onStop(handler);
        return this;
    }
    override public function onPlay(handler:Void -> Void) {
        super.onPlay(handler);
        return this;
    }
    override public function onRepeat(handler:Void -> Void) {
        super.onRepeat(handler);
        return this;
    }
    override public function onRest(handler:Void -> Void) {
        super.onRest(handler);
        return this;
    }
    override public function onUpdate(handler:Void -> Void) {
        super.onUpdate(handler);
        return this;
    }
    override public function addEventListener(type:String, listener:StandardTweenX<T>->Void) {
        _addEventListener(type, listener);
        return this;
    }
    override public function removeEventListener(type:String, listener:StandardTweenX<T>->Void) {
        _removeEventListener(type, listener);
        return this;
    }

    /*
     * パラメータ変更
     */
    override public function time(value:Float):StandardTweenX<T> {
        super.time(value);
        return this;
    }
    override public function ease(value:Float->Float):StandardTweenX<T> {
        super.ease(value);
        return this;
    }
    override public function delay(value:Float):StandardTweenX<T> {
        super.delay(value);
        return this;
    }
    override public function rest(value:Float):StandardTweenX<T> {
        super.rest(value);
        return this;
    }
    override public function interval(value:Float):StandardTweenX<T> {
        super.interval(value);
        return this;
    }
    override public function repeat(value:Int = 1):StandardTweenX<T> {
        super.repeat(value);
        return this;
    }
    override public function yoyo(value:Bool = true):StandardTweenX<T> {
        super.yoyo(value);
        return this;
    }
    override public function zigzag(value:Bool = true):StandardTweenX<T> {
        super.zigzag(value);
        return this;
    }
    override public function autoPlay(value:Bool = true):StandardTweenX<T> {
        super.autoPlay(value);
        return this;
    }
    override public function setTimeScale(value:Float = 0):StandardTweenX<T> {
        super.setTimeScale(value);
        return this;
    }
    override public function skip(delay:Float = 0):StandardTweenX<T> {
        super.skip();
        return this;
    }
    private function autoFrom(value:Bool = true):StandardTweenX<T> {
        checkInited();
        _autoFrom = value;
        return this;
    }
}
