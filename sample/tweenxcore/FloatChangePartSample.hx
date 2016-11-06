import sample.Sprite;
import sample.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
using tweenxcore.Tools;

class FloatChangePartSample extends Sprite { 
    public static var TOTAL_FRAME:Int = 60;

    private var square:Square;
    private var frameCount:Int = 0;
    
    public function new() {
        super();
        addChild(square = new Square());
        square.y = Square.SIZE * 2;
        square.width = 0;
    }

    public function update():Void {
        var floatChange = new FloatChange(frameCount, frameCount += 1);
        floatChange.handlePart(20.0, 50.5, updatePart);
    }
    
    private function updatePart(part:FloatChangePart):Void {
        var left  = part.previous.expoIn().lerp(0, 480);
        var right = part.current.expoIn().lerp(0, 480);
        
        square.x = left;
        square.width = right - left; 
    }
}
