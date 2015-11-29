import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Lib;
import sample.SampleSuport.SamplePlayer;
import sample.SampleSuport.Square;
import tweenxcore.color.HsvColor;
import tweenxcore.color.RgbColor;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
import tweenxcore.structure.Timeline;

using tweenxcore.Tools;
using Sample.CustomEasing;


class Sample extends Sprite {
    static public inline var MOTION_END:Int = 120;

    var displayBitmapData:BitmapData;
    var sourceBitmapData:CharacterBitmapData;
    var frame = 0;
    var timeline:Timeline<Rectangle>;

    public function new() {
        super();

        var bitmap = new Bitmap(displayBitmapData = new BitmapData(32, 32, false, SamplePlayer.THEME_COLOR));
        addChild(bitmap);
        bitmap.x = (151 - 64) / 2;
        bitmap.y = (151 - 64) / 2;
        bitmap.scaleX = bitmap.scaleY = 2;

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);

        sourceBitmapData = new CharacterBitmapData();

        timeline = new Timeline();
        timeline.add(new Rectangle(0, 0, 32, 32), 0.5);
        for (i in 1...16) {
            timeline.add(new Rectangle(i * 32, 0, 32, 32));
        }
        timeline.add(new Rectangle(0, 0, 32, 32), 0.5);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frame, frame += 1);
        change.handleRepeatPart(0, 100, 0x7FFFFFFF, updateSquare);
    }

    function updateSquare(part:FloatChangePart) {
        displayBitmapData.fillRect(displayBitmapData.rect, SamplePlayer.THEME_COLOR);

        var curve = part.current.softExpoInOutTwice();
        var rect = timeline.search(curve).data;
        displayBitmapData.copyPixels(sourceBitmapData, rect, new Point());
    }
}


class CustomEasing {

    public static inline function softExpoInOutTwice(rate:Float)
    {
       return rate.mixEasing(CustomEasing.expoInOutTwice, Easing.linear, 0.9);
    }

    static inline function expoInOutTwice(rate:Float) {
        return rate.connectEasing(Easing.expoInOut, Easing.expoInOut);
    }
}

@:bitmap("character.png")
class CharacterBitmapData extends BitmapData
{
    public function new ()
    {
        super(0, 0);
    }
}

