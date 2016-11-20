package core.history;

class HistoryManager 
{
    private var undoStack:List<List<RootCommand>>;
    private var redoStack:List<List<RootCommand>>;
    private var context:RootContext;
    
    public function new(context:RootContext) 
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
        
        var result = context.applyWithoutRecord(undoStack.pop(), true);
        redoStack.push(result.undoCommands);
        context.applyResult(result, true);
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
        
        var result = context.applyWithoutRecord(redoStack.pop(), true);
        undoStack.push(result.undoCommands);
        context.applyResult(result, true);
        context.update();
    }
    
    public function record(commands:List<RootCommand>):Void
    {
        undoStack.push(commands);
        redoStack.clear();
    }
    
    public function clear():Void
    {
        undoStack.clear();
        redoStack.clear();        
    }
}
