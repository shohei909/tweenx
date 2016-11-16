package sample.component;
import flash.display.Sprite;
import sample.component.SamplePlayer;
import tweenxcore.color.HsvColor;
using tweenxcore.Tools;

class PlayButtonShadow extends Sprite
{
    public function new() {
        super();

        var color = HsvColor.of(SamplePlayer.THEME_COLOR);
        color.s = color.s.sineOut();
        color.v = color.v.lerp(0.1, 0.3);

        graphics.beginFill(color.toRgbInt(), 0.4);
        var size = PlayButton.SIZE * 1.1;

        graphics.moveTo(0, -2);
        graphics.lineTo(-size, 0);
        graphics.lineTo(size, 0);

        graphics.endFill();
    }
}
