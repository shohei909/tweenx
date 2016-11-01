package component.complex;
import core.GlobalCommand;
import core.easing.EasingCommand;
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
		switch (focus.context.easing.resolveEasing(id))
		{
			case Option.Some(oldEasing):
				var newEasing = item.createEasing(new ComplexEasingCreateContext(oldEasing));
				var command = GlobalCommand.ChangeEasing(id, EasingCommand.Replace(newEasing));
				focus.context.apply(command);
				
				focus.unfocus();
				
			case Option.None:
				focus.unfocus();
		}
	}
}
