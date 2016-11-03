package component.binary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.binary.MultiplyView;
import component.complex.ComplexEasingView;
import component.ternaryOp.TernaryOpView;
import component.complex.ComplexEasingId;
import core.RootContext;
import tweenxcore.expr.BinaryOpKind;
import tweenxcore.expr.ComplexEasingKind;

class BinaryOpView extends ReactComponentOfProps<BinaryOpProps>
{
	public function new(props:BinaryOpProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent 
	{
		return  React.createElement(
			"div",
			{
				
			},
			ComplexEasingView.createElement(
				{
					easing: props.easing2, 
					id: props.id.concat(1),
					context: props.context,
				}
			),
			switch (props.op)
			{
				case BinaryOpKind.Composite:
					CompositeView.createElement(
						{
							easing1: props.easing1,
							easing2: props.easing2,
						}
					);
					
				case BinaryOpKind.Multiply:
					MultiplyView.createElement(
						{
							easing1: props.easing1,
							easing2: props.easing2,
						}
					);
					
				case BinaryOpKind.Mix(strength):
					MixView.createElement(
						{
							easing1: props.easing1,
							easing2: props.easing2,
							strength: strength,
							id: props.id,
							context: props.context,
						}
					);
					
				case BinaryOpKind.Connect(switchTime, switchValue):
					ConnectView.createElement(
						{
							easing1: props.easing1,
							easing2: props.easing2,
							switchTime: switchTime,
							switchValue: switchValue,
							id: props.id,
							context: props.context,
						}
					);
					
				case BinaryOpKind.OneTwo(switchTime):
					OneTwoView.createElement(
						{
							easing1: props.easing1,
							easing2: props.easing2,
							switchTime: switchTime,
							id: props.id,
							context: props.context,
						}
					);
					
					
				case BinaryOpKind.Op(easing3, op):
					TernaryOpView.createElement(
						{
							easing1: props.easing1,
							easing2: props.easing2,
							easing3: easing3,
							op: op,
							id: props.id,
							context: props.context,
						}
					);
			}
		);
	}
}

typedef BinaryOpProps =
{
	easing1: ComplexEasingKind,
	easing2: ComplexEasingKind,
	op: BinaryOpKind,
	id: ComplexEasingId,
	context: RootContext
}
