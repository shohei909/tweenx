import sample.Sprite;
import sample.Square;
using tweenxcore.Tools;

class ShakeSample extends Sprite { 
    public static var TOTAL_FRAME:Int = 400;

    private var square1:Square;
    private var square2:Square;
    private var square3:Square;
    
    public function new() {
        super();
        addChild(square1 = new Square());
        addChild(square2 = new Square());
        addChild(square3 = new Square());
        
        square1.y = square2.y = square3.y = Square.SIZE * 2;
        square1.x = 90;
        square2.x = 225;
        square3.x = 360;
    }

    public function update():Void 
    {
        var scale = 3;
        square1.x = scale.shake( 90);
        square1.y = scale.shake( 60);
        
        square2.x = scale.shake(225, random2);
        square2.y = scale.shake( 60, random2);
        
        square3.x = scale.shake(360, random3);
        square3.y = scale.shake( 60, random3);
    }
    
    private static function random2():Float
    {
        return Math.random().quintInOut();
    }
    
    private static function random3():Float
    {
        return Math.random().quintOutIn();
    }
}
