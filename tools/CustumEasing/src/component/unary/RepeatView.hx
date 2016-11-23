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
import tweenxcore.expr.UnaryOpKind;
import tweenxcore.expr.UnaryOpKindTools;


class RepeatView extends ReactComponentOfProps<RepeatProps>
{
    public function new(props:RepeatProps) 
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
                    name: props.context.localize.resource.common(ResourceKey.Repeat),
                    value: props.repeat,
                    id: props.id.numberInputId(0),
                    context: props.context
                }
            ),
            GraphView.createElement(
                {
                    lines: [
                        { easing: UnaryOpKindTools.toFunction(UnaryOpKind.Repeat(props.repeat), props.easing), color: GraphColor.Theme },
                    ],
                    partations: [for (i in 0...Math.ceil(props.repeat - 1)) (i + 1) / props.repeat],
                    scale: 0.45,
                }
            )
        );
    }
}

typedef RepeatProps =
{
    easing: ComplexEasingKind,
    repeat: Float,
    id: ComplexEasingId,
    context: RootContext
}
