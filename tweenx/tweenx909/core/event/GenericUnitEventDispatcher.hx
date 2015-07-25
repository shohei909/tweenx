package tweenx909.core.event;

/**
 * ...
 * @author shohei909
 */
class GenericUnitEventDispatcher<T>
{
	var handlers:Array<T->Void>;

	public function new()
	{
		handlers = [];
	}

	public function addHandler(handler:T->Void) {
		handlers.push(handler);
	}

	public function removeHandler(handler:T->Void) {
		handlers.remove(handler);
	}

	public function dispatchEvent(event:T) {
		for (handler in handlers) {
			handler(event);
		}
	}
}
