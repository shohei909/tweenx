package component.unary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.RateInputView;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import tweenxcore.expr.ComplexEasingKind;


class RepeatComponent extends ReactComponentOfProps<RepeatProps>
{
	public function new(props:RepeatProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent 
	{
		return React.createElement(
			"div",
			{}, 
			RateInputView.createElement(
				{
					name: "Repeat",
					value: props.repeat,
					id: props.id.rateId(0),
					context: props.context
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
	context: GlobalContext
}
