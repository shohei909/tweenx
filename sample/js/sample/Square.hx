package sample;
import sample.context.DrawContext;
import sample.context.Drawable;

class Square implements Drawable {
    public static inline var SIZE:Int = 30;
    public var x:Float = 0;
    public var y:Float = 0;
    public var width:Float = SIZE;
    public var height:Float = SIZE;
    
    public function new() 
    {
    }
    
    public function draw(context:DrawContext):Void
    {
        context.context.fillStyle = Style.THEME_COLOR.toRgbCssString();
        context.context.fillRect(x, y, width, height);
    }
}
