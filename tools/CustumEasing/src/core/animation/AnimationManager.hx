package core.animation;
import component.basic.PreviewAnimation;
import component.complex.ComplexEasingId;
import core.ApplyResult;
import core.GlobalContext;
import js.Browser;
import js.html.CanvasElement;
import tweenxcore.expr.ComplexEasingKind;

class AnimationManager 
{
	public var time:Float;
	private var animations:Map<String, Animation>;
	private var context:GlobalContext;
	
	public function new(context:GlobalContext) 
	{
		this.context = context;
		animations = new Map();
		time = 1;
	}

	public function onFrame():Void
	{
		for (key in animations.keys())
		{
			var animation = animations[key];
			animation.onFrame();
			
			if (animation.isDead())
			{
				animations.remove(key);
			}
		}
	}
	
	public function add(id:String, animation:Animation):Void
	{
		animations[id] = animation;
	}
	
	public function startPreview(id:ComplexEasingId, easing:ComplexEasingKind):Void
	{
		var canvas = Browser.document.getElementById("preview-canvas-" + id.toString());
		
		if (canvas != null)
		{
			add(id.toString(), new PreviewAnimation(this, cast canvas, easing));
		}
	}
	
	public function changeTime(newTime:Float, result:ApplyResult):Void
	{
		if (time == newTime) return;
		result.addUndoCommand(GlobalCommand.ChangeAnimationTime(time));
		time = newTime;
		startPreview(ComplexEasingId.root(), context.easing.current);
	}
}
