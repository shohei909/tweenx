import sample.Sprite;
import sample.Square;
import tweenxcore.geom.PolarPoint;
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

class PolarSample extends Sprite { 
    public static var TOTAL_FRAME:Int = 40;

    private var square:Square;
    private var frameCount:Int = 0;
    private var matrix:MatrixImpl;
    
    public function new() {
        super();
        addChild(square = new Square());
        square.y = Square.SIZE * 2;
        
        matrix = new MatrixImpl();
        matrix.createSimilarityTransform(210, 60, 0, 0);
    }

    public function update():Void {
        var floatChange = new FloatChange(frameCount, frameCount += 1);
        floatChange.handlePart(0.0, 40.0, updatePart);
    }
    
    private function updatePart(part:FloatChangePart):Void {
        var distance = part.current.expoOut().lerp(1, 0);
        var angle = part.current.lerp(0, -2);
        
        var polarPoint = new PolarPoint(distance, angle);
        var x = polarPoint.x;
        var y = polarPoint.y;

        square.x = matrix.a * x + matrix.c * y + matrix.tx;
        square.y = matrix.b * x + matrix.d * y + matrix.ty;
    }
}
