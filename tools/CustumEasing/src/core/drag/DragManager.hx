package core.drag;
import component.basic.NumberInputId;
import component.basic.NumberSliderDrag;
import core.RootContext;
import haxe.ds.Option;
import js.Browser;
import js.html.MouseEvent;

class DragManager 
{
	public var context(default, null):RootContext;
	public var state(default, null):Option<DragState>;
	
	public var stateKind(get, never):Option<DragStateKind>;
	private function get_stateKind():Option<DragStateKind> 
	{
		return switch (state)
		{
			case Option.Some(detail):
				Option.Some(detail.kind);
				
			case Option.None:
				Option.None;
		}
	}
	
	public function new(context:RootContext) 
	{
		this.context = context;
		state = Option.None;
		
		Browser.window.addEventListener("mouseup", onMouseUp);
		Browser.window.addEventListener("mousemove", onMouseMove);
	}
	
	private function onMouseUp(event:MouseEvent):Void 
	{
		finishDrag();
	}
	
	private function onMouseMove(event:MouseEvent):Void 
	{
		switch (state)
		{
			case Option.Some(detail):
				detail.move(event);
				
			case Option.None:
		}
	}
	
	private function finishDrag():Void 
	{
		switch (state)
		{
			case Option.Some(detail):
				state = Option.None;
				detail.finish();
				
			case Option.None:
		}
	}
	
	public function dragNumberSlider(id:NumberInputId, startX:Float, centerX:Float, centerValue:Float):Void 
	{
		finishDrag();
		state = Option.Some((new NumberSliderDrag(this, id, startX, centerX, centerValue):DragState));
	}
}

