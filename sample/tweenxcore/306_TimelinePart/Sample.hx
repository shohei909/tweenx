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
    public static inline var MOTION_END = 120;
    var square:Square;
    var frameCount = 0;
    var timeline:Timeline<FloatChangeTimelinePart->Void>;

    public function new() {
        super();

        //Initialize
        addChild(square = new Square());
        square.x = 15;
        square.y = 15;

        timeline = new Timeline();
        timeline.add(update1, 1).add(update2, 3).add(update3, 12);

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frameCount, frameCount += 1);

        change.handleTimelinePart(5, 85, timeline);
    }

    function update1(part:FloatChangePart) {
        square.x = part.current.lerp(0, 450);
    }

    function update2(part:FloatChangeTimelinePart) {
        square.y = part.current.cubicInOut().lerp(15, 135);
    }

    function update3(part:FloatChangeTimelinePart) {
        square.x = part.current.quartIn().cubicIn().lerp(435, 15);
    }
}
