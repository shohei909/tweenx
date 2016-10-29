package component.simple;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.DropdownButtonView;
import component.basic.SelectGroupView;
import component.complex.ComplexEasingSelectItem;
import core.GlobalCommand;
import haxe.EnumTools;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import core.focus.FocusState;
import haxe.ds.Option;
import tweenxcore.expr.InOutKind;
import tweenxcore.expr.StandardEasingKind;
class StandardEasingView extends ReactComponentOfProps<StandardEasingProps>
{
	public function new(props:StandardEasingProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent 
	{
		return InOutView.createElement(
			{
				current: Option.Some(props.inOut),
				data: [for(c in EnumTools.getConstructors(InOutKind)) EnumTools.createByName(InOutKind, c)],
				onSelect: onSelect,
				getName: getName,
			}
		);
	}

	private function onSelect(inOut:InOutKind):Void
	{
		props.context.apply(GlobalCommand.ChangeInOut(props.id, inOut));
	}
	
	private static function getName(inOut:InOutKind):String
	{
		return EnumValueTools.getName(inOut);
	}
}

typedef StandardEasingProps =
{
	easing: StandardEasingKind,
	inOut: InOutKind,
	id: ComplexEasingId,
	context: GlobalContext
}

private typedef InOutView = SelectGroupView<InOutKind>;