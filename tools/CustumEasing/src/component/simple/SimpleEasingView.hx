package component.simple;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import tweenxcore.expr.SimpleEasingKind;

class SimpleEasingView extends ReactComponentOfProps<SimpleEasingProps>
{
	public function new(props:SimpleEasingProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent
	{
		return switch (props.kind)
		{
			case SimpleEasingKind.Linear:
				React.createElement("div", {}, []);
				
			case SimpleEasingKind.Standard(easing, inOut):
				StandardEasingView.createElement(
					{
						easing: easing,
						inOut: inOut,
						id: props.id,
						context: props.context,
					}
				);
				
			case SimpleEasingKind.Bezier(controls):
				BezierView.createElement(
					{
						controls: controls,
						id: props.id,
						context: props.context,
					}
				);
		}
	}
}

typedef SimpleEasingProps = 
{
	kind: SimpleEasingKind,
	id: ComplexEasingId,
	context: GlobalContext
}
