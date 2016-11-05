package core;
import component.basic.NumberInputId;
import component.complex.ComplexEasingId;
import core.RootCommand;
import core.animation.AnimationManager;
import core.drag.DragManager;
import core.easing.EasingCommand;
import core.easing.EasingManager;
import core.focus.FocusManager;
import core.history.HistoryManager;
import core.key.KeyboardManager;
import core.localize.LocalizeManager;
import core.output.OutputManager;
import core.storage.StorageManager;
import haxe.Json;
import haxe.ds.Option;
import js.Browser;
import js.html.Event;
import js.html.HashChangeEvent;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ComplexEasingKindTools;
import tweenxcore.expr.SimpleEasingKind;

class RootContext 
{
    public var storage(default, null):StorageManager;
    public var key(default, null):KeyboardManager;
    public var history(default, null):HistoryManager;
    public var focus(default, null):FocusManager;
    public var animation(default, null):AnimationManager;
    public var output(default, null):OutputManager;
    public var easing(default, null):EasingManager;
    public var localize(default, null):LocalizeManager;
    public var drag(default, null):DragManager;
    
    private var application:Application;
    private var currentHash:String;
    private var minorResult:Option<ApplyResult>;
    
    public function new() 
    {
        storage = new StorageManager(this);
        focus = new FocusManager(this);
        animation = new AnimationManager(this);
        history = new HistoryManager(this);
        key = new KeyboardManager(this);
        output = new OutputManager(this);
        easing = new EasingManager(this);
        localize = new LocalizeManager(this);
        drag = new DragManager(this);
        minorResult = Option.None;
        
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
    public function apply(command:RootCommand, major:Bool):Void
    {
        applyAll([command], major);
    }
    
    public function applyAll(commands:Iterable<RootCommand>, major:Bool):Void
    {
        var result = applyWithoutRecord(commands, major);
        
        applyResult(result, false);
        update();
    }
    
    public function applyNumberChange(id:NumberInputId, value:Float, major:Bool):Void
    {
        var command = switch (id)
        {
            case NumberInputId.EasingRate(_id):
                RootCommand.ChangeEasing(_id.parent(), Rate(_id.rateIndex(), value));
                
            case NumberInputId.AnimationTime:
                RootCommand.ChangeAnimationTime(value);
        }
        apply(command, major);
    }
    
    public function applyResult(result:ApplyResult, ignoreUndo:Bool):Void
    {
        switch (minorResult)
        {
            case Option.Some(prevResult):
                prevResult.merge(result);
                result = prevResult;
                
            case Option.None:
        }
        
        if (result.major)
        {
            if (!ignoreUndo && !result.undoCommands.isEmpty())
            {
                history.record(result.undoCommands);
            }
            if (result.saveRequested)
            {
                storage.save();
            }
            if (result.updateHashRequested)
            {
                updateHash();
            }
            for (id in result.previews.keys())
            {
                animation.startPreview(ComplexEasingId.fromString(id), result.previews[id]);
            }
            
            minorResult = Option.None;
        }
        else
        {
            minorResult = Option.Some(result);
        }
        
    }
    
    public function applyWithoutRecord(commands:Iterable<RootCommand>, major:Bool):ApplyResult
    {
        var result = new ApplyResult(major);
        for (command in commands)
        {
            switch (command)
            {
                case RootCommand.ChangeEasing(id, command):
                    easing.change(id, command, result);
                    
                case RootCommand.ChangeOutputMode(mode):
                    output.changeMode(mode, result);
                    
                case RootCommand.ChangeAnimationTime(value):
                    animation.changeTime(value, result);
                    
                case RootCommand.ChangeLocale(locale):
                    localize.changeLocale(locale, result);
            }
        }
        
        return result;
    }
    
    private function applyHashChange():Void
    {
        currentHash = Browser.location.hash;
        
        try 
        {
            var data = Json.parse(StringTools.urlDecode(currentHash.substr(1)));
            
            try 
            {
                var easing = ComplexEasingKindTools.fromJsonable(data.easing);
                apply(RootCommand.ChangeEasing(ComplexEasingId.root(), EasingCommand.Replace(easing)), true);
                
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
    
    private function updateHash():Void
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
