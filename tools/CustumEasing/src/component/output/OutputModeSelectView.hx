package component.output;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.SelectGroupView;
import component.output.OutputModeSelectView;
import core.GlobalCommand;
import core.GlobalContext;
import core.output.OutputManager;
import core.output.OutputMode;
import haxe.EnumTools;
import haxe.ds.Option;
import tweenxcore.expr.ComplexEasingKind;

class OutputModeSelectView extends ReactComponentOfProps<OutputModeSelectProps>
{
	public function new(props:OutputModeSelectProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent 
	{
		return "div".createElement(
			{ className: "output-mode-select" },
			OutputModeView.createElement(
				{
					{
						current: Option.Some(props.mode),
						data: [for(c in EnumTools.getConstructors(OutputMode)) EnumTools.createByName(OutputMode, c)],
						onSelect: onSelect,
						getName: getName,
					}
				}
			)
		);
	}
	
	private function onSelect(mode:OutputMode):Void
	{
		props.context.apply(GlobalCommand.ChangeOutputMode(mode));
	}
	
	private static function getName(mode:OutputMode):String
	{
		return EnumValueTools.getName(mode);
	}
}

typedef OutputModeSelectProps =
{
	context: GlobalContext,
	mode: OutputMode,
}

private typedef OutputModeView = SelectGroupView<OutputMode>;
