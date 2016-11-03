package component.menu;
import api.react.ReactComponent;
import component.basic.SelectGroupView;
import core.RootCommand;
import core.RootContext;
import core.localize.LocaleKind;
import haxe.EnumTools;
import haxe.ds.Option;

class LocaleView extends ReactComponentOfProps<LocaleProps>
{
	public function new(props:LocaleProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent 
	{
		var localize = props.context.localize;
		return SelectGroupView.createElement(
			{
				current: Option.Some(localize.locale),
				data: [for(c in EnumTools.getConstructors(LocaleKind)) EnumTools.createByName(LocaleKind, c)],
				onSelect: onSelect,
				getName: localize.getLocaleName,
				getIcon: getIcon,
			}
		);
	}
	
	private function onSelect(locale:LocaleKind):Void
	{
		props.context.apply(RootCommand.ChangeLocale(locale), true);
	}
	
	private static function getIcon(mode:LocaleKind):Option<String>
	{
		return Option.None;
	}
	
}

typedef LocaleProps =
{
	context: RootContext,
}
