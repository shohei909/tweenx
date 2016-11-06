import sample.Sprite;
import sample.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangeRepeatPart;
using tweenxcore.Tools;

class RepeatSample extends Sprite { 
    public static var TOTAL_FRAME:Int = 60;

    private var square:Square;
    private var frameCount:Int = 0;
    
    public function new() {
        super();
        addChild(square = new Square());
        square.y = Square.SIZE * 2;
    }

    public function update():Void {
        var floatChange = new FloatChange(frameCount, frameCount += 1);
        floatChange.handleRepeatPart(20, 60, 3, updatePart);
    }
    
    private function updatePart(part:FloatChangeRepeatPart):Void {
        square.x = part.current.expoIn().lerp(0, 450);
    }
}
