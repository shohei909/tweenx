package component.complex;
import api.react.React;
import api.react.ReactComponent;
import component.complex.ComplexEasingView.ComplexEasingProps;
import core.RootContext;
import core.drag.DragStateKind;
import core.localize.ResourceKey;
import haxe.ds.Option;
import js.html.MouseEvent;
import tweenxcore.expr.ComplexEasingKind;
using component.complex.ComplexEasingId;
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
            [
                switch (props.context.drag.stateKind)
                {
                    case Option.Some(DragStateKind.ComplexEasing(detail)) if (detail.fromId.equals(props.id)):
                        React.createElement(
                            "div",
                            { 
                                className: "label label-default" 
                            },
                            props.context.localize.resource.common(if (props.context.key.ctrl) ResourceKey.DropToDuplicate else ResourceKey.DropToMove)
                        );
                        
                    case _:
                        React.createElement(
                            "button",
                            {
                                className: "btn btn-default btn-sm",
                                onMouseDown: onMouseDown,
                            },
                            React.createElement(
                                "span",
                                { className: "glyphicon glyphicon-" + if (props.context.key.ctrl) "duplicate" else "sort" }
                            )
                        );
                }
            ]
        );
    }
    
    private function onMouseDown(e:MouseEvent):Void 
    {
        props.context.drag.dragComplexEasing(props.id);
        e.preventDefault();
    }
}


typedef SwapButtonProps =
{
    easing: ComplexEasingKind,
    id: ComplexEasingId,
    context: RootContext,
}