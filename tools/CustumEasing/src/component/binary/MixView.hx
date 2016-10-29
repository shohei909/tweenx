package component.binary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.NumberInputView;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import tweenxcore.expr.ComplexEasingKind;

class MixView extends ReactComponentOfProps<MixProps>
{
	public function new(props:MixProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent 
	{
		return React.createElement(
			"div",
			{
				className: "param-group"
			}, 
			NumberInputView.createElement(
				{
					name: "Strength",
					value: props.strength,
					id: props.id.rateId(0),
					context: props.context
				}
			)
		);
	}
}

typedef MixProps =
{
	easing1: ComplexEasingKind,
	easing2: ComplexEasingKind,
	strength: Float,
	id: ComplexEasingId,
	context: GlobalContext
}
