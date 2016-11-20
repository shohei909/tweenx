package sample.context;
import js.html.MouseEvent;

typedef SampleSprite =
{
    public function update():Void;
    public function draw(context:DrawContext):Void;
    public function onMouseMove(e:MouseEvent):Void;
}
