package core.animation;

interface Animation 
{
	public function onFrame():Void;
	public function isDead():Bool;
}