package component.menu;
import api.react.ReactComponent;
import component.basic.NumberInputId;
import component.basic.NumberInputView;
import component.basic.SelectGroupView;
import core.RootContext;
import core.localize.ResourceKey;

class MenuView extends ReactComponentOfProps<MenuProps>
{
    public function new(props:MenuProps) 
    {
        super(props);
    }
    
    override public function render():ReactComponent
    {
        return "div".createElement(
            {
                className: "menu"
            },
            [
                "div".createElement(
                    {
                        className: "menu-item"
                    },
                    HistoryView.createElement(
                        {
                            context: props.context
                        }
                    )
                ),
                "div".createElement(
                    {
                        className: "menu-item"
                    },
                    NumberInputView.createElement(
                        {
                            name: props.context.localize.resource.common(ResourceKey.AnimationTime),
                            value: props.context.animation.time,
                            id: NumberInputId.AnimationTime,
                            context: props.context,
                        }
                    )
                ),
                "div".createElement(
                    {
                        className: "menu-item"
                    },
                    LocaleView.createElement(props)
                )
            ]
        );
    }
}

typedef MenuProps = 
{
    context: RootContext,
}
