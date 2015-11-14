import openfl.display.Sprite;
import openfl.events.Event;
import sample.SampleSuport.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangeRepeatPart;

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

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frameCount, frameCount += 1);
        change.handleRepeatPart(0, 40 / 3, 3, updateSquare);
	}

    function updateSquare(change:FloatChangeRepeatPart) {
        square.x = change.current.cubicIn().lerp(15, 435);
    }
}
