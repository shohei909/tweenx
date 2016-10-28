package component.simple;
import haxe.ds.Option;
import component.complex.ComplexEasingId;
import core.focus.FocusManager;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.InOutKind;
import tweenxcore.expr.SimpleEasingKind;

class InOutSelectFocus 
{
	private var focus:FocusManager;
	public var id(default, null):ComplexEasingId;
	
	public function new (focus:FocusManager, id:ComplexEasingId)
	{
		this.focus = focus;
		this.id = id;
	}
	
	public function select(inOut:InOutKind):Void
	{
		switch (focus.context.resolveEasing(id))
		{
			case Option.Some(ComplexEasingKind.Simple(SimpleEasingKind.Standard(easing, _))):
				focus.context.updateEasing(id, ComplexEasingKind.Simple(SimpleEasingKind.Standard(easing, inOut)));
				focus.unfocus();
				
			case _:
				focus.unfocus();
		}
	}	
}