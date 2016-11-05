package component.basic;
import api.react.React;
import api.react.ReactComponent;
import component.basic.PreviewAnimation;
import component.complex.ComplexEasingId;
import core.RootContext;
import js.html.CanvasElement;
import tweenxcore.expr.ComplexEasingKind;

class PreviewView extends ReactComponentOfProps<PreviewProps>
{
    public function new(props:PreviewProps) 
    {
        super(props);
    }    
    
    public override function componentDidMount():Void 
    {
        PreviewAnimation.init(this.refs.canvas);
    }
    
    override public function render():ReactComponent
    {
        return React.createElement(
            "div",
            { 
                className: "preview" 
            },
            React.createElement(
                "div",
                { },
                React.createElement(
                    "button",
                    {
                        onClick: onClick,
                        className: "btn btn-default btn-lg",
                    },
                    React.createElement(
                        "span",
                        { className: "glyphicon glyphicon-play" }
                    )
                )
            ),
            React.createElement(
                "div",
                { },
                "canvas".createElement(
                    { 
                        id: "preview-canvas-" + props.id.toString(), 
                        ref: "canvas", 
                        width: PreviewAnimation.WIDTH, 
                        height: PreviewAnimation.HEIGHT 
                    }
                )
            )
        );
    }
    
    private function onClick():Void
    {
        props.context.animation.startPreview(props.id, this.props.easing);
    }
}


typedef PreviewProps =
{
    easing: ComplexEasingKind,
    id: ComplexEasingId,
    context: RootContext
}
