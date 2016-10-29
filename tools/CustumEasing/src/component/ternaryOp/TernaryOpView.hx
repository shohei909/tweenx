package component.ternaryOp;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.NumberInputView;
import component.complex.ComplexEasingView;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.TernaryOpKind;

class TernaryOpView extends ReactComponentOfProps<TernaryOpProps>
{
	public function new(props:TernaryOpProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent 
	{
		return React.createElement(
			"div",
			{
				
			},
			ComplexEasingView.createElement(
				{
					easing: props.easing3, 
					id: props.id.concat(2),
					context: props.context,
				}
			),
			switch (props.op)
			{
				case TernaryOpKind.Crossfade(min, max):
					React.createElement(
						"div",
						{
							className: "param-group"
						}, 
						NumberInputView.createElement(
							{
								name: "Min",
								value: min,
								id: props.id.rateId(0),
								context: props.context
							}
						),
						NumberInputView.createElement(
							{
								name: "Max",
								value: max,
								id: props.id.rateId(1),
								context: props.context
							}
						)
					);
			}
		);
	}
}

typedef TernaryOpProps =
{
	easing1: ComplexEasingKind,
	easing2: ComplexEasingKind,
	easing3: ComplexEasingKind,
	op: TernaryOpKind,
	id: ComplexEasingId,
	context: GlobalContext
}
