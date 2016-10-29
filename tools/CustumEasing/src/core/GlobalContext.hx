package core;
import core.GlobalCommand;
import core.animation.AnimationManager;
import core.easing.EasingManager;
import core.focus.FocusManager;
import core.history.HistoryManager;
import core.key.KeyboardManager;
import core.output.OutputManager;
import js.Browser;

class GlobalContext 
{
	public var key(default, null):KeyboardManager;
	public var history(default, null):HistoryManager;
	public var focus(default, null):FocusManager;
	public var animation(default, null):AnimationManager;
	public var output(default, null):OutputManager;
	public var easing(default, null):EasingManager;
	
	private var application:Application;
	
	public function new() 
	{
		focus = new FocusManager(this);
		animation = new AnimationManager();
		history = new HistoryManager(this);
		key = new KeyboardManager(this);
		output = new OutputManager(this);
		easing = new EasingManager(this);
		
		Browser.window.setTimeout(onFrame, 16);
	}
	
	private function onFrame():Void
	{
		animation.onFrame();
		Browser.window.setTimeout(onFrame, 16);
	}
	
	public function setup(application:Application):Void
	{
		this.application = application;
	}
	
	public function update():Void
	{
		application.forceUpdate();	
	}
	
	// ------------------------------------------
	// Apply Command
	// ------------------------------------------
	public function apply(command:GlobalCommand):Void
	{
		applyAll([command]);
	}
	
	public function applyAll(commands:Iterable<GlobalCommand>):Void
	{
		var result = applyWithoutRecord(commands);
		
		if (!result.undoCommands.isEmpty())
		{
			history.record(result.undoCommands);
		}
		
		update();
	}
	
	public function applyWithoutRecord(commands:Iterable<GlobalCommand>):ApplyResult
	{
		var result = new ApplyResult();
		for (command in commands)
		{
			switch (command)
			{
				case GlobalCommand.ChangeEasing(id, easingKind):
					easing.changeEasing(id, easingKind, result);
					
				case GlobalCommand.ChangeRate(id, rate):
					easing.changeRate(id, rate, result);
					
				case GlobalCommand.ChangeInOut(id, inOut):
					easing.changeInOut(id, inOut, result);
					
				case GlobalCommand.ChangeOutputMode(mode):
					output.changeMode(mode, result);
			}
		}
		
		return result;
	}
}
