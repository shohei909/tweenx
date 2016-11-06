import sample.Sprite;
import sample.Square;
using tweenxcore.Tools;

class SimplestSample extends Sprite {
    public static var TOTAL_FRAME:Int = 20;
    private var square:Square;
    private var frameCount = 0;

    public function new() {
        super();
        addChild(square = new Square());
        square.y = Square.SIZE * 2;
    }

    public function update():Void {
        var rate = frameCount / TOTAL_FRAME;
        if (rate <= 1) {
            square.x = rate.quintOut().lerp(0, 450);
        }
        frameCount++;
    }
}
