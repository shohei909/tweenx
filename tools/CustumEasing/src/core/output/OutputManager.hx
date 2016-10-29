package core.output;
import core.ApplyResult;
import tweenxcore.expr.ComplexEasingKind;

class OutputManager 
{
	public var easing(default, null):ComplexEasingKind;
	public var mode(default, null):OutputMode;
	private var context:GlobalContext;
	
	public function new(context:GlobalContext) 
	{
		this.context = context;
		this.mode = OutputMode.Json;
	}
	
	public function getString():String
	{
		return "todo";
	}
	
	public function changeMode(newMode:OutputMode, result:ApplyResult):Void
	{
		// result.addUndoCommand(GlobalCommand.ChangeOutputMode(mode));
		mode = newMode;
	}
}
