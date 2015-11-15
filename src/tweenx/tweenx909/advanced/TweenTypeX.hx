package tweenx909.advanced;

/**
 *
 * @author shohei909
 */
enum TweenTypeX {
    GROUP(group:GroupX);
    ARRAY(targets:Iterable<Dynamic>, _from:Array<Dynamic>, _to:Array<Dynamic>);
    FROM_TO(target:Dynamic, _from:Dynamic, _to:Dynamic);
    FUNC(func:Dynamic, _from:Array<Dynamic>, _to:Array<Dynamic>);
    CALL(func:Void->Void);
}
