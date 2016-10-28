package component.complex;
import haxe.ds.Option;
import component.complex.ComplexEasingId;
import core.focus.FocusManager;

class ComplexEasingSelectFocus 
{
	private var focus:FocusManager;
	public var id(default, null):ComplexEasingId;
	
	public function new (focus:FocusManager, id:ComplexEasingId)
	{
		this.focus = focus;
		this.id = id;
	}
	
	public function select(item:ComplexEasingSelectItem):Void
	{
		switch (focus.context.resolveEasing(id))
		{
			case Option.Some(oldEasing):
				var newEasing = item.createEasing(new ComplexEasingCreateContext(oldEasing));
				focus.unfocus();
				focus.context.updateEasing(id, newEasing);
				
			case Option.None:
				focus.unfocus();
		}
	}
}
