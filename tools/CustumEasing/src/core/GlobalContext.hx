package core;
import component.complex.ComplexEasingId;
import core.GlobalCommand;
import core.animation.AnimationManager;
import core.easing.EasingManager;
import core.focus.FocusManager;
import core.history.HistoryManager;
import core.key.KeyboardManager;
import core.output.OutputManager;
import haxe.Json;
import js.Browser;
import js.html.Event;
import js.html.HashChangeEvent;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ComplexEasingKindTools;
import tweenxcore.expr.SimpleEasingKind;

class GlobalContext 
{
	public var key(default, null):KeyboardManager;
	public var history(default, null):HistoryManager;
	public var focus(default, null):FocusManager;
	public var animation(default, null):AnimationManager;
	public var output(default, null):OutputManager;
	public var easing(default, null):EasingManager;
	
	private var application:Application;
	private var currentHash:String;
	
	public function new() 
	{
		focus = new FocusManager(this);
		animation = new AnimationManager(this);
		history = new HistoryManager(this);
		key = new KeyboardManager(this);
		output = new OutputManager(this);
		easing = new EasingManager(this);
		
		currentHash = "";
		Browser.window.setTimeout(onFrame, 1 / 60);
		Browser.window.addEventListener("hashchange", onHashChange);
	}
	
	public function init():Void
	{
		applyHashChange();
		history.clear();
	}
	
	private function onHashChange(event:HashChangeEvent):Void 
	{
		if (Browser.location.hash != currentHash)
		{
			applyHashChange();
		}
	}
	
	private function onFrame():Void
	{
		animation.onFrame();
		Browser.window.setTimeout(onFrame, 1 / 60);
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
					
				case GlobalCommand.ChangeAnimationTime(value):
					animation.changeTime(value, result);
			}
		}
		
		return result;
	}
	
	public function applyHashChange():Void
	{
		currentHash = Browser.location.hash;
		
		try 
		{
			var data = Json.parse(StringTools.urlDecode(currentHash.substr(1)));
			
			try 
			{
				var easing = ComplexEasingKindTools.fromJsonable(data.easing);
				apply(GlobalCommand.ChangeEasing(ComplexEasingId.root(), easing));
				
				animation.startPreview(ComplexEasingId.root(), easing);
			}
			catch (e:Dynamic) {}
			
			try 
			{
				animation.time = cast(data.time, Float);
			}
			catch (e:Dynamic) {}
		}
		catch (e:Dynamic) {}
	}
	
	public function updateHash():Void
	{
		currentHash = "#" + StringTools.urlEncode(
			Json.stringify(
				{
					time: animation.time,
					easing: ComplexEasingKindTools.toJsonable(easing.current),
				}
			)
		);
		Browser.location.hash = currentHash;
	}
}
