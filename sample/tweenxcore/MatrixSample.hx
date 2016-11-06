import sample.Sprite;
import sample.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
using tweenxcore.Tools;

#if flash
import flash.geom.Matrix in MatrixImpl;
#else
private class MatrixImpl {
    public var a:Float = 1;
    public var b:Float = 0;
    public var c:Float = 0;
    public var d:Float = 1;
    public var tx:Float = 0;
    public var ty:Float = 0;
    
    public function new() {}
}
#end

class MatrixSample extends Sprite { 
    public static var TOTAL_FRAME:Int = 40;

    private var square:Square;
    private var frameCount:Int = 0;
    private var matrix:MatrixImpl;
    
    public function new() {
        super();
        addChild(square = new Square());
        square.y = Square.SIZE * 2;
        
        matrix = new MatrixImpl();
        matrix.createSimilarityTransform(100, 0, 350, 120);
    }

    public function update():Void {
        var floatChange = new FloatChange(frameCount, frameCount += 1);
        floatChange.handlePart(0.0, 40.0, updatePart);
    }
    
    private function updatePart(part:FloatChangePart):Void {
        var x = part.current;
        var y = part.current.sinByRate().lerp(0, 0.1);

        square.x = matrix.a * x + matrix.c * y + matrix.tx;
        square.y = matrix.b * x + matrix.d * y + matrix.ty;
    }
}
