import flash.display.Sprite;
import flash.events.Event;
import sample.SampleSuport.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
import tweenxcore.Tools.Easing;

using tweenxcore.Tools;

class Sample extends Sprite {
    public static inline var MOTION_END = 60;
    var square:Square;
    var frameCount = 0;

    public function new() {
        super();
        addChild(square = new Square());
        square.x = 15;
        square.y = Square.SIZE * 2.5;

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frameCount, frameCount += 1);
        change.handlePart(0, 40, updateSquare);
    }

    function updateSquare(part:FloatChangePart) {
        square.x = part.current.mixEasing(Easing.expoOutIn, Easing.linear, 0.12).lerp(15, 435);
    }
}
