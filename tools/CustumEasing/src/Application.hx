package;

import api.react.React;
import api.react.ReactComponent;
import api.react.ReactDOM;
import component.basic.NumberInput.NumberInputId;
import component.basic.NumberInputView;
import component.basic.RateId;
import component.complex.ComplexEasingView;
import component.menu.HistoryView;
import component.menu.MenuView;
import component.output.OutputView;
import core.localize.ResourceKey;
import js.Browser;
import js.Lib;
import core.RootContext;
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
					context: new RootContext(),
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
	
	public override function componentDidMount():Void 
	{
		props.context.init();
	}

    override function render():ReactComponent
	{
        return "div".createElement(
			{},
			[
				"h2".createElement(
					{}, 
					"a".createElement(
						{ href: "./" }, 
						props.context.localize.resource.common(ResourceKey.Title)
					)
				),
				MenuView.createElement(props),
				ComplexEasingView.createElement(
				{
					easing: props.context.easing.current,
					id: ComplexEasingId.root(),
					context: props.context
				}
				),
				OutputView.createElement(props)
			]
		);
    }
}

typedef ApplicationProps =
{
	context: RootContext,
}
