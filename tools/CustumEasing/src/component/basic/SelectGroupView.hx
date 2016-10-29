package component.basic;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import haxe.EnumTools;
import haxe.ds.Option;
import tweenxcore.expr.InOutKind;

class SelectGroupView<DataKind:EnumValue> extends ReactComponentOfProps<SelectBarProps<DataKind>>
{
	public function new(props) 
	{
		super(props);
	}
	
	public override function render():ReactComponent 
	{
		return "div".createElement(
			{ 
				className: "row btn-group" 
			},
			[
				for (inOut in props.data)
				{
					var selected = props.current.equals(Option.Some(inOut));
					"button".createElement(
						{ 
							className: "btn btn-sm btn-" + if (selected) "primary" else "default",
							href: "javascript:void(0)",
							onClick: if (selected) null else props.onSelect.bind(inOut),
						},
						[
							if (selected) 
							{
								React.createElement(
									"span",
									{ className: "glyphicon glyphicon-ok" }
								);
							} else null,
							" " + props.getName(inOut)
						]
					);
				}
			]
		);
	}
}

typedef SelectBarProps<DataKind:EnumValue> = 
{
	current: Option<DataKind>,
	data: Array<DataKind>,
	onSelect: DataKind->Void,
	getName: DataKind->String,
}
