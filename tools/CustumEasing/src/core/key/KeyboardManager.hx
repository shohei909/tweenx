package core.key;
import core.RootContext;
import js.Browser;
import js.html.KeyboardEvent;

class KeyboardManager 
{
    private var context:RootContext;
    public var ctrl(default, null):Bool = false;
    public var shift(default, null):Bool = false;
    public var alt(default, null):Bool = false;
    
    public function new(context:RootContext) 
    {
        this.context = context;
        Browser.window.addEventListener("keydown", onKeyDown);
        Browser.window.addEventListener("keyup", onKeyUp);
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
            
            case [_, _, _, KeyboardEvent.DOM_VK_CONTROL]:
                ctrl = true;
                context.update();
                
            case [_, _, _, KeyboardEvent.DOM_VK_SHIFT]:
                shift = true;
                
            case [_, _, _, KeyboardEvent.DOM_VK_ALT]:
                alt = true;
                
            case _:
        }
    }
    
    private function onKeyUp(e:KeyboardEvent):Void 
    {
        switch [e.altKey, e.ctrlKey, e.shiftKey, e.keyCode]
        {
            case [_, _, _, KeyboardEvent.DOM_VK_CONTROL]:
                ctrl = false;
                context.update();
                
            case [_, _, _, KeyboardEvent.DOM_VK_SHIFT]:
                shift = false;
                
            case [_, _, _, KeyboardEvent.DOM_VK_ALT]:
                alt = false;
                
            case _:
        }
    }
}