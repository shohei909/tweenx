import flash.display.Sprite;
import flash.display.Shape;
import flash.display.StageScaleMode;
import flash.geom.Matrix;
import flash.Lib;
import tweenx909.TweenX;

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

        //Make square
        var square = new Square(CELL_SIZE * 2);
        addChild(square);
        square.y = CELL_SIZE * 9;

        //Tween!!
        TweenX.to(square, {"x":360});
    }
}

private class Square extends Shape {
    public function new(size:Float) {
        super();
        graphics.beginFill(0x335F73);
        graphics.drawRect(0, 0, size, size);
    }
}
