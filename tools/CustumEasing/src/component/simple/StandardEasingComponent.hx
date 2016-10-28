package component.simple;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.DropdownButtonView;
import component.complex.ComplexEasingSelectItem;
import haxe.EnumTools;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import core.focus.FocusState;
import tweenxcore.expr.InOutKind;
import tweenxcore.expr.StandardEasingKind;

class StandardEasingComponent extends ReactComponentOfProps<StandardEasingProps>
{
	public function new(props:StandardEasingProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent 
	{
		inline function button(onClick:Void->Void):ReactComponent
		{
			return DropdownButtonView.createElement(
				{
					onClick: onClick,
					name: getName(props.inOut),
				}
			);
		}
		
		var focus = props.context.focus;
		return switch (focus.state)
		{
			case FocusState.InOutSelect(detail) if (detail.id == props.id):
				React.createElement(
					"div", 
					{ className: "select" },
					button(focus.unfocus),
					React.createElement(
						"div",
						{ className: "btn-group" },
						[
							for (constructor in EnumTools.getConstructors(InOutKind))
							{
								var inOut = EnumTools.createByName(InOutKind, constructor);
								React.createElement(
									"button",
									{ 
										className: "btn btn-default pull-left",
										href: "javascript:void(0)",
										onClick: detail.select.bind(inOut),
									},
									getName(inOut)
								);
							}
						]
					)
				);

			case _:
				React.createElement(
					"div", 
					{ 
						className: "select"
					},
					button(focus.focusInOutSelect.bind(props.id))
				);
		}
	}
	
	public static function getName(inOut:InOutKind):String
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
