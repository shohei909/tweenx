package sample.component;
import flash.display.BlendMode;
import flash.display.Shape;
import flash.display.Sprite;

class PlayButton extends Sprite 
{
    public static inline var SIZE:Int = 33;

    public function new() {
        super();
        var shape = new Shape();
        addChild(shape);

        shape.graphics.beginFill(SamplePlayer.THEME_COLOR);
        shape.graphics.drawCircle(0, 0, SIZE);
        shape.graphics.endFill();

        var side = SIZE * 0.63;

        shape.graphics.beginFill(0xFFFFFF);
        shape.graphics.moveTo(side, 0);
        shape.graphics.lineTo(-side / 2, 0.866 * side);
        shape.graphics.lineTo(-side / 2, -0.866 * side);
        shape.graphics.endFill();

        blendMode = BlendMode.LAYER;
    }
}