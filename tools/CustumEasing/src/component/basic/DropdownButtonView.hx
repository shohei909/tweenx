package component.basic;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;

class DropdownButtonView extends ReactComponentOfProps<DropdownButtonProps>
{
    public function new(props:DropdownButtonProps) 
    {
        super(props);
    }
    
    override public function render():ReactComponent
    {
        return React.createElement(
            "div",
            {
                className: "dropdown",
            },
            React.createElement(
                "button",
                {
                    onClick: props.onClick,
                    className: "btn btn-primary dropdown-toggle",
                },
                props.name + " ",
                React.createElement(
                    "span",
                    { className: "caret" }
                )
            )
        );
    }
}

typedef DropdownButtonProps = 
{
    name: String,
    onClick: Void->Void,
}
