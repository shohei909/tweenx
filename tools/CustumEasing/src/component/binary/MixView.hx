package component.binary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.NumberInputView;
import component.complex.ComplexEasingId;
import core.RootContext;
import core.localize.ResourceKey;
import tweenxcore.expr.ComplexEasingKind;

class MixView extends ReactComponentOfProps<MixProps>
{
    public function new(props:MixProps) 
    {
        super(props);
    }
    
    override public function render():ReactComponent 
    {
        return React.createElement(
            "div",
            {
                className: "param-group"
            }, 
            NumberInputView.createElement(
                {
                    name: props.context.localize.resource.common(ResourceKey.Weight),
                    value: props.strength,
                    id: props.id.numberInputId(0),
                    context: props.context
                }
            )
        );
    }
}

typedef MixProps =
{
    easing1: ComplexEasingKind,
    easing2: ComplexEasingKind,
    strength: Float,
    id: ComplexEasingId,
    context: RootContext
}
