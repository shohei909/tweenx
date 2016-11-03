package component.unary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.binary.BinaryOpView;
import component.complex.ComplexEasingId;
import component.complex.ComplexEasingView;
import component.unary.ClampView;
import core.RootContext;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.UnaryOpKind;

class UnaryOpView extends ReactComponentOfProps<UnaryOpProps>
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
					LerpView.createElement(
						{
							easing: props.easing,
							from: from,
							to: to,
							id: props.id,
							context: props.context,
						}
					);
					
				case UnaryOpKind.Clamp(min, max):
					ClampView.createElement(
						{
							easing: props.easing,
							min: min,
							max: max,
							id: props.id,
							context: props.context,
						}
					);
					
				case UnaryOpKind.Repeat(repeat):
					RepeatView.createElement(
						{
							easing: props.easing,
							repeat: repeat,
							id: props.id,
							context: props.context,
						}
					);
					
				case UnaryOpKind.RoundTrip(roundTrip):
					RoundTripView.createElement(
						{
							easing: props.easing,
							roundTrip: roundTrip,
						}
					);
					
				case UnaryOpKind.Op(easing2, op):
					BinaryOpView.createElement(
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
	context: RootContext
}
