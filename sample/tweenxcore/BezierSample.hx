import sample.Sprite;
import sample.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
using tweenxcore.Tools;

class BezierSample extends Sprite { 
    public static var TOTAL_FRAME:Int = 60;

    private var square:Square;
    private var frameCount:Int = 0;
    
    public function new() {
        super();
        addChild(square = new Square());
    }
    
    public function update():Void {
        var floatChange = new FloatChange(frameCount, frameCount += 1);
        floatChange.handlePart(20.0, 50.5, updatePart);
    }
    
    private function updatePart(part:FloatChangePart) {
        var rate = part.current;
        square.x = rate.bezier3(0, 50, 400, 450);
        square.y = rate.bezier3(0, 200, -50, 120);
    }
}
