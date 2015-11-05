package tweenxcore.event;

/**
 * ...
 * @author shohei909
 */
class SingleEventDispatcher
{
	var handlers:Array<Void->Void>;

	public function new()
	{
		handlers = [];
	}

	public function addHandler(handler:Void->Void) {
		handlers.push(handler);
	}

	public function removeHandler(handler:Void->Void) {
		handlers.remove(handler);
	}

	public function dispatchEvent() {
		for (handler in handlers) {
			handler();
		}
	}
}
