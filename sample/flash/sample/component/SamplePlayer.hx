package sample.component;
import flash.display.Graphics;
import flash.display.Sprite;

class SamplePlayer extends Sprite 
{
    public static var THEME_COLOR:Int = 0x4EDAE1;
    private var child:Sprite;

    static function drawGrid(graphics:Graphics, size = 15, w = 30, h = 10) {
        //Draw background
        var end = size * w;
        for (i in 0...h + 1) {
            var p = i * size;
            graphics.beginFill(0xF1F1EF, 1);
            graphics.drawRect(0, p, end, 1);
            graphics.endFill();
        }

        var end = size * h;
        for (i in 0...w + 1) {
            var p = i * size;
            graphics.beginFill(0xF1F1EF, 1);
            graphics.drawRect(p, 0, 1, end);
            graphics.endFill();
        }
    }
}
