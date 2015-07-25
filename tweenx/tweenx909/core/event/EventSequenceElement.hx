package tweenx909.core.event;

/**
 * ...
 * @author shohei909
 */

class EventSequenceElement {
	public var closing(default, null):UnitEventDispatcher;
	public var updating(default, null):GenericUnitEventDispatcher<Float>;
	public var number(default, null):Int;

	public function new (number:Int) {
		this.number = number;
		closing = new UnitEventDispatcher();
		updating = new GenericUnitEventDispatcher();
	}
}
