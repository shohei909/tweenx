package component.simple;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.RateInputView;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import tweenxcore.geom.Point;

class BezierComponent extends ReactComponentOfProps<BezierProps>
{
	public function new(props:BezierProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent
	{
		return React.createElement(
			"div",
			{}, 
			[
				for (i in 0...props.controls.length)
				{
					RateInputView.createElement(
						{
							name: Std.string(i),
							value: props.controls[i],
							id: props.id.rateId(i),
							context: props.context
						}
					);
				}
			]
		);
	}
}

typedef BezierProps = 
{
	controls: Array<Float>,
	id: ComplexEasingId,
	context: GlobalContext
}
