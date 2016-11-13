import js.Browser;
import js.html.CanvasElement;
import js.html.MouseEvent;
import sample.Sprite;
import sample.Square;
import tweenxcore.color.HsvColor;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
import tweenxcore.structure.FloatChangeRepeatPart;
using tweenxcore.Tools;
using CustomEasingSample.CustomEasing;

class MouseSample extends Sprite { 
    public static inline var TOTAL_FRAME:Int = 0xFFFFFF;
    var square:Square;
    
    public function new() {
        super();

        square = new Square();
        addChild(square);
    }

    public function update():Void {}
    
    public override function onMouseMove(e:MouseEvent):Void {
        var mouseX = e.clientX;
        var mouseY = e.clientY;
        
        var rateX = mouseX.inverseLerp(10, 800).clamp(0, 1);
        var rateY = mouseY.repeat(0, 400);
        
        square.x = rateX.expoInOut().lerp(0, 450);
        square.y = rateY.yoyo(Easing.expoInOut).lerp(0, 120);
    }
}
