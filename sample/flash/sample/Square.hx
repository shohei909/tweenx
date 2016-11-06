package sample;
import flash.display.Shape;
import sample.component.SamplePlayer;

class Square extends Shape
{
    public static inline var SIZE:Int = 30;

    public function new() {
        super();
        graphics.beginFill(SamplePlayer.THEME_COLOR);
        graphics.drawRect( -SIZE / 2, -SIZE / 2, SIZE, SIZE);
    }
}