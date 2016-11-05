package component.basic;
import api.react.ReactEvent;
import component.basic.NumberInputId;
import core.RootCommand;
import core.drag.DragManager;
import core.drag.DragState;
import core.drag.DragStateKind;
import core.focus.FocusManager;
import haxe.ds.Option;
import js.html.Element;
import js.html.Event;
import js.html.MouseEvent;
import js.html.Text;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.InOutKind;
import tweenxcore.expr.SimpleEasingKind;

class NumberSliderDrag implements DragState
{
    private var drag:DragManager;
    private var centerX:Float;
    private var currentX:Float;
    
    public var centerValue(default, null):Float;
    public var kind(default, null):DragStateKind;
    public var id(default, null):NumberInputId;
    
    public function new (drag:DragManager, id:NumberInputId, currentX:Float, centerX:Float, centerValue:Float)
    {
        this.drag = drag;
        this.centerValue = centerValue;
        this.currentX = currentX;
        this.centerX = centerX;
        this.id = id;
        kind = DragStateKind.NumberSlider(this);
        apply(false);
    }
    
    public function getCurrentValue():Float
    {
        var value = centerValue + ((currentX - centerX) / (NumberSliderView.BAR_WIDTH / 2));
        return Math.floor(value * 50) / 50;
    }
    
    public function move(e:MouseEvent):Void 
    {
        currentX = e.clientX;
        apply(false);
    }
    
    public function finish():Void 
    {
        drag.context.focus.unfocus();
        apply(true);
    }
    
    public function apply(major:Bool):Void
    {
        drag.context.applyNumberChange(id, getCurrentValue(), major);
    }
}
