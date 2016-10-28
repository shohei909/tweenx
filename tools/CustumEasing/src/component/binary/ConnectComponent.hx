package component.binary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.RateInputView;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import tweenxcore.expr.ComplexEasingKind;

class ConnectComponent extends ReactComponentOfProps<ConnectProps>
{
	public function new(props:ConnectProps) 
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
					name: "Switch time",
					value: props.switchTime,
					id: props.id.rateId(0),
					context: props.context
				}
			),
			RateInputView.createElement(
				{
					name: "Switch value",
					value: props.switchValue,
					id: props.id.rateId(1),
					context: props.context
				}
			)
		);
	}
}

typedef ConnectProps =
{
	easing1: ComplexEasingKind,
	easing2: ComplexEasingKind,
	switchTime: Float,
	switchValue: Float,
	id: ComplexEasingId,
	context: GlobalContext
}
