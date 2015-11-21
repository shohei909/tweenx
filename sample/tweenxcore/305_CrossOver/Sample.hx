import flash.display.Sprite;
import flash.events.Event;
import flash.geom.ColorTransform;
import sample.SampleSuport.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
using tweenxcore.Tools;

class Sample extends Sprite {
    public static inline var MOTION_END = 120;
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
        change.handlePart(5, 45, updateSquare);
    }

    function updateSquare(part:FloatChangePart) {
        square.x = part.current.cubicIn().lerp(15, 435);

        if (part.isEntrance())
        {
            square.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0xFF, 0x78, 0x78);
        }

        if (part.isCrossOver(0.5))
        {
            square.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0x78, 0xFF, 0x78);
        }

        if (part.isExit())
        {
            square.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0x78, 0x78, 0xFF);
        }
    }
}
