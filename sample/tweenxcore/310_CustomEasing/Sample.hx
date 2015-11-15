import openfl.display.Sprite;
import openfl.events.Event;
import sample.SampleSuport.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;

using tweenxcore.Tools;
using Sample.CustomEasing;

class Sample extends Sprite {
    static public inline var MOTION_END:Int = 120;
    var squares:Array<Square>;
    var frame = 0;

    public function new() {
        super();

        squares = [];
        for (i in 0...5) {
            var square = new Square();
            square.x = 45;
            square.y = Square.SIZE * (0.5 + i);
            addChild(square);
            squares.push(square);
        }

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frame, frame += 1);
        for (i in 0...5) {
            change.handlePart(i * 7 + 30, i * 7 + 63, updateSquare.bind(i));
        }
    }

    function updateSquare(i:Int, change:FloatChangePart) {
        var square:Square = squares[i];
        square.x = change.current.stylishIn().lerp(45, 405);

        var curve = change.current.customYoyo().lerp(1.0, 0.1);
        square.scaleX = 1 / curve;
        square.scaleY = curve;
    }
}

class CustomEasing {
    public static inline function decaInOut(rate:Float) {
       return rate.quintInOut().quintInOut();
    }

    public static inline function stylishIn(rate:Float) {
        return rate.crossEase(
            Easing.backIn,
            FloatTools.mixEase.bind(_, Easing.expoOut, Easing.backOut, 0.15),
            decaInOut
        );
    }

    public static inline function customYoyo(rate:Float) {
        return rate.crossEase(
            FloatTools.yoyo.bind(_, Easing.backIn),
            FloatTools.yoyo.bind(_, Easing.sineIn),
            Easing.linear,
            0,
            0.2
        );
    }
}
