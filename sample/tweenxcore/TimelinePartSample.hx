import sample.Sprite;
import sample.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangeRepeatPart;
import tweenxcore.structure.FloatChangeTimelinePart;
import tweenxcore.structure.Timeline;
using tweenxcore.Tools;

class TimelinePartSample extends Sprite { 
    public static var TOTAL_FRAME:Int = 80;

    private var square:Square;
    private var frameCount:Int = 0;
    private var timeline:Timeline<FloatChangeTimelinePart->Void>;
    
    public function new() {
        super();
        addChild(square = new Square());
        
        timeline = new Timeline().add(update1, 1).add(update2, 2).add(update3, 5);
    }

    public function update():Void {
        var floatChange = new FloatChange(frameCount, frameCount += 1);

        floatChange.handleTimelinePart(0, 80, timeline);
    }

    private function update1(part:FloatChangeTimelinePart):Void {
        square.x = part.current.lerp(0, 450);
    }

    private function update2(part:FloatChangeTimelinePart):Void {
        square.y = part.current.cubicInOut().lerp(0, 120);
    }

    private function update3(part:FloatChangeTimelinePart):Void {
        square.x = part.current.quartIn().cubicIn().lerp(450, 0);
    }
}
