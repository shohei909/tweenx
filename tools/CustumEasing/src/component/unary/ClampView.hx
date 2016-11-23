package component.unary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.GraphColor;
import component.basic.GraphView;
import component.basic.NumberInputView;
import component.complex.ComplexEasingId;
import core.RootContext;
import core.localize.ResourceKey;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ComplexEasingKindTools;
import tweenxcore.expr.UnaryOpKind;
import tweenxcore.expr.UnaryOpKindTools;


class ClampView extends ReactComponentOfProps<ClampProps>
{
    public function new(props:ClampProps) 
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
                    name: props.context.localize.resource.common(ResourceKey.Min),
                    value: props.min,
                    id: props.id.numberInputId(0),
                    context: props.context
                }
            ),
            NumberInputView.createElement(
                {
                    name: props.context.localize.resource.common(ResourceKey.Max),
                    value: props.max,
                    id: props.id.numberInputId(1),
                    context: props.context
                }
            ),
            GraphView.createElement(
                {
                    lines: [
                        { easing: function (r) return props.max, color: GraphColor.Sub },
                        { easing: function (r) return props.min, color: GraphColor.Sub },
                        { easing: UnaryOpKindTools.toFunction(UnaryOpKind.Clamp(props.min, props.max), props.easing), color: GraphColor.Theme },
                    ],
                    partations: [],
                    scale: 0.45,
                }
            )
        );
    }
}

typedef ClampProps =
{
    easing: ComplexEasingKind,
    min: Float,
    max: Float,
    id: ComplexEasingId,
    context: RootContext
}
