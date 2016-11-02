package component.binary;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.NumberInputView;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import core.localize.ResourceKey;
import tweenxcore.expr.ComplexEasingKind;

class ConnectView extends ReactComponentOfProps<ConnectProps>
{
	public function new(props:ConnectProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent 
	{
		return "div".createElement(
			{
				className: "param-group"
			}, 
			[
				NumberInputView.createElement(
					{
						name: props.context.localize.resource.common(ResourceKey.SwitchTime),
						value: props.switchTime,
						id: props.id.numberInputId(0),
						context: props.context
					}
				),
				NumberInputView.createElement(
					{
						name: props.context.localize.resource.common(ResourceKey.SwitchValue),
						value: props.switchValue,
						id: props.id.numberInputId(1),
						context: props.context
					}
				)
			]
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
