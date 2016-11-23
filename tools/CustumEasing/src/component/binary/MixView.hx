package component.binary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.GraphColor;
import component.basic.GraphView;
import component.basic.NumberInputView;
import component.complex.ComplexEasingId;
import core.RootContext;
import core.localize.ResourceKey;
import tweenxcore.expr.BinaryOpKindTools;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ComplexEasingKindTools;
import tweenxcore.expr.UnaryOpKind;
import tweenxcore.expr.UnaryOpKindTools;

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
            ),
            GraphView.createElement(
                {
                    lines: [
                        { easing: function (r) return props.strength, color: GraphColor.Sub },
                        { easing: function (r) return ComplexEasingKindTools.toFunction(props.easing1)(r).lerp(props.strength, 1), color: GraphColor.Theme },
                        { easing: function (r) return ComplexEasingKindTools.toFunction(props.easing2)(r).lerp(0, props.strength), color: GraphColor.Theme },
                    ],
                    partations: [],
                    scale: 0.45,
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
