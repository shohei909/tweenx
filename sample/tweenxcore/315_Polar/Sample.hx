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
    var matrix:Matrix;
    var frame = 0;

    public function new() {
        super();

        //Initialize
        addChild(square = new Square());
        square.x = 15;
        square.y = 15;

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);

        matrix = new Matrix();
        matrix.createSimilarityTransform(225, 75, 15, 15);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frame, frame += 1);
        change.handlePart(5, 40, updateSquare);
    }

    function updateSquare(part:FloatChangePart) {
        var distance = part.current.expoOut().lerp(1, 0);
        var angle = part.current.lerp(0, -2);
        var polarPoint = new PolarPoint(distance, angle);

        var point = matrix.transformPoint(new Point(polarPoint.x, polarPoint.y));
        square.x = point.x;
        square.y = point.y;
    }
}
