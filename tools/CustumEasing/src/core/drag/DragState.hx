package core.drag;
import component.basic.NumberInputId;
import component.basic.NumberSliderDrag;
import js.html.MouseEvent;

interface DragState 
{
	public var kind(default, null):DragStateKind;
	public function move(e:MouseEvent):Void;
	public function finish():Void;
}
