package tweenx909.advanced;

/**
 * 
 * @author shohei909
 */
enum TweenTypeX {
	GROUP( group:GroupX );
	ARRAY( targets:Iterable<Dynamic>, from:Array<Dynamic>, to:Array<Dynamic> );
	FROM_TO( target:Dynamic, from:Dynamic, to:Dynamic );
	FUNC( func:Dynamic, from:Array<Dynamic>, to:Array<Dynamic> );
	CALL( func:Void->Void );
}