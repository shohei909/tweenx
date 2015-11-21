import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFormat;
import haxe.ds.Vector;
import org.libspark.betweenas3.BetweenAS3;
import org.libspark.betweenas3.easing.Expo;
import org.libspark.betweenas3.tweens.ITween;


class BetweenAS3Bench extends Sprite {
    static inline var LENGTH = 30000;
    static inline var WIDTH        = 465;
    static inline var HEIGHT    = 465;
    static inline var COLOR        = 0xFFFFFFFF;
    static inline var TIME_LIMIT     = 60000;
    static var colorTransform     = new ColorTransform(0.9, 0.7, 0.8);

    public static function main() {
        Lib.current.stage.addChild(new BetweenAS3Bench());
    }

    var seconds:Float     = 0;
    var count:Int          = -3;
    var oldTime:Float    = 0;

    var fpsField:TextField;
    var points:Vector<Point>;
    var bitmapData:BitmapData;
    var startTime:Float     = 0;
    var result:Null<Float>     = null;

    public function new() {
        super();
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;


        addChild(new Bitmap(bitmapData = new BitmapData(WIDTH, HEIGHT, false, 0)));
        addChild(fpsField = new TextField());
        fpsField.defaultTextFormat = new TextFormat("_sans", 15, 0xFFFFFF);
        fpsField.text = "fps:--";
        fpsField.width = WIDTH;

        points = new Vector<Point>(LENGTH);
        for(i in 0...LENGTH){
            var p = points[i] = new Point(WIDTH * Math.random(), HEIGHT);

            var t:ITween = BetweenAS3.to(p, { "y":0 }, 0.2 + 10 * Math.random(), Expo.easeIn);
            t.stopOnComplete = false;

            t.play();
        }


        addEventListener(Event.EXIT_FRAME, onFrame);
        startTime = Date.now().getTime();
    }

    public function onFrame(e) {
        var b = bitmapData;
        b.lock();
        b.colorTransform(b.rect, colorTransform);
        for (i in 0...LENGTH) {
            var p = points[i];
            b.setPixel(Std.int(p.x), Std.int(p.y), COLOR);
        }
        b.unlock();

        var time = Date.now().getTime();
        if (count++ > 0) {
            seconds *= (count - 1) / count;
            seconds += (time - oldTime) / count;
            fpsField.text = untyped "BetweenAS3 fps:" + (1000 / seconds).toFixed(2);
            if (time - startTime >= TIME_LIMIT) {
                if (result == null) result = (1000 / seconds);
                fpsField.text += untyped " result:" + result.toFixed(2);
            }
        }
        oldTime = time;
    }
}
