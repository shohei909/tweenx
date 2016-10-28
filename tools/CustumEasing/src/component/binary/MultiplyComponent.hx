package component.binary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import tweenxcore.expr.ComplexEasingKind;

class MultiplyComponent extends ReactComponentOfProps<MultiplyProps>
{
	public function new(props:MultiplyProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent 
	{
		return null;
	}
}

typedef MultiplyProps =
{
	easing1: ComplexEasingKind,
	easing2: ComplexEasingKind
}
