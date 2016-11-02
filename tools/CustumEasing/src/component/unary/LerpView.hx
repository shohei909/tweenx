package component.unary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.NumberInputView;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import core.localize.ResourceKey;
import tweenxcore.expr.ComplexEasingKind;


class LerpView extends ReactComponentOfProps<LerpProps>
{
	public function new(props:LerpProps) 
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
					name: props.context.localize.resource.common(ResourceKey.From),
					value: props.from,
					id: props.id.numberInputId(0),
					context: props.context
				}
			),
			NumberInputView.createElement(
				{
					name: props.context.localize.resource.common(ResourceKey.To),
					value: props.to,
					id: props.id.numberInputId(1),
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
