package tweenx909.core.tools;

/**
 * ...
 * @author shohei909
 */
class ArrayTools
{
	static public inline function pushAll<T>(array:Array<T>, array2:Array<T>)
	{
		for (i in array2) {
			array.push(i);
		}
	}
}
