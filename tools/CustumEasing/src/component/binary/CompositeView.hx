package component.binary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import tweenxcore.expr.ComplexEasingKind;

class CompositeView extends ReactComponentOfProps<CompositeProps>
{
    public function new(props:CompositeProps) 
    {
        super(props);
    }
    
    override public function render():ReactComponent 
    {
        return null;
    }
}

typedef CompositeProps =
{
    easing1: ComplexEasingKind,
    easing2: ComplexEasingKind,
}
