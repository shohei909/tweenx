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
import tweenxcore.expr.BinaryOpKind;
import tweenxcore.expr.BinaryOpKindTools;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ComplexEasingKindTools;

class OneTwoView extends ReactComponentOfProps<OneTwoProps>
{
    public function new(props:OneTwoProps) 
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
                    name: props.context.localize.resource.common(ResourceKey.SwitchTime),
                    value: props.switchTime,
                    id: props.id.numberInputId(0),
                    context: props.context
                }
            ),
            GraphView.createElement(
                {
                    lines: [
                        { easing: BinaryOpKindTools.toFunction(BinaryOpKind.OneTwo(props.switchTime), props.easing1, props.easing2), color: GraphColor.Theme },
                    ],
                    partations: [props.switchTime],
                    scale: 0.45,
                }
            )
        );
    }
}

typedef OneTwoProps =
{
    easing1: ComplexEasingKind,
    easing2: ComplexEasingKind,
    switchTime: Float,
    id: ComplexEasingId,
    context: RootContext
}
