package core.focus;
import component.basic.RateId;
import component.basic.NumberInputFocus;
import component.complex.ComplexEasingSelectFocus;
import component.complex.ComplexEasingId;
import core.GlobalContext;
import haxe.ds.Option;
import js.Browser;

class FocusManager 
{
	public var state(default, null):FocusState;
	public var context(default, null):GlobalContext;
	
	public function new(context:GlobalContext) 
	{
		this.state = FocusState.None;
		this.context = context;
	}
	
	public function unfocus():Void
	{
		state = FocusState.None;
		context.update();
	}
	
	// ==================================================================
	// Focus
	// ==================================================================
	public function focusComplexEasingSelect(id:ComplexEasingId):Void
	{
		state = FocusState.ComplexEasingSelect(new ComplexEasingSelectFocus(this, id));
		context.update();
	}
	
	public function focusRateInput(id:RateId, text:String):Void
	{
		state = FocusState.RateInput(new NumberInputFocus(this, id, text));
		context.update();
	}
}
