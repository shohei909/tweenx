import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.StageScaleMode;
import openfl.geom.Matrix;
import openfl.Lib;

import tweenx909.TweenX;
import tweenx909.EaseX;
using tweenx909.ChainX;

class Main extends Sprite {
    static inline var CELL_SIZE = 20;
    public function new() {
        super();
        Lib.current.stage.scaleMode = StageScaleMode.SHOW_ALL;

        //Draw background
        graphics.lineStyle(1, 0xEEEEEE);
        var end = CELL_SIZE * 20;
        for (i in 0...21) {
            var p = i * CELL_SIZE;
            graphics.moveTo(0, p);
            graphics.lineTo(end, p);
            graphics.moveTo(p, 0);
            graphics.lineTo(p, end);
        }


        //Tween!!
        function draw(x:Float, size:Float) {
            graphics.lineStyle(1, 0x335F73);
            graphics.drawCircle(x, 200, size);
        }

        TweenX.tweenFunc2(draw, 10, 10, 300, 100).time(0.5).ease(EaseX.quadIn);
    }
}
