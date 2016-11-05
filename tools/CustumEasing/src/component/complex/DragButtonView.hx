package component.complex;
import api.react.React;
import api.react.ReactComponent;
import component.complex.ComplexEasingView.ComplexEasingProps;
import core.RootContext;
import tweenxcore.expr.ComplexEasingKind;

class DragButtonView extends ReactComponentOfProps<ComplexEasingProps>
{
    public function new(props:ComplexEasingProps) 
    {
        super(props);
    }
    
    override public function render():ReactComponent 
    {
        return React.createElement(
            "div",
            { 
                className: "swap-button-box" 
            },
            React.createElement(
                "button",
                {
                    className: "btn btn-default btn",
                    onMouseDown: onMouseDown,
                },
                React.createElement(
                    "span",
                    { className: "glyphicon glyphicon-" + if (props.context.key.ctrl) "duplicate" else "sort" }
                )
            )
        );
    }
    
    private function onMouseDown():Void 
    {
        props.context.drag.dragComplexEasing(props.id);
    }
}


typedef SwapButtonProps =
{
    easing: ComplexEasingKind,
    id: ComplexEasingId,
    context: RootContext,
}