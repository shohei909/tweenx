package component.complex;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.DropdownButtonView;
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
					name: ComplexEasingSelectItem.getItem(currentItemId).name,
				}
			);
		}
		
		var focus = props.context.focus;
		return switch (focus.state)
		{
			case FocusState.ComplexEasingSelect(detail) if (detail.id == props.id):
				React.createElement(
					"div", 
					{ className: "select" },
					button(focus.unfocus),
					React.createElement(
						"div",
						{ className: "btn-group" },
						[
							for (item in ComplexEasingSelectItem.items)
							{
								React.createElement(
									"button",
									{ 
										className: "btn btn-default pull-left",
										href: "javascript:void(0)",
										onClick: detail.select.bind(item),
									},
									item.name
								);
							}
						]
					)
				);

			case _:
				React.createElement(
					"div", 
					{ 
						className: "complex_easing_select"
					},
					button(focus.focusComplexEasingSelect.bind(props.id))
				);
		}
	}
}

typedef DropdownProps =
{
	easing: ComplexEasingKind,
	id: ComplexEasingId,
	context: GlobalContext
}
