import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Point;
import sample.SampleSuport.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;

using tweenxcore.Tools;

class Sample extends Sprite {
    static public inline var MOTION_END:Int = 50;

    var square:Square;
    var matrix:Matrix;
    var frame = 0;

    public function new() {
        super();

        //Initialize
        addChild(square = new Square());
        square.x = 100;
        square.y = 15;

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);

        matrix = new Matrix();
        matrix.createSimilarityTransform(100, 15, 350, 135);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frame, frame += 1);
        change.handlePart(5, 45, updateSquare);
    }

    function updateSquare(part:FloatChangePart) {
        var x = part.current.expoOutIn();
        var y = part.current.sinByRate().lerp(0, 0.1);
        var point = matrix.transformPoint(new Point(x, y));

        square.x = point.x;
        square.y = point.y;
    }
}
