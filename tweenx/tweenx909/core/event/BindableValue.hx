package tweenx909.core.event;

/**
 * ...
 * @author shohei909
 */
class BindableValue<T>
{
	private var handlers:Array<T->T->Void>;
	private var _value:T;
	public var value(get, set):T;
	public function get_value() {
		return _value;
	}
	public function set_value(value:T) {
		if (_value != value) {
			dispatchChange(_value, _value = value);
		}
		return _value;
	}

	public function new(value:T) {
		_value = value;
		handlers = [];
	}

	public function addHandler(onChange:T->T->Void) {
		handlers.push(onChange);
	}

	public function removeHandler(onChange:T->T->Void) {
		handlers.remove(onChange);
	}

	function dispatchChange(oldValue:T, newValue:T) {
		for (handler in handlers) {
			handler(oldValue, newValue);
		}
	}

	public function update(value:T) {
		dispatchChange(_value, _value = value);
	}

	public function silentUpdate(value:T) {
		_value = value;
	}
}
