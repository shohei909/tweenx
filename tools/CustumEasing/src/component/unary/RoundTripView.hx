package component.unary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.GraphColor;
import component.basic.GraphView;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.RoundTripKind;
import tweenxcore.expr.UnaryOpKind;
import tweenxcore.expr.UnaryOpKindTools;

class RoundTripView extends ReactComponentOfProps<RoundTripProps>
{
    public function new(props:RoundTripProps) 
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
            GraphView.createElement(
                {
                    lines: [
                        { easing: UnaryOpKindTools.toFunction(UnaryOpKind.RoundTrip(props.roundTrip), props.easing), color: GraphColor.Theme },
                    ],
                    partations: [0.5],
                    scale: 0.45,
                }
            )
        );
    }
}

typedef RoundTripProps =
{
    easing: ComplexEasingKind,
    roundTrip: RoundTripKind,
}
