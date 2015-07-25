package tweenx909.core.event;

/**
 * ...
 * @author shohei909
 */
enum EventSequenceHandler
{
	None;
	Open(handler:EventSequenceElement->Void);
	Update(handler:Float->Void);
}
