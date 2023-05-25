package tweenx909;

import haxe.PosInfos;
import haxe.Timer;
import tweenx909.EaseX;
import tweenx909.advanced.CommandX;
import tweenx909.advanced.DefaultsX;
import tweenx909.advanced.GroupX;
import tweenx909.advanced.StandardTweenX;
import tweenx909.advanced.TweenTypeX;
import tweenx909.advanced.UpdateModeX;
import tweenx909.rule.RuleX;
import tweenx909.rule.AhsvRuleX;
import tweenx909.rule.ArgbRuleX;
import tweenx909.rule.ArrayRuleX;
import tweenx909.rule.BoolRuleX;
import tweenx909.rule.HsvRuleX;
import tweenx909.rule.QuakeRuleX;
import tweenx909.rule.RgbRuleX;
import tweenx909.rule.TimelineRuleX;
import tweenx909.TweenX;
using Lambda;

/**
 * @author shohei909
 */
class TweenX extends CommandX {

    /*
     * 全体情報
     */
    private static var _tweens:Array<TweenX>                        = new Array<TweenX>();
    private static var _addedTweens:Array<TweenX>                    = new Array<TweenX>();
    public static var tweens(#if haxe3 get #else get_tweens #end, never):Iterable<TweenX>;
    private static function get_tweens():Iterable<TweenX> { return _tweens; }

    /*
     * マネージャ基本値
     */
    private static var prevTime:Float;
    private static var managerInited     = false;

    /*
     * 基本パラメータデフォルト値
     */
    public static var DEFAULT_EASE(default,null):Float->Float = EaseX.linear;
    public static inline var DEFAULT_TIME:Float        = 0.3;
    public static inline var DEFAULT_DELAY:Float        = 0;
    public static inline var DEFAULT_REPEAT:Int        = 1;
    public static inline var DEFAULT_INTERVAL:Int    = 0;
    public static inline var DEFAULT_YOYO:Bool        = false;
    public static inline var DEFAULT_ZIGZAG:Bool        = false;
    public static inline var DEFAULT_AUTO_PLAY:Bool    = true;
    private static inline var DEFAULT_AUTO_FROM:Bool    = true;

    public static var defaultEase:Float->Float    = TweenX.DEFAULT_EASE;
    public static var defaultTime:Float             = TweenX.DEFAULT_TIME;
    public static var defaultDelay:Float            = TweenX.DEFAULT_DELAY;
    public static var defaultInterval:Float        = TweenX.DEFAULT_INTERVAL;
    public static var defaultRepeat:Int            = TweenX.DEFAULT_REPEAT;
    public static var defaultYoyo:Bool             = TweenX.DEFAULT_YOYO;
    public static var defaultZigZag:Bool             = TweenX.DEFAULT_ZIGZAG;
    public static var defaultAutoPlay:Bool        = TweenX.DEFAULT_AUTO_PLAY;
    private static var defaultAutoFrom:Bool        = TweenX.DEFAULT_AUTO_FROM;

    private static var _rules:Array<RuleX<Dynamic,Dynamic>>             = [BoolRuleX, ArrayRuleX, TimelineRuleX, ArgbRuleX, AhsvRuleX, RgbRuleX, HsvRuleX, QuakeRuleX];
    public static var rules(#if haxe3 get #else get_rules #end, never):Iterable<RuleX<Dynamic,Dynamic>>;
    private static function get_rules():Iterable<RuleX<Dynamic,Dynamic>> { return _rules; }


    static public var topLevelTimeScale:Float                            = 1;
    private static var _groupDefaults:Bool                                 = false;

    public static function dumpDefaults() {
        return new DefaultsX().dump();
    }
    public static function setDefaults(defaults:DefaultsX) {
        defaults.apply();
    }
    public static function initDefaults() {
        new DefaultsX().apply();
    }

    public static var updateMode(default, #if haxe3 set #else set_updateMode #end):UpdateModeX
        = #if (flash) UpdateModeX.FRAME; #else UpdateModeX.TIME(60); #end

    static function set_updateMode(value) {
        updateMode = value;
        initManager();
        return value;
    }

    /*
     * マネージャ関数
     */
    private static inline function initManager() {
        managerInited = true;
        stopUpdater();
        switch(updateMode) {
        #if flash
        case FRAME:
            addFrameListener(mainLoop);
        #end
        case TIME(f):
            prevTime = getTime();
            setInterval(mainLoop, Math.round(1000 / f));
        case MANUAL:
        }
    }
    private static function mainLoop() {
        switch(updateMode) {
        #if flash
        case FRAME:
            manualUpdate(1 / flash.Lib.current.stage.frameRate);
        #end
        case TIME(f):
            manualUpdate((getTime() - prevTime) / 1000);
            prevTime = getTime();
        case MANUAL:
            throw "invalid auto update";
        }
    }
    private static function stopUpdater() {
        if (_timer != null) {
            _timer.stop();
            _timer = null;
        }
        #if (flash)
        if (_engine != null){
            _engine.removeEventListener("exitFrame", _frameHandler);
            _engine = null;
            _frameHandler = null;
        }
        #end
    }

    public static function manualUpdate(time:Float #if (tweenx_debug) ,?posInfo:PosInfos #end) {
        initTweens();
        var l = _tweens.length, i = 0;
        while (i < l){
            var t = _tweens[i++];
            t._update(time * t.timeScale * topLevelTimeScale #if (tweenx_debug) ,posInfo #end);
            if (!t.playing) { _tweens.splice(--i, 1); l--; }
        }
        _resetLog();
    }
    private static function initTweens() {
        for (t in _addedTweens) { t._init(); }
        _addedTweens.splice(0, _addedTweens.length);
    }
    public static function clear() {
        for (t in _addedTweens) { t._autoPlay = false; }
        stopAll(tweens);
    }

    /*
     * 変則ルールの管理
     */
    public static function addRule(rule:RuleX <Dynamic,Dynamic>) {
        var i = 0, l = _rules.length;
        while (i < l) {
            var r = _rules[i++];
            if (r.inputClass == rule.inputClass){ _rules.splice(i--, 1); l--; }
        }
        _rules.push(rule);
    }
    public static function addRules(rules:Iterable<RuleX <Dynamic, Dynamic>>) {
        for (r in rules) addRule(r);
    }

    /*
     * トゥイーン生成
     */
    public static function from<T>(target:T, ?_to:Dynamic, ?delay:Float, ?repeat:Int, ?interval:Float, ?autoPlay:Bool, ?posInfos:PosInfos){
        if (_to == null) _to = {};
        if (! isIterable(target)) return new StandardTweenX<T>(FROM_TO(target, {}, _to), 0, EaseX.linear, delay, repeat, false, false, interval, autoPlay, posInfos);
        else                        return new StandardTweenX<T>(ARRAY(untyped target, [{}], [_to]), 0, EaseX.linear, delay, repeat, false, false, interval, autoPlay, posInfos);
    }
    public static function to<T>(target:T, ?_to:Dynamic, ?time:Float, ?ease:Float->Float, ?delay:Float, ?repeat:Int, ?yoyo:Bool, ?zigzag:Bool, ?interval:Float, ?autoPlay:Bool, ?posInfos:PosInfos) {
        if (_to == null) _to = {};
        if (! isIterable(target)) return new StandardTweenX<T>(FROM_TO(target, {}, _to), time, ease, delay, repeat, yoyo, zigzag, interval, autoPlay, posInfos);
        else                        return new StandardTweenX<T>(ARRAY(untyped target, [{}], [_to]), time, ease, delay, repeat, yoyo, zigzag, interval, autoPlay, posInfos);
    }
    public static function tweenFunc(func:Dynamic, _from:Iterable<Dynamic>, _to:Iterable<Dynamic>, ?time:Float, ?ease:Float->Float, ?delay:Float, ?repeat:Int, ?yoyo:Bool, ?zigzag:Bool, ?interval:Float, ?autoPlay:Bool, ?posInfos:PosInfos) {
        return new TweenX(FUNC(func, Lambda.array(_from), Lambda.array(_to)), time, ease, delay, repeat, yoyo, zigzag, interval, autoPlay, posInfos);
    }
    public static function tweenFunc1(func:Float->Void, from1:Float, to1:Float, ?time:Float, ?ease:Float->Float, ?delay:Float, ?repeat:Int, ?yoyo:Bool, ?zigzag:Bool, ?interval:Float, ?autoPlay:Bool, ?posInfos:PosInfos) {
        return new TweenX(FUNC(func, [from1], [to1]), time, ease, delay, repeat, yoyo, zigzag, interval, autoPlay, posInfos);
    }
    public static function tweenFunc2(func:Float->Float->Void, from1:Float, from2:Float, to1:Float, to2:Float, ?time:Float, ?ease:Float->Float, ?delay:Float, ?repeat:Int, ?yoyo:Bool, ?zigzag:Bool, ?interval:Float, ?autoPlay:Bool, ?posInfos:PosInfos) {
        return new TweenX(FUNC(func, [from1,from2], [to1,to2]), time, ease, delay, repeat, yoyo, zigzag, interval, autoPlay, posInfos);
    }
    public static function tweenFunc3(func:Float->Float->Float->Void, from1:Float, from2:Float, from3:Float, to1:Float, to2:Float, to3:Float, ?time:Float, ?ease:Float->Float, ?delay:Float, ?repeat:Int, ?yoyo:Bool, ?zigzag:Bool, ?interval:Float, ?autoPlay:Bool, ?posInfos:PosInfos) {
        return new TweenX(FUNC(func, [from1,from2,from3], [to1,to2,to3]), time, ease, delay, repeat, yoyo, zigzag, interval, autoPlay, posInfos);
    }
    public static function tweenFunc4(func:Float->Float->Float->Float->Void, from1:Float, from2:Float, from3:Float, from4:Float, to1:Float, to2:Float, to3:Float, to4:Float, ?time:Float, ?ease:Float->Float, ?delay:Float, ?repeat:Int, ?yoyo:Bool, ?zigzag:Bool, ?interval:Float, ?autoPlay:Bool, ?posInfos:PosInfos) {
        return new TweenX(FUNC(func, [from1,from2,from3,from4], [to1,to2,to3,to4]), time, ease, delay, repeat, yoyo, zigzag, interval, autoPlay, posInfos);
    }
    public static function func(func:Void->Void, ?delay:Float, ?repeat:Int, ?interval:Float, ?posInfos:PosInfos) {
        return new TweenX(CALL(func), 0, EaseX.linear, delay, repeat, false, false, interval, false, posInfos);
    }


    /*
     * 一括制御
     */
    public static function playAll(tweens:Iterable<TweenX> #if (tweenx_debug) ,?posInfo:PosInfos #end) {
        for (t in tweens)
            switch(t.command) {
                case WAIT(_):
                case TWEEN(o):
                    o.play(#if (tweenx_debug) posInfo #end);
            }
    }
    public static function stopAll(tweens:Iterable<TweenX>){
        for (t in tweens)
            switch(t.command) {
                case WAIT(_):
                case TWEEN(o):
                    o.stop();
            }
    }
    public static function gotoAll(tweens:Iterable<TweenX>, time:Float = 0, andPlay:Bool = false 
        #if (tweenx_debug), ?posInfo:PosInfos #end
    ){
        for (t in tweens)
            switch(t.command) {
                case WAIT(_):
                case TWEEN(o):
                    o.goto(time, andPlay #if (tweenx_debug) ,posInfo #end);
            }
    }
    public static function updateAll(tweens:Iterable<TweenX>, time:Float #if (tweenx_debug) ,?posInfo:PosInfos #end) {
        for (t in tweens)
            switch(t.command) {
                case WAIT(_):
                case TWEEN(o):
                    if (! o._inited) o._init();
                    o.update(time #if (tweenx_debug) ,posInfo #end);
            }
    }


    /*
     * シリアライズ
     */
    public static function serial(tweens:Iterable<CommandX>, ?defaults:DefaultsX, ?posInfos:PosInfos) {
        return _group(tweens, SERIAL, defaults, posInfos);
    }
    public static function lag(tweens:Iterable<CommandX>, ?delay:Float = 0.1, ?defaults:DefaultsX, ?posInfos:PosInfos) {
        return _group(tweens, LAG(delay), defaults, posInfos);
    }
    public static function parallel(tweens:Iterable<CommandX>, ?defaults:DefaultsX, ?posInfos:PosInfos) {
        return _group(tweens, LAG(0), defaults, posInfos);
    }
    public static function wait(?delay:Float = 0.1, ?posInfos:PosInfos) { return new CommandX(WAIT(delay), posInfos); }
    private static inline function _group(tweens:Iterable<CommandX>, type, defaults, posInfos:PosInfos) {
        var parent = new TweenX(GROUP(new GroupX(tweens, type, defaults)), null, null, null, null, null, null, null, null, posInfos);
        for (t in tweens) {
            if (t == null) continue;
            switch(t.command) {
                case TWEEN(o):
                    _lock(o);
                    o._parent = parent;
                default:
            }
        }
        return parent;
    }
    private static inline function _lock(o:TweenX) {
        if (o._inited) throw o.error("Can't serialize initialized TweenCommandX");
        o._autoPlay = false;
    }

    /*
     * 静的ユーティリティ
     */
    private static inline function getTime():Float {
        #if (neko || php || cpp || cs || java)
        return Sys.time() * 1000;
        #else
        return Date.now().getTime();
        #end
    }
    private static var _timer:Timer;
    private static inline function setInterval(f:Void->Void, t:Int) {
        if (_timer != null) _timer.stop();
        _timer         = new Timer(t);
        _timer.run     = f;
    }

    #if (flash9)
    static var _engine:flash.display.Sprite;
    static var _frameHandler:Dynamic->Void;
    private static inline function addFrameListener(f:Void->Void){
        _engine = new flash.display.Sprite();
        function f2(e) { f(); }
        _engine.addEventListener("exitFrame", _frameHandler = f2);
    }
    #end

    private static inline function fields(t:Dynamic) {
        return Reflect.fields(t);
    }

    private static var _initLog:Array<Array<Log>> = [];
    #if haxe3
    private static    var dictionary:haxe.ds.ObjectMap<Dynamic,Int> = new haxe.ds.ObjectMap();
    #elseif flash9
    private static    var dictionary:flash.utils.Dictionary = untyped new flash.utils.Dictionary(true);
    #end
    private static var _objCounter:Int = 0;
    private static inline function hashObject(o:Dynamic) {
        #if haxe3
        if (dictionary.get(o) != null) return dictionary.get(o);
        else {
            _objCounter = 1 + (_objCounter % 33029);
            dictionary.set(o, _objCounter);
            return _objCounter;
        }
        #elseif flash9
        untyped if (dictionary[o] != null) return untyped dictionary[o];
        else {
            _objCounter = 1 + (_objCounter % 33029);
            untyped dictionary[o ] = _objCounter;
            return _objCounter;
        }
        #elseif cpp
        return untyped __global__.__hxcpp_obj_id(o);
        #else
        if (Reflect.hasField(o,'__id')) {
            return Reflect.field(o,'__id');
         } else {
            _objCounter = 1 + (_objCounter % 33029);
            Reflect.setProperty(o,'__id', _objCounter);
            return _objCounter;
        }
        #end
    }
    private static function _resetLog() {
        _initLog = [];
        #if haxe3
        dictionary = new haxe.ds.ObjectMap();
        #elseif flash
        dictionary = new flash.utils.Dictionary(true);
        #end
    }

    private static inline function field(o:Dynamic, key:String) {
        #if (flash)
        return untyped o[key ];
        #elseif (js)
        var tmp;
        return untyped o == null?null:o.__properties__&&(tmp=o.__properties__["get_" +key])?o[tmp]():o[key];
        #else
        return Reflect.getProperty(o, key);
        #end
    }

    private static inline function setField(o:Dynamic, key:String, value:Dynamic) {
        #if (flash)
        untyped o[key ] = value;
        #elseif (js)
        var tmp;
        untyped if (o.__properties__ && (tmp = o.__properties__["set_" + key])) o[tmp](value); else o[key] = value;
        #else
        Reflect.setProperty(o, key, value);
        #end
    }

    private static function isIterable(d:Dynamic) {
        return (d != null && (Std.isOfType(d, Array) || Reflect.hasField(d, "iterator") && Reflect.isFunction(d.iterator) && d.iterator() != null));
    }

    /*
     * 定数
     */
    private static inline var _MIN = 1 / 0x3FFFFFF;
    static public function eventIndex(type:String) {
        return EVENT_ARRAY.indexOf(type);
    }
    private static var EVENT_ARRAY = ["play","delay","head","update","foot","interval","repeat","rest","finish","stop"];
    private static inline var _PLAY     = 0;
    private static inline var _DELAY    = 1;
    private static inline var _HEAD     = 2;
    private static inline var _UPDATE   = 3;
    private static inline var _FOOT     = 4;
    private static inline var _INTERVAL = 5;
    private static inline var _REPEAT   = 6;
    private static inline var _REST     = 7;
    private static inline var _FINISH   = 8;
    private static inline var _STOP     = 9;


    /*
     * コンストラクタ
     */
    function new(type:TweenTypeX, ?time:Float, ?ease:Float->Float, ?delay:Float, ?repeat:Int, ?yoyo:Bool, ?zigzag:Bool, ?interval:Float, ?autoPlay:Bool, ?posInfos:PosInfos) {
        super(TWEEN(this), posInfos);
        this._type = type;

        _currentTime        = 0;
        switch(type) {
            case GROUP(g):
                _easeIsDefault = false;
                _ease = (ease == null) ? EaseX.linear : ease;
            default: _ease = (_easeIsDefault = ease == null) ? defaultEase : ease;
        }

        _time     = (_timeIsDefault       = time     == null) ? defaultTime      : time;
        _delay    = (_delayIsDefault      = delay    == null) ? defaultDelay     : delay;
        _interval = (_intervalIsDefault   = interval == null) ? defaultInterval  : interval;
        _repeat   = (_repeatIsDefault     = repeat   == null) ? defaultRepeat    : repeat;
        _yoyo     = (_yoyoIsDefault       = yoyo     == null) ? defaultYoyo      : yoyo;
        _zigzag   = (_zigzagIsDefault     = zigzag   == null) ? defaultZigZag    : zigzag;
        _autoPlay = (_autoPlayIsDefault   = autoPlay == null) ? defaultAutoPlay  : autoPlay;

        _rest        = 0;
        _eventListeners = [];

        id = idCounter++;
        TweenX._addedTweens.push(this);
        if (! TweenX.managerInited) { TweenX.initManager(); }
    }

    /*
     * 状態情報
     */
    public var playing(default, null):Bool;
    public var backward(default, null):Bool;
    private var _currentTime:Float = 0;
    private var _singleTime:Float;
    private var _skip:Null<Float> = null;
    private var _type:TweenTypeX;
    private var _inited:Bool;
    private var _totalTime:Float;
    private var _dead:Bool;
    private var _parent:TweenX;
    private var _fastMode:Bool;
    private var _toKeys:Array<String>;


    /*
     * プロパティ
     */
    #if haxe3
    public     var currentTime(get, never):Float;
    public     var singleTime(get, never):Float;
    public     var totalTime(get, never):Float;
    public     var timeScale(default,set):Float     = 1;
    #else
    public     var currentTime(get_currentTime, never):Float;
    public     var singleTime(get_singleTime,null):Float;
    public     var totalTime(get_totalTime,null):Float;
    public     var timeScale(default,set_timeScale):Float = 1;
    #end
    private function get_currentTime() {
        var t = get_totalTime();
        var p = (backward) ? (t - _currentTime) : _currentTime;
        if (p < 0) p = 0;
        if (p > t) p = t;
        return p;
    }
    private function get_singleTime() {
        return _time + _interval;
    }
    private function get_totalTime() {
        return _delay + get_singleTime() * _repeat - _interval + _rest;
    }
    private function set_timeScale(value:Float) {
        return
            if (_parent != null)     throw error("Can't change timeScale of serialized object directly");
            else                     timeScale = value;
    }

    /*
     * 基本パラメータ
     */
    private var _inverted:Bool;
    private var _odd:Bool;

    private var _time:Float;
    private var _ease:Float->Float;
    private var _interval:Float;
    private var _repeat:Int;
    private var _zigzag:Bool;
    private var _yoyo:Bool;
    private var _delay:Float;
    private var _autoPlay:Bool;
    private var _rest:Float;

    private var _timeIsDefault:Bool;
    private var _easeIsDefault:Bool;
    private var _intervalIsDefault:Bool;
    private var _repeatIsDefault:Bool;
    private var _zigzagIsDefault:Bool;
    private var _yoyoIsDefault:Bool;
    private var _delayIsDefault:Bool;
    private var _autoPlayIsDefault:Bool;

    /*
     * コールバック関数
     */
    private var _onPlay:Void->Void;
    private var _onStop:Void->Void;
    private var _onDelay:Void->Void;
    private var _onInterval:Void->Void;
    private var _onRepeat:Void->Void;
    private var _onRest:Void->Void;
    private var _onHead:Void->Void;
    private var _onUpdate:Void->Void;
    private var _onFoot:Void->Void;
    private var _onFinish:Void->Void;
    private var _eventListeners:Array <Array<Dynamic>>;


    /*
     * デバッグ
     */
    #if (tweenx_debug)
    private var _updatePosInfo:PosInfos;
    #end
    public var id(default, null):Int;
    public static var idCounter:Int = 0;
    public function error(msg:String) {
        var p = definedPosInfos;
        return msg + "(Tween_" + id + " was generated at " + p.className + "/" + p.methodName + "() [" + p.fileName + ":" + p.lineNumber + "])";
    }

    /* 個別制御     */
    public function play(#if (tweenx_debug) ?posInfo:PosInfos #end) {
        if (_parent != null) throw error("Can't play serialized object directly");
        if (playing) return this;
        if (! _inited) _init();

        playing = true;
        _tweens.push(this);

        #if (tweenx_debug) _updatePosInfo = posInfo; #end
        dispatch(_PLAY);
        if (_onPlay != null) _onPlay();
        update(_MIN #if (tweenx_debug) ,posInfo #end);
        return this;
    }
    public function stop() {
        if (_parent != null) throw error("Can't stop serialized object directly");
        _stop();
        return this;
    }
    private function _stop() {
        if (! playing) return;
        playing = false;
        dispatch(_STOP);
        if (_onStop != null) _onStop();
    }

    public function update(time:Float #if (tweenx_debug) ,?posInfo:PosInfos #end) {
        if (_parent != null) throw error("Can't stop serialized object directly");
        _update(time * timeScale * TweenX.topLevelTimeScale #if (tweenx_debug) ,posInfo #end);
        return this;
    }

    public function goto(time:Float = 0, andPlay:Bool = false #if (tweenx_debug) ,?posInfo:PosInfos #end) {
        if (_parent != null) throw error("Can't move serialized object directly");
        if (! _inited) { _init(); }
        var t = time;
        if (t < 0) t = 0;
        else if (t > _totalTime) t = _totalTime;
        _update(t - currentTime);
        if (andPlay) { play(#if (tweenx_debug) posInfo #end); }
        return this;
    }

    private function _invert(){
        _currentTime = _totalTime - _currentTime;
        if (_repeat % 2 == 0) _odd = !_odd;

        _inverted     = !_inverted;
        var d         = _delay;
        _delay         = _rest;
        _rest         = d;
    }


    /*
     * 初期化
     */
    private function _init() {
        if (_inited) { return; }
        _inited = true;

        if (_groupDefaults){
            if (_easeIsDefault)         _ease       = defaultEase;
            if (_timeIsDefault)         _time       = defaultTime;
            if (_delayIsDefault)        _delay      = defaultDelay;
            if (_intervalIsDefault)     _interval   = defaultInterval;
            if (_repeatIsDefault)       _repeat     = defaultRepeat;
            if (_yoyoIsDefault)         _yoyo       = defaultYoyo;
            if (_zigzagIsDefault)       _zigzag     = defaultZigZag;
            if (_autoPlayIsDefault)     _autoPlay   = defaultAutoPlay;
        }

        if (_repeat == 0) _repeat = #if (neko && !haxe3) 0x3FFFFFFE #else 0x7FFFFFFE #end ;
        if (_time < _MIN) _time = _MIN;

        var ot = getTime();
        _fastMode = true;

        switch(_type) {
            case FROM_TO(target, _from, _to):
                _initFromTo(target, _from, _to);
                _toKeys = fields(_to);
            case ARRAY(targets, fromArr, toArr):
                var i = 0;
                for (target in targets) {
                    var _from = fromArr[i], _to = toArr[i];
                    _initFromTo(target, _from, _to);
                    if (i == 0) _toKeys = fields(_to);
                    i++;
                }
            case GROUP(g):
                initGroup(g);
            default:
        }


        _singleTime    = get_singleTime();
        _totalTime     = get_totalTime();

        if (_autoPlay) { play(); }
    }

    private function _initFromTo(target, _from, _to) {
        throw error("must be standard tween.");
    }

    /*
     * メインループ
     */
    private function _update(spent:Float #if (tweenx_debug) ,?posInfo:PosInfos #end) {
        #if (tweenx_debug)
        _updatePosInfo = posInfo;
        #end

        if (!_inited) _init();
        if (spent == 0) return;
        if (backward) spent = -spent;
        if (spent < 0) {
            _invert();
            backward = !backward;
            spent = -spent;
        }
        var _currentTime = this._currentTime, _singleTime = this.singleTime, _totalTime = this._totalTime;

        var time            = _time;
        var delay            = _delay;
        var untilRest        = _totalTime - _rest;
        var delaying         = (_currentTime - delay < _MIN);
        var resting         = !delaying && (_MIN > untilRest -_currentTime);
        var body            = _currentTime - delay;
        var repeatNum        = Math.floor(body / _singleTime);
        var position        = body - repeatNum * _singleTime;
        var intervending    = (_MIN > time - position);

        this._currentTime = _currentTime     += spent;
        position    += spent;
        body        += spent;



        //delayのチェック
        if (_currentTime - delay < _MIN) {
            dispatch(_DELAY);
            if (_onDelay != null) _onDelay();
            return;
        }else if (delaying) {
            _head(0);
            delaying = false;
        }

        //restのチェック
        if (_MIN > untilRest -_currentTime) {
            if (! resting) {
                if (intervending) {
                    dispatch(_REPEAT);
                    if (_onRepeat != null) _onRepeat();
                    _head(repeatNum);
                }
                _foot(_repeat - 1);
            }
            //finishのチェック
            if (_MIN > _totalTime - _currentTime) {
                _finish();
            } else {
                dispatch(_REST);
                if (_onRest != null) _onRest();
            }
        } else {
            //intervalのチェック
            if (_MIN > time - position) {
                if (!intervending && repeatNum >= 0) { _foot(repeatNum); }
                if (position < _singleTime){
                    dispatch(_INTERVAL);
                    if (_onInterval != null) _onInterval();
                    return;
                }else {
                    if (repeatNum >= 0){
                        dispatch(_REPEAT);
                        if (_onRepeat != null) { _onRepeat(); }
                        _head(repeatNum);
                    }
                    repeatNum    = Std.int(body / _singleTime);
                    position    = body - repeatNum * _singleTime;

                    if (_MIN > time - position) {
                        _foot(repeatNum);
                        dispatch(_INTERVAL);
                        if (_onInterval != null) _onInterval();
                        return;
                    }
                }
            }else {
                if (intervending) {
                    dispatch(_REPEAT);
                    if (_onRepeat != null) { _onRepeat(); }
                    _head(repeatNum);
                }
            }
            _apply(position, repeatNum);
            dispatch(_UPDATE);
            if (_onUpdate != null) _onUpdate();
        }
    }

    private inline function _head(repeatNum:Int) {
        _apply(0, repeatNum);
        dispatch(_HEAD);
        if (_onHead != null)         _onHead();
        dispatch(_UPDATE);
        if (_onUpdate != null)     _onUpdate();
    }
    private inline function _foot(repeatNum:Int) {
        _apply(_time, repeatNum);
        dispatch(_UPDATE);
        if (_onUpdate != null)     _onUpdate();
        dispatch(_FOOT);
        if (_onFoot != null)         _onFoot();
    }

    private inline function _finish() {
        _currentTime = _totalTime;
        dispatch(_FINISH);
        if (_onFinish != null) _onFinish();
        _stop();
    }

    private function _apply(p:Float, repeatNum:Int) {
        var t = _getPosition(p, (repeatNum % 2) == 1);

        switch(_type) {
            case FROM_TO(target, _from, _to):
                var t2     = 1 - t;
                if (_fastMode) {
                    for (key in _toKeys){
                        setField(
                            target, key,
                            _fastCalc(field(_from, key), field(_to, key), t, t2)
                        );
                    }
                } else {
                    for (key in _toKeys){
                        setField(
                            target, key,
                            _calc(field(_from, key), field(_to, key), t, t2)
                        );
                    }
                }

            case ARRAY(targets, froms, tos):
                var t2     = 1 - t;
                var i = 0;
                if (false) {
                    for (target in targets) {
                        var _to = tos[i];
                        var _from = froms[i++];
                        for (key in _toKeys)
                            setField(
                                target, key,
                                _fastCalc(field(_from, key), field(_to, key), t, t2)
                            );
                    }
                } else {
                    for (target in targets) {
                        var _to = tos[i];
                        var _from = froms[i++];
                        for (key in _toKeys)
                            setField(
                                target, key,
                                _calc(field(_from, key), field(_to, key), t, t2)
                            );
                    }
                }
            case FUNC(func, _from, _to):
                var t2     = 1 - t;
                var arr = [];
                for (i in 0..._to.length) arr[i] = _calc(_from[i], _to[i], t, t2);
                Reflect.callMethod(null, func, arr);

            case GROUP(g):
                    var ts = g.tweens;
                    var spent     = (_time * t - g.current) * 1.00000001;
                    if (spent < 0)     for (i in (1-ts.length)...1)     { ts[-i]._update(spent); }
                    else                 for (i in 0...ts.length)         { ts[i]._update(spent); }
                    g.current = g.tweens[0].currentTime;

            case CALL(f):
                    if (t == 1) f();
        }
    }

    private inline function _fastCalc(_from:Dynamic, _to:Dynamic, t1:Float, t2:Float):Dynamic {
        return _from * t2 + _to * t1;
    }

    private inline function _calc(_from:Dynamic, _to:Dynamic, t1:Float, t2:Float):Dynamic {
        if (Std.isOfType(_to, Float)) {
            var d:Dynamic = _from * t2 + _to * t1;
            return d;
        }else {
            var i = 0, l = _rules.length, f:RuleX<Dynamic,Dynamic>, result:Dynamic = null, ok:Bool = false;
            while (i < l) {
                if (Std.isOfType(_to, (f = _rules[i++]).inputClass)) {
                    ok = true;
                    result = f.calc(_from, _to, t1, t2, this);
                    break;
                }
            }
            if (!ok) throw error("The tween rule for " + Type.getClassName(Type.getClass(_to)) + " is not defined");
            return result;
        }
    }

    /*
     * パラメータ変更
     */
    public function time(value:Float) {
        if (value < 0) throw error("Can't be negative value");
        checkInited();
        _timeIsDefault = false;
        _time = value;
        return this;
    }
    public function ease(value:Float->Float) {
        checkInited();
        _easeIsDefault = false;
        _ease = value;
        return this;
    }
    public function delay(value:Float) {
        if (value < 0) throw error("Can't be negative value");
        checkInited();
        _delayIsDefault = false;
        _delay = value;
        return this;
    }
    public function rest(value:Float) {
        if (value < 0) throw error("Can't be negative value");
        checkInited();
        _rest = value;
        return this;
    }
    public function interval(value:Float) {
        if (value < 0) throw error("Can't be negative value");
        checkInited();
        _intervalIsDefault = false;
        _interval = value;
        return this;
    }
    public function repeat(value:Int = 0) {
        if (value < 0) throw error("Can't be negative value");
        checkInited();
        _repeatIsDefault = false;
        _repeat = value;
        return this;
    }
    public function yoyo(value:Bool = true) {
        checkInited();
        _yoyoIsDefault = false;
        _yoyo = value;
        return this;
    }
    public function zigzag(value:Bool = true) {
        checkInited();
        _zigzagIsDefault = false;
        _zigzag = value;
        return this;
    }
    public function autoPlay(value:Bool = true) {
        checkInited();
        _autoPlayIsDefault = false;
        _autoPlay = value;
        return this;
    }
    public function skip(delay:Float = 0) {
        checkInited();
        _skip = delay;
        return this;
    }
    public function setTimeScale(value:Float = 0) {
        timeScale = value;
        return this;
    }

    /*
     * イベントハンドラの設定
     */
    public function onPlay(handler:Void->Void) {
        _onPlay = handler;
        return this;
    }
    public function onStop(handler:Void->Void){
        _onStop = handler;
        return this;
    }
    public function onDelay(handler:Void->Void) {
        _onDelay = handler;
        return this;
    }
    public function onHead(handler:Void->Void) {
        _onHead = handler;
        return this;
    }
    public function onUpdate(handler:Void->Void){
        _onUpdate = handler;
        return this;
    }
    public function onFoot(handler:Void->Void) {
        _onFoot = handler;
        return this;
    }
    public function onRest(handler:Void->Void) {
        _onRest = handler;
        return this;
    }
    public function onInterval(handler:Void->Void) {
        _onInterval = handler;
        return this;
    }
    public function onRepeat(handler:Void->Void){
        _onRepeat = handler;
        return this;
    }
    public function onFinish(handler:Void->Void) {
        _onFinish = handler;
        return this;
    }

    public function addEventListener(type:String, listener:TweenX->Void) {
        _addEventListener(type, listener);
        return this;
    }
    public function removeEventListener(type:String, listener:TweenX->Void) {
        _removeEventListener(type, listener);
        return this;
    }
    private inline function _addEventListener(type:String, listener:Dynamic) {
        var i = eventIndex(type);
        if (i < 0) return;
        var arr =     if (_eventListeners[i] == null)     _eventListeners[i] = [];
                    else                                _eventListeners[i];
        if (! arr.has(listener)) arr.push(listener);
    }
    private inline function _removeEventListener(type:String, listener:Dynamic) {
        var i = eventIndex(type);
        if (i < 0) return;
        if (_eventListeners[i] != null)
            _eventListeners[i].remove(listener);
    }


    /*
     * 動的ユーティリティ
     */
    private inline function _getPosition(p:Float, back:Bool):Float {
        var t = (p / _time);
        if (_odd)         back     = !back;
        if (_inverted) t         = 1 - t;
        if (back){
            if (_yoyo)     t = 1 - t;
            t = _ease(t);
            if (_zigzag)     t = 1 - t;
        }else {
            t = _ease(t);
        }
        return t;
    }
    private function checkInited():Void {
        if (_inited) throw error("Can't change params after initialization");
    }
    private inline function dispatch(num:Int) {
        #if (tweenx_debug)
        if (num){
            var action = EVENT_ARRAY[num];
            var p = definedPosInfos;
            #if (tweenx_debug_hide_update) if (action != "UPDATE") #end
            haxe.Log.trace("Tween_" + id + "(generated at " + p.className + "/" + p.methodName + "()[" + p.fileName + ":" + p.lineNumber + "]) " + action, _updatePosInfo);
        }
        #end
        var listeners = _eventListeners[num ];
        if (listeners != null) for (f in listeners) f(this);
    }

    private function initGroup(g:GroupX) {
        var df = null, gd:Bool = false;

        if (g.defaults != null){
            df = dumpDefaults();
            gd = _groupDefaults;
            _groupDefaults = true;
            setDefaults(g.defaults);
            TweenX.defaultAutoPlay = false;
        }

        var delay  = 0.0;
        var max    = 0.0;
        var result = [];

        switch(g.type) {
        case SERIAL:
            for (t in g.source) {
                if (t == null) continue;
                switch(t.command) {
                case WAIT(d): delay += d;
                case TWEEN(o):
                    result.push(o);
                    o._autoPlay = false;

                    if (_groupDefaults && o._delayIsDefault)
                        o._delay     = TweenX.defaultDelay;

                    o._init();
                    o._delay         += delay;
                    o._totalTime     += delay;

                    var totalTime = o._totalTime;
                    delay = (o._skip != null) ? (delay + o._skip) : totalTime;
                    if (max < totalTime) max = totalTime;
                }
            }
        case LAG(lag):
            for (t in g.source){
                if (t == null) continue;
                switch(t.command) {
                case WAIT(d):
                    delay += d;
                case TWEEN(o):
                    result.push(o);

                    o._init();
                    o._delay         += delay;
                    o._totalTime     += delay;

                    var totalTime = o._totalTime;
                    delay += (o._skip != null) ? o._skip : lag;
                    if (max < totalTime) max = totalTime;
                }
            }
        }
        for (t in result) {
            var diff         =     max - t._totalTime;
            t._rest         +=     diff;
            t._totalTime     +=     diff;
        }

        _time         = max;
        g.tweens     = result;
        g.source      = null;

        if (g.defaults != null) {
            _groupDefaults = gd;
            setDefaults(df);
        }
    }
}
private typedef Log = { target:Dynamic, data:Dynamic }
