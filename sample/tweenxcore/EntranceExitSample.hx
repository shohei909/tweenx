import sample.Sprite;
import sample.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
using tweenxcore.Tools;

class EntranceExitSample extends Sprite { 
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
        floatChange.handlePart(20.0, 50.5, updatePart);
    }
    
    private function updatePart(part:FloatChangePart) {
        if (part.isEntrance()) {
            var topBar = new Square();
            addChild(topBar);
            topBar.width = 481;
        }
        
        square.x = part.current.expoIn().lerp(0, 450);
 
        if (part.isExit()) {
            var bottomBar = new Square();
            addChild(bottomBar);
            bottomBar.y = 120;
            bottomBar.width = 481;
        }
    }
}
