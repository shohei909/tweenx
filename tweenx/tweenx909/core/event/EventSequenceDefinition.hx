package tweenx909.core.event;
import tweenx909.core.tools.FloatTools;

/**
 * ...
 * @author shohei909
 */

class EventSequenceDefinition {
	public var closing(default, null):UnitEventDispatcher;
	public var opening(default, null):UnitEventDispatcher;

	public var startTime(default, null):Float;
	public var endTime(default, null):Float;
	public var totalWeight:Float = 0;

	var sortedValues:Array<Float>;
	var currentElement:EventSequenceElement;
	var handlers:Array<EventSequenceHandler>;
	var over:Bool = false;
	var currentTime:Float;

	public function new (currentTime:Float, startTime:Float, endTime:Float) {
		opening = new UnitEventDispatcher();
		closing = new UnitEventDispatcher();

		sortedValues = [0];
		handlers = [];

		this.startTime = startTime;
		this.endTime = endTime;
		updateOver();
	}

	public function add(weight:Float, handler:EventSequenceHandler) {
		totalWeight += weight;
		sortedValues.push(totalWeight);
		handlers.push(handler);
		return this;
	}

	public function update(time:Float) {
		var prevTime = currentTime;
		var prevOver = over;

		currentTime = time;
		updateOver();

		if (prevOver) {
			if (!over) {
				closing.dispatchEvent();
			}
		} else {
			if (over) {
				opening.dispatchEvent();
			}
		}

		if (totalWeight == 0) {
			return;
		}

		var position = FloatTools.inverseLerp(time, startTime, endTime) * totalWeight;
		var number = FloatTools.binarySearch(position, sortedValues) - 1;

		if (currentElement != null) {
			if (currentElement.number == number) {
				updateElement(position, number);
			} else {
				currentElement.closing.dispatchEvent();
				startElement(position, number);
			}
		} else {
			startElement(position, number);
		}
	}

	function startElement(position:Float, number:Int) {
		if (number == -1 || number == handlers.length) {
			return;
		}

		currentElement = new EventSequenceElement(number);
		switch (handlers[number]) {
			case None:

			case Open(handler):
				handler(currentElement);

			case Update(handler):
				currentElement.updating.addHandler(handler);
		}
	}

	function updateElement(position:Float, number:Int)
	{
		var rate = FloatTools.inverseLerp(position, sortedValues[number], sortedValues[number + 1]);
		currentElement.updating.dispatchEvent(rate);
	}

	function updateOver()
	{
		over = (startTime <= currentTime && currentTime < endTime);
	}
}
