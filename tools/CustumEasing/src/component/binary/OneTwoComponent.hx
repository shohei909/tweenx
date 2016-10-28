package component.binary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.RateInputView;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import tweenxcore.expr.ComplexEasingKind;

class OneTwoComponent extends ReactComponentOfProps<OneTwoProps>
{
	public function new(props:OneTwoProps) 
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
			)
		);
	}
}

typedef OneTwoProps =
{
	easing1: ComplexEasingKind,
	easing2: ComplexEasingKind,
	switchTime: Float,
	id: ComplexEasingId,
	context: GlobalContext
}
