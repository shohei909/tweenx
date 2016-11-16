import flash.Assets;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.StageScaleMode;
import flash.geom.Matrix;
import flash.Lib;
import tweenx909.rule.TimelineRuleX;
import tweenx909.TweenX;
import tweenx909.EaseX;
import tweenxcore.structure.Timeline;
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

        //Make square
        var walk0 = Assets.getBitmapData("assets/walk0.png");
        var walk1 = Assets.getBitmapData("assets/walk1.png");
        var walk2 = Assets.getBitmapData("assets/walk2.png");

        var bitmap = new Bitmap();
        addChild(bitmap);
        bitmap.y = CELL_SIZE * 9 + 7;
        bitmap.x = CELL_SIZE * 9 + 7;

        //Tween!!
        TweenX.to(bitmap, {bitmapData: new Timeline([walk0,walk1,walk2,walk1])}).time(1).repeat(0);
    }
}

private class Square extends Shape {
    public function new(size:Float) {
        super();

        graphics.beginFill(0x335F73);
        graphics.drawRect(0, 0, size, size);
    }
}
