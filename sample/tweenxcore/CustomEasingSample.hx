import sample.Sprite;
import sample.Square;
import tweenxcore.color.HsvColor;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
import tweenxcore.structure.FloatChangeRepeatPart;
using tweenxcore.Tools;
using CustomEasingSample.CustomEasing;

class CustomEasingSample extends Sprite { 
    public static inline var TOTAL_FRAME:Int = 180;
    var squares:Array<Square>;
    var frame = 0;

    public function new() {
        super();

        squares = [];
        for (i in 0...5) {
            var square = new Square();
            square.x = 30;
            square.y = Square.SIZE * i;
            addChild(square);
            squares.push(square);
        }
    }

    public function update():Void {
        var change = new FloatChange(frame, frame += 1);
        change.handleRepeatPart(0, 60, 3, updatePart);
    }

    private function updatePart(part:FloatChangeRepeatPart) {
        var start = 30;
        var end = 420;

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

    private function updateSquare(i:Int, start:Float, end:Float, part:FloatChangePart) {
        var square:Square = squares[i];

        var curve = part.current.customYoyo().lerp(1.0, 0.1);
        square.width = Square.SIZE * 1 / curve;
        square.height = Square.SIZE * curve;
        square.x = part.current.stylishBackIn().lerp(start, end) - (square.width - Square.SIZE) / 2;
        square.y = (i + (1 - curve) / 2) * Square.SIZE;
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

    private static inline function quintQuintInOut(rate:Float) {
       return rate.quintInOut().quintInOut();
    }

    private static inline function littleBackOut(rate:Float)
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
