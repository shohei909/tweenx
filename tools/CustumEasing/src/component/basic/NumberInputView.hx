package component.basic;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import core.RootContext;
import core.drag.DragStateKind;
import core.focus.FocusState;
import haxe.ds.Option;

class NumberInputView extends ReactComponentOfProps<NumberInputProps>
{
    public function new(props:NumberInputProps) 
    {
        super(props);
    }
    
    public override function componentDidUpdate(prevProps:NumberInputProps, prevState:Dynamic):Void 
    {
        switch (props.context.focus.state)
        {
            case FocusState.NumberInput(detail) if (detail.id.equals(props.id)):
                
            case _:
                refs.textField.blur();
        }
    }
    
    override public function render():ReactComponent
    {
        var focus = props.context.focus;
        return "div".createElement(
            {
                className: "number-input",
            },
            [
                "div".createElement(
                    {
                        className: "form-group form-group-sm"
                    },
                    "div".createElement(
                        {
                            className: "input-group",
                        },
                        [
                            "span".createElement(
                                {
                                    className: "input-group-addon"
                                },
                                props.name + ":" 
                            ),
                            switch [props.context.drag.stateKind, focus.state]
                            {
                                case [Option.Some(DragStateKind.NumberSlider(detail)), _] if (detail.id.equals(props.id)):
                                    "input".createElement(
                                        {
                                            ref: "textField",
                                            className: "form-control",
                                            type: "text",
                                            value: detail.getCurrentValue(),
                                            onFocus: focus.focusNumberInput.bind(props.id, Std.string(props.value)),
                                        }
                                    );
                                    
                                case [_, FocusState.NumberInput(detail)]  if (detail.id.equals(props.id)):
                                    "input".createElement(
                                        {
                                            ref: "textField",
                                            className: "form-control",
                                            type: "text",
                                            value: detail.text,
                                            onChange: detail.change,
                                            onSubmit: detail.submit,
                                        }
                                    );
                                    
                                case _:
                                    "input".createElement(
                                        {
                                            ref: "textField",
                                            className: "form-control",
                                            type: "text",
                                            value: Std.string(props.value),
                                            onFocus: focus.focusNumberInput.bind(props.id, Std.string(props.value)),
                                        }
                                    );
                            }
                        ]
                    )
                ),
                NumberSliderView.createElement(props)
            ]
        );
    }
}

typedef NumberInputProps = 
{
    name: String,
    value: Float,
    id: NumberInputId,
    context: RootContext,
}
