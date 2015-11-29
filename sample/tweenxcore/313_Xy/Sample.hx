import flash.display.Sprite;
import flash.events.Event;
import sample.SampleSuport.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;

using tweenxcore.Tools;

class Sample extends Sprite {
    static public inline var MOTION_END:Int = 50;
    var square:Square;
    var frame = 0;

    public function new() {
        super();

        //Initialize
        addChild(square = new Square());
        square.x = 15;
        square.y = 75;

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frame, frame += 1);
        change.handlePart(5, 45, updateSquare);
    }

    function updateSquare(part:FloatChangePart) {
        square.x = part.current.expoOutIn().lerp(15, 435);
        square.y = part.current.sinByRate().lerp(75, 95);
    }
}
