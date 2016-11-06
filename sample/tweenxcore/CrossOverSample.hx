import sample.Sprite;
import sample.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
using tweenxcore.Tools;

class CrossOverSample extends Sprite { 
    public static var TOTAL_FRAME:Int = 60;

    private var square:Square;
    private var frameCount:Int = 0;

    public function update():Void {
        var floatChange = new FloatChange(frameCount, frameCount += 1);
        if (floatChange.isCrossOver(30.0)) {
            addChild(square = new Square());
            square.width = 481;
            square.height = 151;
        }
    }
}
