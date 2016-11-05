package component.complex;
import core.RootCommand;
import core.drag.DragManager;
import core.drag.DragState;
import core.drag.DragStateKind;
import core.easing.EasingCommand;
import js.html.MouseEvent;

class ComplexEasingDrag implements DragState
{
    private var drag:DragManager;
    public var kind(default, null):DragStateKind;
    public var fromId(default, null):ComplexEasingId;
    public var toId(default, null):ComplexEasingId;
    
    public function new (drag:DragManager, id:ComplexEasingId)
    {
        this.drag = drag;
        this.fromId = id;
        this.toId = id;
        this.kind = DragStateKind.ComplexEasing(this);
    }
    
    public function move(e:MouseEvent):Void 
    {
    }
    
    public function finish():Void 
    {
        if (drag.context.key.ctrl)
        {
            drag.context.apply(RootCommand.ChangeEasing(toId, EasingCommand.Paste(fromId)), true);
        }
        else
        {
            drag.context.apply(RootCommand.ChangeEasing(toId, EasingCommand.Move(fromId)), true);
        }
    }
    
    public function enter(id:ComplexEasingId):Void
    {
        toId = id;
        drag.context.update();
    }
    
    public function leave():Void
    {
        if (!toId.isEmpty())
        {
            toId = toId.child();
        }
        else
        {
            toId = fromId;
        }
        
        drag.context.update();
    }
}