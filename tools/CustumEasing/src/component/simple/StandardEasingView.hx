package component.simple;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.DropdownButtonView;
import component.basic.SelectGroupView;
import component.complex.ComplexEasingSelectItem;
import core.RootCommand;
import core.easing.EasingCommand;
import haxe.EnumTools;
import component.complex.ComplexEasingId;
import core.RootContext;
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
				getName: props.context.localize.resource.inOut,
				getIcon: getIcon,
			}
		);
	}

	private function onSelect(inOut:InOutKind):Void
	{
		props.context.apply(RootCommand.ChangeEasing(props.id, EasingCommand.InOut(inOut)));
	}
	
	private static function getIcon(inOut:InOutKind):Option<String>
	{
		return Option.Some(EnumValueTools.getName(inOut) + ".png");
	}
}

typedef StandardEasingProps =
{
	easing: StandardEasingKind,
	inOut: InOutKind,
	id: ComplexEasingId,
	context: RootContext
}

private typedef InOutView = SelectGroupView<InOutKind>;