package core.animation;

interface Animation 
{
    public function onFrame(time:Float):Void;
    public function isDead():Bool;
}