package component.basic;
import api.react.ReactEvent;
import component.basic.NumberInputId;
import core.RootCommand;
import core.focus.FocusManager;
import haxe.ds.Option;
import js.html.Element;
import js.html.Event;
import js.html.Text;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.InOutKind;
import tweenxcore.expr.SimpleEasingKind;

class NumberInputFocus 
{
    private var focus:FocusManager;
    public var text(default, null):String;
    public var id(default, null):NumberInputId;
    
    public function new (focus:FocusManager, id:NumberInputId, text:String)
    {
        this.text = text;
        this.focus = focus;
        this.id = id;
    }
    
    public function change(event:ReactEvent):Void
    {
        var input:Element = cast event.target;
        this.text = untyped input.value;
        var value = Std.parseFloat(text);
        
        if (!Math.isNaN(value))
        {
            focus.context.applyNumberChange(id, value, true);
        }
        else
        {
            focus.context.update();
        }
    }
    
    public function submit(event:ReactEvent):Void
    {
        var input:Element = cast event.target;
        input.blur();
        focus.unfocus();
    }
}
