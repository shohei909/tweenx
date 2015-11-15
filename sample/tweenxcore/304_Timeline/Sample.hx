import openfl.display.Sprite;
import openfl.events.Event;
import sample.SampleSuport.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangeRepeatPart;
import tweenxcore.structure.Timeline;

using tweenxcore.Tools;

class Sample extends Sprite {
    public static inline var MOTION_END = 60;
    var square:Square;
    var frameCount = 0;

    public function new() {
        super();

        //Initialize
        addChild(square = new Square());
        square.x = 15;
        square.y = Square.SIZE * 2.5;

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frameCount, frameCount += 1);
        var timeline = new Timeline()
            .add(updateSquare)
            .add(updateSquareReverse, 16);

        change.handleTimelinePart(0, MOTION_END, timeline);
    }

    function updateSquare(change:FloatChangeRepeatPart) {
        square.x = change.current.lerp(15, 435);
    }

    function updateSquareReverse(change:FloatChangeRepeatPart) {
        square.x = change.current.quintIn().cubicIn().lerp(435, 15);
    }
}
