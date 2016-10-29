package core.animation;

class AnimationManager 
{
	public var time:Float;
	private var animations:Map<String, Animation>;
	
	public function new() 
	{
		animations = new Map();
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
}
