package component.basic;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import core.GlobalContext;
import core.focus.FocusState;
import haxe.ds.Option;

class RateInputView extends ReactComponentOfProps<RateInputProps>
{
	public function new(props:RateInputProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent
	{
		var focus = props.context.focus;
		return React.createElement(
			"div",
			{},
			props.name + ": ",
			switch (focus.state)
			{
				case FocusState.RateInput(detail) if (detail.id == props.id):
					React.createElement(
						"input",
						{
							type: "text",
							value: detail.text,
							onChange: detail.change,
							onSubmit: detail.submit,
						}
					);
					
				case _:
					React.createElement(
						"input",
						{
							type: "text",
							value: Std.string(props.value),
							onFocus: focus.focusRateInput.bind(props.id, Std.string(props.value)),
						}
					);
			}
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
