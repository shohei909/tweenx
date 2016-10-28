package;

import api.react.React;
import api.react.ReactComponent;
import api.react.ReactDOM;
import component.complex.ComplexEasingView;
import js.Browser;
import js.Lib;
import core.GlobalContext;
import component.complex.ComplexEasingId;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.SimpleEasingKind;

class Application extends ReactComponentOfProps<ComplexEasingProps>
{
    static public function main() 
	{
        ReactDOM.render(
			Application.createElement(
				{
					easing: ComplexEasingKind.Simple(SimpleEasingKind.Linear),
					id: new ComplexEasingId([]),
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
        return ComplexEasingView.createElement(props);
    }
}
