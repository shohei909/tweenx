package core.key;
import core.GlobalContext;
import js.Browser;
import js.html.KeyboardEvent;

class KeyboardManager 
{
	private var context:GlobalContext;
	
	public function new(context:GlobalContext) 
	{
		this.context = context;
		Browser.window.addEventListener("keydown", onKeyDown);
	}	
	
	private function onKeyDown(e:KeyboardEvent):Void 
	{
		switch [e.altKey, e.ctrlKey, e.shiftKey, e.keyCode]
		{
			case [false, true, false, KeyboardEvent.DOM_VK_Z]:
				context.history.undo();
				e.preventDefault();
				
			case [false, true, false, KeyboardEvent.DOM_VK_Y]:
				context.history.redo();
				e.preventDefault();
				
			case _:
		}
	}
}