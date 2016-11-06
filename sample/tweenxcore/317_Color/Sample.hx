import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Point;
import sample.SampleSuport.Square;
import tweenxcore.color.HsvColor;
import tweenxcore.color.RgbColor;
import tweenxcore.geom.PolarPoint;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
using tweenxcore.Tools;

class Sample extends Sprite {
    static public inline var MOTION_END:Int = 120;
    var frame = 0;

    public function new() {
        super();

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frame, frame += 1);
        change.handlePart(5, 40, updateSquare);
    }

    function updateSquare(part:FloatChangePart) {
        var prevX = part.previous.expoInOut().lerp(0, 450);
        var currentX = part.current.expoInOut().lerp(0, 450);

        // RGBカラー
        var rgbCurve = part.current.expoInOut();
        var red = rgbCurve.lerp(0.8, 0.7);
        var green = rgbCurve.lerp(0.7, 1);
        var blue = rgbCurve.lerp(0.5, 1);
        graphics.beginFill(new RgbColor(red, green, blue).toRgbInt());
        graphics.drawRect(prevX, 30, currentX - prevX, 30);

        // HSVカラー
        var hsvCurve = part.current.expoInOut();
        var hue = hsvCurve.lerp(0.0, 1.0);
        var saturation = hsvCurve.lerp(0.0, 0.8);
        var value = 0.95;
        graphics.beginFill(new HsvColor(hue, saturation, value).toInt());
        graphics.drawRect(prevX, 90, currentX - prevX, 30);
    }
}
