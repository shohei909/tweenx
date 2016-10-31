package component.complex;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.DropdownButtonView;
import component.basic.SelectGroupView;
import core.GlobalCommand;
import haxe.EnumTools.EnumValueTools;
import haxe.ds.Option;
import js.html.CanvasElement;
import core.GlobalContext;
import component.complex.ComplexEasingId;
import core.focus.FocusState;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ComplexEasingKindTools;

class ComplexEasingSelectView extends ReactComponentOfProps<DropdownProps>
{
	public function new(props:DropdownProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent
	{
		var currentItemId = ComplexEasingSelectItem.resolveItemId(props.easing);
		
		inline function button(onClick:Void->Void):ReactComponent
		{
			return DropdownButtonView.createElement(
				{
					onClick: onClick,
					name: getName(currentItemId),
				}
			);
		}
		
		var focus = props.context.focus;
		var optionCurrent = Option.Some(currentItemId);
		return React.createElement(
			"div", 
			{ className: "complex-easing-select" },
			switch (focus.state)
			{
				case FocusState.ComplexEasingSelect(detail) if (detail.id == props.id):
					var select = onSelect.bind(detail);
					[
						button(focus.unfocus),
						"div".createElement(
							{ className: "dropdown-content" },
							[
								for (itemGroup in ComplexEasingSelectItem.itemIds)
								{
									"div".createElement(
										{ className: "dropdown-content-row" },
										ItemListView.createElement(
											{
												current: optionCurrent,
												data: itemGroup,
												onSelect: select,
												getName: getName,
												getIcon: getIcon,
											}
										)
									);
								}
							]
						)
					];

				case _:
					button(focus.focusComplexEasingSelect.bind(props.id));
			}
		);
	}
	
	private static function getName(itemId:ComplexEasingSelectItemId):String
	{
		return EnumValueTools.getName(itemId);
	}
	
	private static function getIcon(itemId:ComplexEasingSelectItemId):Option<String>
	{
		return Option.Some(EnumValueTools.getName(itemId) + ".png");
	}
	
	private function onSelect(detail:ComplexEasingSelectFocus, itemId:ComplexEasingSelectItemId):Void
	{
		detail.select(ComplexEasingSelectItem.createItem(itemId));
	}
}

typedef DropdownProps =
{
	easing: ComplexEasingKind,
	id: ComplexEasingId,
	context: GlobalContext
}

private typedef ItemListView = SelectGroupView<ComplexEasingSelectItemId>;