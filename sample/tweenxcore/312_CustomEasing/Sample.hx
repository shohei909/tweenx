import flash.display.Sprite;
import flash.events.Event;
import sample.SampleSuport.Square;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
import tweenxcore.structure.FloatChangeRepeatPart;

using tweenxcore.Tools;
using Sample.CustomEasing;

class Sample extends Sprite {
    static public inline var MOTION_END:Int = 220;
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
        change.handleRepeatPart(5, 60, 3, update);
    }

    function update(part:FloatChangeRepeatPart) {
        var start = 45;
        var end = 405;

        if (part.repeatIndex % 2 == 1)
        {
            var tmp = end;
            end = start;
            start = tmp;
        }

        var max = squares.length - 1;
        for (i in 0...squares.length) {
            var rate = i / max;
            part.handlePart(
                rate.lerp(0, 0.2),
                rate.lerp(0.2, 1.0),
                updateSquare.bind(i, start, end)
            );
        }
    }

    function updateSquare(i:Int, start:Float, end:Float, part:FloatChangePart) {
        var square:Square = squares[i];
        square.x = part.current.stylishBackIn().lerp(start, end);

        var curve = part.current.customYoyo().lerp(1.0, 0.1);
        square.scaleX = 1 / curve;
        square.scaleY = curve;
    }
}

class CustomEasing {
    public static inline function stylishBackIn(rate:Float) {
        return rate.crossfadeEasing(
            Easing.backIn,
            littleBackOut,
            quintQuintInOut
        );
    }

    static inline function quintQuintInOut(rate:Float) {
       return rate.quintInOut().quintInOut();
    }

    static inline function littleBackOut(rate:Float)
    {
        return rate.mixEasing(Easing.expoOut, Easing.backOut, 0.15);
    }

    public static inline function customYoyo(rate:Float) {
        return rate.crossfadeEasing(
            FloatTools.yoyo.bind(_, Easing.backIn),
            FloatTools.yoyo.bind(_, Easing.sineIn),
            Easing.linear,
            0,
            0.2
        );
    }
}
