package component.simple;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import tweenxcore.expr.SimpleEasingKind;

class SimpleEasingComponent extends ReactComponentOfProps<SimpleEasingProps>
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
				StandardEasingComponent.createElement(
					{
						easing: easing,
						inOut: inOut,
						id: props.id,
						context: props.context,
					}
				);
				
			case SimpleEasingKind.Bezier(controls):
				BezierComponent.createElement(
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
