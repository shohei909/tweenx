package component.unary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.RateInputView;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import tweenxcore.expr.ComplexEasingKind;


class ClampComponent extends ReactComponentOfProps<ClampProps>
{
	public function new(props:ClampProps) 
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
					name: "min",
					value: props.min,
					id: props.id.rateId(0),
					context: props.context
				}
			),
			RateInputView.createElement(
				{
					name: "max",
					value: props.max,
					id: props.id.rateId(1),
					context: props.context
				}
			)
		);
	}
}

typedef ClampProps =
{
	easing: ComplexEasingKind,
	min: Float,
	max: Float,
	id: ComplexEasingId,
	context: GlobalContext
}
