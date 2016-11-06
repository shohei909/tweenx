import flash.display.Sprite;
import flash.events.Event;
import sample.SampleSuport.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
import tweenxcore.structure.FloatChangeRepeatPart;
import tweenxcore.structure.FloatChangeTimelinePart;
import tweenxcore.structure.Timeline;
using tweenxcore.Tools;

class Sample extends Sprite {
    public static inline var MOTION_END = 200;
    var frameCount = 0;
    var square1:Square;
    var square2:Square;

    public function new() {
        super();

        //Initialize
        addChild(square1 = new Square());
        square1.x = 15;
        square1.y = Square.SIZE * 1.5;

        addChild(square2 = new Square());
        square2.x = 15;
        square2.y = Square.SIZE * 3.5;

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frameCount, frameCount += 1);
        change.handlePart(0, 80, updateSquare);
    }

    function updateSquare(part:FloatChangePart) {
        square1.x = part.current.quintInOut().quintInOut().lerp(0, 450);
        square2.x = part.current.cubicIn().bounceOut().lerp(0, 450);
    }
}
