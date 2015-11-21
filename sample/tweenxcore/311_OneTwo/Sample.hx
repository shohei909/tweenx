import flash.display.Sprite;
import flash.events.Event;
import sample.SampleSuport.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
import tweenxcore.Tools.Easing;
using tweenxcore.Tools;

class Sample extends Sprite {
    public static inline var MOTION_END = 120;
    var square1:Square;
    var square2:Square;
    var square3:Square;
    var frameCount = 0;

    public function new() {
        super();

        //Initialize
        addChild(square1 = new Square());
        square1.x = 45;
        square1.y = Square.SIZE * 1.0;

        addChild(square2 = new Square());
        square2.x = 45;
        square2.y = Square.SIZE * 2.5;

        addChild(square3 = new Square());
        square3.x = 45;
        square3.y = Square.SIZE * 4.0;

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frameCount, frameCount += 1);
        change.handlePart(0, 60, updateSquare);
    }

    function updateSquare(part:FloatChangePart) {
        square1.x = part.current.oneTwoEasing(Easing.backIn, 0.8, Easing.linear).lerp(45, 405);

        square2.x = part.current.oneTwoEasing(
            function (r:Float) { return r.yoyo(Easing.cubicOut).lerp(0, 0.3); },
            0.9,
            Easing.linear
        ).lerp(45, 405);

        square3.x = part.current.oneTwoEasing(
            function (r:Float) { return r.backOut(); },
            0.8,
            function (r:Float) { return r.revert().sineIn(); }
        ).lerp(45, 405);
    }
}
