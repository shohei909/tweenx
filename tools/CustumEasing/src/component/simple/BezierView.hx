package component.simple;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.NumberInputView;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import tweenxcore.geom.Point;

class BezierView extends ReactComponentOfProps<BezierProps>
{
	public function new(props:BezierProps) 
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
			[
				for (i in 0...props.controls.length)
				{
					NumberInputView.createElement(
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
