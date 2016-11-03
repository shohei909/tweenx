package core.focus;
import component.basic.NumberInput.NumberInputId;
import component.basic.RateId;
import component.basic.NumberInputFocus;
import component.complex.ComplexEasingSelectFocus;
import component.complex.ComplexEasingId;
import core.RootContext;
import haxe.ds.Option;
import js.Browser;

class FocusManager 
{
	public var state(default, null):FocusState;
	public var context(default, null):RootContext;
	
	public function new(context:RootContext) 
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
	
	public function focusNumberInput(id:NumberInputId, text:String):Void
	{
		state = FocusState.NumberInput(new NumberInputFocus(this, id, text));
		context.update();
	}
}
