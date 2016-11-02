package component.menu;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.NumberInputView;
import core.GlobalContext;
import core.history.HistoryManager;
import core.localize.ResourceKey;

class HistoryView extends ReactComponentOfProps<HistoryProps>
{
	public function new(props:HistoryProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent
	{
		var history:HistoryManager = props.context.history;
		
		return React.createElement(
			"div",
			{
				className: "history btn-group"
			}, 
			button(
				history.canUndo(),
				history.undo,
				"chevron-left",
				props.context.localize.resource.common(ResourceKey.Undo),
				"Ctrl-Z"
			),
			button(
				history.canRedo(),
				history.redo,
				"chevron-right",
				props.context.localize.resource.common(ResourceKey.Redo),
				"Ctrl-Y"
			)
		);
	}
	
	private function button(enabled:Bool, onClick:Void->Void, icon:String, label:String, key:String):ReactComponent
	{
		return "button".createElement(
			{
				onClick: onClick,
				className: "btn btn-" + if (enabled) "primary" else "default",
				disabled: !enabled,
			},
			[
				"span".createElement(
					{ className: "glyphicon glyphicon-" + icon }
				),
				' $label ($key)'
			]
		);
	}
}

typedef HistoryProps = 
{
	context: GlobalContext,
}
