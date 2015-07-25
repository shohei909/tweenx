package tweenx909.core.scheduler;
using tweenx909.core.tools.FloatTools;

/**
 * @author shohei909
 */
class Scheduler {

	var activeElements:Array<ScheduledElement>;
	var scheduledElements:Array<ScheduledElement>;
	public var time(default, null):Float = 0;

	public function new() {
		activeElements = [];
		scheduledElements = [];
	}

	public function add(element:ScheduledElement) {
		scheduledElements.push(element);
	}

	public function progress(progressTime:Float) {
		update(time + progressTime);
	}

	public function update(time:Float) {
		this.time = time;

		var next = [];
		for (element in scheduledElements) {
			if (element.openTime <= time) {
				activeElements.push(element);
				element.onOpen();
				element.update(0);
			} else {
				next.push(element);
			}
		}
		scheduledElements = next;

		var next = [];
		for (element in activeElements) {
			if (element.closeTime <= time) {
				element.update(1);
				element.onClose();
			} else {
				element.update(time.inverseLerp(element.openTime, element.closeTime).clamp());
				next.push(element);
			}
		}
		activeElements = next;
	}

	public function removeAll() {
		for (element in activeElements) {
			element.onClose();
		}

		activeElements = [];
		scheduledElements = [];
	}
}
