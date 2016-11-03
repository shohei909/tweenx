package core;
import tweenxcore.expr.ComplexEasingKind;
import component.complex.ComplexEasingId;
import core.RootContext;
using component.complex.ComplexEasingId;

class ApplyResult 
{
	public var undoCommands(default, null):List<RootCommand>;
	public var saveRequested(default, null):Bool;
	public var updateHashRequested(default, null):Bool;
	public var major(default, null):Bool;
	public var previews(default, null):Map<String, ComplexEasingKind>;
	
	public function new(major:Bool) 
	{
		this.major = major;
		undoCommands = new List();
		saveRequested = false;
		updateHashRequested = true;
		previews = new Map();
	}
	
	public function addUndoCommand(command:RootCommand) :Void
	{
		if (undoCommands.last != null)
		{
			switch [undoCommands.last(), command]
			{
				case [RootCommand.ChangeAnimationTime(_), RootCommand.ChangeAnimationTime(_)]:
					return;
					
				case [RootCommand.ChangeEasing(id1, _), RootCommand.ChangeEasing(id2, _)] if (id1.equals(id2)):
					return;
				
				case _:
			}
		}
		undoCommands.push(command);
	}	
	
	public function requestSave():Void
	{
		saveRequested = true;
	}
	
	public function requestPreview(id:ComplexEasingId, easing:ComplexEasingKind):Void
	{
		previews[id.toString()] = easing;
	}
	
	public function requestUpdateHash() 
	{
		updateHashRequested = true;
	}
	
	public function merge(nextResult:ApplyResult):Void 
	{
		for (command in nextResult.undoCommands)
		{
			addUndoCommand(command);
		}
		for (id in previews.keys())
		{
			requestPreview(ComplexEasingId.fromString(id), previews[id]);
		}
		
		saveRequested = saveRequested || nextResult.saveRequested;
		updateHashRequested = updateHashRequested || nextResult.updateHashRequested;
		major = major || nextResult.major;
	}
}
