package tweenx909.core.event;

/**
 * @author shohei909
 */
class EventSequencer
{
	public var value(default, null):Float;
	var definitions(default, null):Array<EventSequenceDefinition>;

	public function new(startValue:Float = 0)
	{
		value = startValue;
		definitions = [];
	}

	public function define(startValue:Float = 0, endValue:Float = 1) {
		var d = new EventSequenceDefinition(value, startValue, endValue);
		definitions.push(d);
		return d;
	}

	public function update(value:Float) {
		this.value = value;
		for (d in definitions) {
			d.update(value);
		}
	}

	public function silentUpdate(value:Float) {
		this.value = value;
	}
}
