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
				className: "select-group btn-group" 
			},
			[
				for (kind in props.data)
				{
					var selected = props.current.equals(Option.Some(kind));
					"button".createElement(
						{ 
							className: "btn btn-sm btn-" + if (selected) "primary" else "default",
							href: "javascript:void(0)",
							onClick: props.onSelect.bind(kind),
						},
						[
							if (selected) 
							{
								React.createElement(
									"span",
									{ className: "glyphicon glyphicon-ok" }
								);
							} 
							else switch (props.getIcon(kind))
							{
								case Option.Some(path):
									React.createElement(
										"img",
										{ src: "../../icon/" + path }
									);
									
								case Option.None:
									null;
							},
							" " + props.getName(kind) + " ",
							
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
	getIcon: DataKind->Option<String>,
}
