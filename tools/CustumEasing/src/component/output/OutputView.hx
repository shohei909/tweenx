package component.output;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.output.OutputModeSelectView;
import core.RootContext;
import core.output.OutputManager;
import tweenxcore.expr.ComplexEasingKind;

class OutputView extends ReactComponentOfProps<OutputProps>
{
    public function new(props:OutputProps) 
    {
        super(props);
    }
    
    override public function render():ReactComponent 
    {
        var output = props.context.output;
        return "div".createElement(
            { 
                className: "output" 
            },
            [
                OutputModeSelectView.createElement(
                    {
                        context: props.context,
                        mode: output.mode,
                    }
                ),
                "pre".createElement(
                    {},
                    output.getString()
                )
            ]
        );
    }
}

typedef OutputProps =
{
    context: RootContext,
}
