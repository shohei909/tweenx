import sample.Sprite;
import sample.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
using tweenxcore.Tools;

class XySample extends Sprite { 
    public static var TOTAL_FRAME:Int = 40;

    private var square:Square;
    private var frameCount:Int = 0;
    
    public function new() {
        super();
        addChild(square = new Square());
        square.y = Square.SIZE * 2;
    }

    public function update():Void {
        var floatChange = new FloatChange(frameCount, frameCount += 1);
        floatChange.handlePart(0.0, 40.0, updatePart);
    }
    
    private function updatePart(part:FloatChangePart):Void {
        square.x = part.current.lerp(0, 450);
        square.y = part.current.sinByRate().lerp(60, 105);
    }
}
