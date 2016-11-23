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


class LerpView extends ReactComponentOfProps<LerpProps>
{
    public function new(props:LerpProps) 
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
                    name: props.context.localize.resource.common(ResourceKey.From),
                    value: props.from,
                    id: props.id.numberInputId(0),
                    context: props.context
                }
            ),
            NumberInputView.createElement(
                {
                    name: props.context.localize.resource.common(ResourceKey.To),
                    value: props.to,
                    id: props.id.numberInputId(1),
                    context: props.context
                }
            ),
            GraphView.createElement(
                {
                    lines: [
                        { easing: function (r) return props.to, color: GraphColor.Sub },
                        { easing: function (r) return props.from, color: GraphColor.Sub },
                        { easing: UnaryOpKindTools.toFunction(UnaryOpKind.Lerp(props.from, props.to), props.easing), color: GraphColor.Theme },
                    ],
                    partations: [],
                    scale: 0.45,
                }
            )
        );
    }
}

typedef LerpProps =
{
    easing: ComplexEasingKind,
    from: Float,
    to: Float,
    id: ComplexEasingId,
    context: RootContext
}
