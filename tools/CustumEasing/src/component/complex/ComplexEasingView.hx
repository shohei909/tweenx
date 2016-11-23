package component.complex;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.GraphColor;
import component.basic.PreviewView;
import component.complex.ComplexEasingSelectView;
import component.basic.GraphView;
import component.simple.SimpleEasingView;
import component.unary.UnaryOpView;
import core.RootContext;
import component.complex.ComplexEasingId;
import core.drag.DragStateKind;
import haxe.ds.Option;
import js.html.MouseEvent;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ComplexEasingKindTools;
using component.complex.ComplexEasingId;

class ComplexEasingView extends ReactComponentOfProps<ComplexEasingProps>
{
    public function new(props:ComplexEasingProps) 
    {
        super(props);
    }
    
    override public function render():ReactComponent 
    {
        var background = switch (props.context.drag.stateKind)
        {
            case Option.Some(DragStateKind.ComplexEasing(detail)) if (detail.fromId.equals(props.id)):
                "from";
                
            case Option.Some(DragStateKind.ComplexEasing(detail)) if (detail.toId.equals(props.id)):
                "to";
                
            case _:
                "";
        }
        
        return React.createElement(
            "div",
            { className: "complex-easing" },
            React.createElement(
                "div",
                { 
                    ref: "head",
                    className: "complex-easing-head " + background,
                    onMouseEnter: onMouseEnter,
                    onMouseLeave: onMouseLeave,
                },
                DragButtonView.createElement(props),
                GraphView.createElement(
                    {
                        lines: [
                            { easing: ComplexEasingKindTools.toFunction(props.easing), color: GraphColor.Theme }
                        ],
                        partations: [],
                        scale: 1,
                    }
                ),
                React.createElement(
                    "div",
                    { 
                        className: "complex-easing-child"
                    },
                    PreviewView.createElement(props),
                    ComplexEasingSelectView.createElement(props),
                    switch (props.easing)
                    {
                        case ComplexEasingKind.Simple(kind):
                            SimpleEasingView.createElement(
                                { 
                                    kind: kind,
                                    id: props.id,
                                    context: props.context,
                                }
                            );
                            
                        case ComplexEasingKind.Op(easing, op):
                            UnaryOpView.createElement(
                                { 
                                    easing: easing,
                                    op: op,
                                    id: props.id,
                                    context: props.context,
                                }
                            );
                    }
                )
            )
        );
    }
    
    private function onMouseEnter(e:MouseEvent):Void
    {
        switch (props.context.drag.stateKind)
        {
            case Option.Some(DragStateKind.ComplexEasing(detail)):
                detail.enter(props.id);
                e.preventDefault();
                
            case _:
        }
    }
    
    private function onMouseLeave(e:MouseEvent):Void
    {
        switch (props.context.drag.stateKind)
        {
            case Option.Some(DragStateKind.ComplexEasing(detail)) if (detail.toId.equals(props.id)):
                detail.leave();
                e.preventDefault();
                
            case _:
        }
    }
}

typedef ComplexEasingProps =
{
    easing: ComplexEasingKind,
    id: ComplexEasingId,
    context: RootContext
}
