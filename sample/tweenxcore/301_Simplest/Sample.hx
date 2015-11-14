import openfl.display.Sprite;
import openfl.events.Event;
import sample.SampleSuport.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
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

        addEventListener(Event.ENTER_FRAME, onFrame);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frameCount, frameCount + 1);
        change.handlePart(5, 25, updateSquare);
        frameCount++;
	}

    function updateSquare(change:FloatChangePart) {
        square.x = change.current.lerp(15, 435);
    }
}
