package core;

class ApplyResult 
{
	public var undoCommands(default, null):List<GlobalCommand>;
	
	public function new() 
	{
		undoCommands = new List();
	}
	
	public function addUndoCommand(command:GlobalCommand) :Void
	{
		undoCommands.push(command);
	}	
}