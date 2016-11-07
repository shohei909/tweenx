package sample;
import sample.context.DrawContext;
import sample.context.Drawable;
import tweenxcore.color.IColor;

class Square implements Drawable {
    public static inline var SIZE:Int = 30;
    public var x:Float = 0;
    public var y:Float = 0;
    public var width:Float = SIZE;
    public var height:Float = SIZE;
    public var color:IColor;
    
    public function new() 
    {
        this.color = Style.THEME_COLOR;
    }
    
    public function draw(context:DrawContext):Void
    {
        context.context.fillStyle = color.toRgbCssString();
        context.context.fillRect(x, y, width, height);
    }
}
