package core.history;

class HistoryManager 
{
	private var undoStack:List<List<GlobalCommand>>;
	private var redoStack:List<List<GlobalCommand>>;
	private var context:GlobalContext;
	
	public function new(context:GlobalContext) 
	{
		this.context = context;
		undoStack = new List();
		redoStack = new List();
	}	
	
	public function canUndo():Bool
	{
		return !undoStack.isEmpty();
	}
	public function undo():Void
	{
		context.focus.unfocus();
		if (!canUndo()) return;
		
		var result = context.applyWithoutRecord(undoStack.pop());
		redoStack.push(result.undoCommands);
		context.update();
	}
	
	public function canRedo():Bool
	{
		return !redoStack.isEmpty();
	}
	
	public function redo():Void
	{
		context.focus.unfocus();
		if (!canRedo()) return;
		
		var result = context.applyWithoutRecord(redoStack.pop());
		undoStack.push(result.undoCommands);
		context.update();
	}
	
	public function record(commands:List<GlobalCommand>):Void
	{
		undoStack.push(commands);
		redoStack.clear();
	}
}
