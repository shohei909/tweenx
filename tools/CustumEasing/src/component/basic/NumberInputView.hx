package component.basic;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import core.GlobalContext;
import core.focus.FocusState;
import haxe.ds.Option;

class NumberInputView extends ReactComponentOfProps<RateInputProps>
{
	public function new(props:RateInputProps) 
	{
		super(props);
	}
	
	public override function componentDidUpdate(prevProps:RateInputProps, prevState:Dynamic):Void 
	{
		switch (props.context.focus.state)
		{
			case FocusState.RateInput(detail) if (detail.id == props.id):
				
			case _:
				refs.textField.blur();
		}
	}
	
	override public function render():ReactComponent
	{
		var focus = props.context.focus;
		return "div".createElement(
			{
				className: "form-group form-group-sm",
			},
			"div".createElement(
				{
					className: "input-group",
				},
				[
					"span".createElement(
						{
							className: "input-group-addon"
						},
						props.name + ":" 
					),
					switch (focus.state)
					{
						case FocusState.RateInput(detail) if (detail.id == props.id):
							"input".createElement(
								{
									ref: "textField",
									className: "form-control",
									type: "text",
									value: detail.text,
									onChange: detail.change,
									onSubmit: detail.submit,
								}
							);
							
						case _:
							"input".createElement(
								{
									ref: "textField",
									className: "form-control",
									type: "text",
									value: Std.string(props.value),
									onFocus: focus.focusRateInput.bind(props.id, Std.string(props.value)),
								}
							);
					}
				]
			)
		);
	}
}
typedef RateInputProps = 
{
	name: String,
	value: Float,
	id: RateId,
	context: GlobalContext,
}
