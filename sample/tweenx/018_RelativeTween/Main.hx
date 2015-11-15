import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.geom.Matrix;

import tweenx909.TweenX;
import tweenx909.EaseX;
using tweenx909.ChainX;

class Main extends Sprite {
    static inline var CELL_SIZE = 20;
    public function new() {
        super();

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

        //Make square
        var square = new Square(CELL_SIZE * 2);
        addChild(square);

        //Tween!!
        TweenX.serial([
            TweenX.serial([
                TweenX.to(square).xy(360,   0),
                TweenX.to(square).xy(360, 360),
                TweenX.to(square).xy(  0, 360),
                TweenX.to(square).xy(  0,   0),
            ]),
            TweenX.wait(0.5),
            TweenX.serial([
                TweenX.to(square)._xy(360,   0),
                TweenX.to(square)._xy(360, 360),
                TweenX.to(square)._xy(  0, 360),
                TweenX.to(square)._xy(  0,   0),
            ]),
            TweenX.wait(0.5),
            TweenX.serial([
                TweenX.to(square).__xy( 360,    0),
                TweenX.to(square).__xy(   0,  360),
                TweenX.to(square).__xy(-360,    0),
                TweenX.to(square).__xy(   0, -360),
            ]),
        ]).delay(0.5);
    }
}

private class Square extends Shape {
    public function new(size:Float) {
        super();
        graphics.beginFill(0x335F73);
        graphics.drawRect(0, 0, size, size);
    }
}
