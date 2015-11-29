import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Point;
import sample.SampleSuport.Square;
import tweenxcore.geom.PolarPoint;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;

using tweenxcore.Tools;

class Sample extends Sprite {
    static public inline var MOTION_END:Int = 60;
    var square:Square;
    var frame = 0;

    public function new() {
        super();

        //Initialize
        addChild(square = new Square());
        square.x = 15;
        square.y = 15;

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frame, frame += 1);
        change.handlePart(5, 40, updateSquare);
    }

    function updateSquare(part:FloatChangePart) {
        square.x = part.current.bezier3(15, 50, 400, 435);
        square.y = part.current.bezier3(15, 200, -50, 135);
    }
}
