package component.unary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.RateInputView;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import tweenxcore.expr.ComplexEasingKind;


class LerpComponent extends ReactComponentOfProps<LerpProps>
{
	public function new(props:LerpProps) 
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
					name: "from",
					value: props.from,
					id: props.id.rateId(0),
					context: props.context
				}
			),
			RateInputView.createElement(
				{
					name: "to",
					value: props.to,
					id: props.id.rateId(1),
					context: props.context
				}
			)
		);
	}
}

typedef LerpProps =
{
	easing: ComplexEasingKind,
	from: Float,
	to: Float,
	id: ComplexEasingId,
	context: GlobalContext
}
