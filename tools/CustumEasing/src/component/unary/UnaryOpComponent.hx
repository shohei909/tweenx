package component.unary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.binary.BinaryOpComponent;
import component.complex.ComplexEasingId;
import component.complex.ComplexEasingView;
import component.unary.ClampComponent;
import core.GlobalContext;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.UnaryOpKind;

class UnaryOpComponent extends ReactComponentOfProps<UnaryOpProps>
{
	public function new(props:UnaryOpProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent 
	{
		return React.createElement(
			"div",
			{},
			ComplexEasingView.createElement(
				{
					easing: props.easing, 
					id: props.id.concat(0),
					context: props.context,
				}
			),
			switch (props.op)
			{
				case UnaryOpKind.Lerp(from, to):
					LerpComponent.createElement(
						{
							easing: props.easing,
							from: from,
							to: to,
							id: props.id,
							context: props.context,
						}
					);
					
				case UnaryOpKind.Clamp(min, max):
					ClampComponent.createElement(
						{
							easing: props.easing,
							min: min,
							max: max,
							id: props.id,
							context: props.context,
						}
					);
					
				case UnaryOpKind.Repeat(repeat):
					RepeatComponent.createElement(
						{
							easing: props.easing,
							repeat: repeat,
							id: props.id,
							context: props.context,
						}
					);
					
				case UnaryOpKind.RoundTrip(roundTrip):
					RoundTripComponent.createElement(
						{
							easing: props.easing,
							roundTrip: roundTrip,
						}
					);
					
				case UnaryOpKind.Op(easing2, op):
					BinaryOpComponent.createElement(
						{
							easing1: props.easing,
							easing2: easing2,
							op: op,
							id: props.id,
							context: props.context,
						}
					);
			}
		);
	}
	
}

typedef UnaryOpProps =
{
	easing: ComplexEasingKind,
	op: UnaryOpKind,
	id: ComplexEasingId,
	context: GlobalContext
}
