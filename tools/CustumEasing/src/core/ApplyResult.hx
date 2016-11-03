package core;
import core.RootContext;

class ApplyResult 
{
	public var undoCommands(default, null):List<RootCommand>;
	public var saveRequired(default, null):Bool;
	
	public function new() 
	{
		undoCommands = new List();
		saveRequired = false;
	}
	
	public function addUndoCommand(command:RootCommand) :Void
	{
		undoCommands.push(command);
	}	
	
	public function requestSave():Void
	{
		saveRequired = true;
	}
	
}