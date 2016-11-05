package component.unary;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.RoundTripKind;

class RoundTripView extends ReactComponentOfProps<RoundTripProps>
{
    public function new(props:RoundTripProps) 
    {
        super(props);
    }
    
    override public function render():ReactComponent 
    {
        return null;
    }
}

typedef RoundTripProps =
{
    easing: ComplexEasingKind,
    roundTrip: RoundTripKind,
}
