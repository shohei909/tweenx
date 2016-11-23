import flash.display.Bitmap;
import flash.display.BitmapData;
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
        var walk0 = new Walk0BitmapData();
        var walk1 = new Walk1BitmapData();
        var walk2 = new Walk2BitmapData();
        

        var bitmap = new Bitmap();
        addChild(bitmap);
        bitmap.y = CELL_SIZE * 9 + 7;
        bitmap.x = CELL_SIZE * 9 + 7;
        
        var timeline = new Timeline<BitmapData>();
        timeline.add(walk0);
        timeline.add(walk1);
        timeline.add(walk2);
        timeline.add(walk1);
        
        //Tween!!
        TweenX.to(bitmap, {bitmapData: timeline}).time(1).repeat(0);
    }
}

private class Square extends Shape {
    public function new(size:Float) {
        super();

        graphics.beginFill(0x335F73);
        graphics.drawRect(0, 0, size, size);
    }
}

@:bitmap("assets/walk0.png")
class Walk0BitmapData extends BitmapData
{
    public function new () { super(0, 0); }
}

@:bitmap("assets/walk1.png")
class Walk1BitmapData extends BitmapData
{
    public function new () { super(0, 0); }
}

@:bitmap("assets/walk2.png")
class Walk2BitmapData extends BitmapData
{
    public function new () { super(0, 0); }
}