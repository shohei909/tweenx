package sample.component;
import flash.display.Sprite;
import sample.component.SamplePlayer;
import tweenxcore.color.HsvColor;

class PlayButtonShadow extends Sprite
{
    public function new() {
        super();

        var color = HsvColor.of(SamplePlayer.THEME_COLOR);
        color.s = color.s.sineOut();
        color.v = color.v.lerp(0.1, 0.3);

        graphics.beginFill(color.toInt(), 0.4);
        var size = PlayButton.SIZE * 1.1;

        graphics.moveTo(0, -2);
        graphics.lineTo(-size, 0);
        graphics.lineTo(size, 0);

        graphics.endFill();
    }
}
