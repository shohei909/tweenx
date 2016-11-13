package sample.player;
import js.html.MouseEvent;

interface Player {
    public function update():Void;
    public function onClick():Void;
    public function onMouseMove(event:MouseEvent):Void;
}