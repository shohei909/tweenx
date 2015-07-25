package tweenx909.core.scheduler;

/**
 * @author shohei909
 */
typedef ScheduledElement =
{
	public var openTime(default, never):Float;
	public var closeTime(default, never):Float;

	public function onOpen():Void;
	public function update(rate:Float):Void;
	public function onClose():Void;
}
