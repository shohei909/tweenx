package;

import api.react.React;
import api.react.ReactComponent;
import api.react.ReactDOM;
import component.complex.ComplexEasingView;
import component.menu.HistoryView;
import component.output.OutputView;
import js.Browser;
import js.Lib;
import core.GlobalContext;
import component.complex.ComplexEasingId;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.SimpleEasingKind;

class Application extends ReactComponentOfProps<ApplicationProps>
{
    static public function main() 
	{
        ReactDOM.render(
			Application.createElement(
				{
					context: new GlobalContext(),
				}
			), 
			Browser.document.getElementById('application')
		);
    }

    public function new(props:ComplexEasingProps) 
	{
        super(props);
		props.context.setup(this);
    }

    override function render():ReactComponent
	{
        return "div".createElement(
			{},
			[
				HistoryView.createElement(
					{
						history: props.context.history
					}
				),
				ComplexEasingView.createElement(
				{
					easing: props.context.easing.current,
					id: ComplexEasingId.root(),
					context: props.context
				}
				),
				OutputView.createElement(
					{
						context: props.context,
					}
				)
			]
		);
    }
}

typedef ApplicationProps =
{
	context: GlobalContext,
}
