package component.menu;
import api.react.ReactComponent;
import component.basic.NumberInput.NumberInputId;
import component.basic.NumberInputView;
import core.GlobalContext;

class MenuView extends ReactComponentOfProps<MenuProps>
{
	public function new(props:MenuProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent
	{
		return "div".createElement(
			{
				className: "menu"
			},
			[
				"div".createElement(
					{
						className: "menu-item"
					},
					HistoryView.createElement(
						{
							history: props.context.history
						}
					)
				),
				"div".createElement(
					{
						className: "menu-item"
					},
					NumberInputView.createElement(
						{
							name: "Animation Time (sec)",
							value: props.context.animation.time,
							id: NumberInputId.AnimationTime,
							context: props.context,
						}
					)
				)
			]
		);
	}
}

typedef MenuProps = 
{
	context: GlobalContext,
}
