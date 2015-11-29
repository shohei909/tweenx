package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.GradientType;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.Lib;
import flash.media.Sound;
import flash.media.SoundChannel;
import tweenxcore.geom.PolarPoint;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangeRepeatPart;
import tweenxcore.structure.FloatChangeTimelinePart;
import tweenxcore.structure.Timeline;
import tweenxcore.Tools.Easing;
using tweenxcore.Tools;

class Sample extends Sprite
{
    // Constants
    public static inline var bpm = 130;
    public static inline var totalBeat = 300;
    public static inline var startMillisecond:Float = 1875;

    // Setting
    var timeline:Timeline<FloatChangeTimelinePart->Void>;
    var center:Point;
    var size:Point;
    // Music
    var soundChannel:SoundChannel;

    // Context
    var previousBeat:Float = 0.0;

    // Display Object
    var juggler:Juggler;
    var frontLayer:FrontLayer;
    var title:Bitmap;

    public function new ()
    {
        super();

        // Setup
        timeline = new Timeline();
        timeline.add(introUpdate, 16);
        timeline.add(aPartUpdate, 16);

        size = new Point(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        center = new Point(size.x / 2, size.y / 2);

        juggler = new Juggler([
            [{num:1, easing:CustomEasing.strobo2}],
            [{num:2, easing:CustomEasing.strobo4}],
            [],
            [{num:1, easing:CustomEasing.strobo2}],
            [{num:1, easing:CustomEasing.strobo2}],
            [{num:3, easing:CustomEasing.strobo6}],
            [],
            [],

            [{num:2, easing:CustomEasing.strobo4}],
            [],
            [{num:1, easing:CustomEasing.strobo2}],
            [{num:1, easing:CustomEasing.strobo2}],
            [{num:3, easing:CustomEasing.strobo6}],
            [],
            [],
            [{num:1, easing:CustomEasing.strobo2}],

            [{num:3, easing:CustomEasing.strobo12}],
            [{num:1, easing:CustomEasing.strobo6}],
            [{num:2, easing:CustomEasing.strobo8}],
            [{num:3, easing:CustomEasing.strobo12}],
            [{num:1, easing:CustomEasing.strobo4}],
            [{num:3, easing:CustomEasing.strobo12}],
            [{num:3, easing:CustomEasing.strobo4}],
            [],

            [{num:2, easing:CustomEasing.strobo16}],
            [{num:3, easing:CustomEasing.strobo24}],
            [{num:1, easing:CustomEasing.strobo8}],
            [{num:3, easing:CustomEasing.strobo24}],
            [{num:1, easing:CustomEasing.strobo8}],
            [{num:2, easing:CustomEasing.strobo16}],
            [{num:3, easing:CustomEasing.strobo24}],
            [{num:1, easing:CustomEasing.strobo8}],

            [{num:3, easing:Easing.linear}],
            [{num:3, easing:Easing.linear}],
            [{num:3, easing:Easing.linear}],
            [{num:3, easing:Easing.linear}],
            [{num:3, easing:Easing.linear}],
            [{num:3, easing:Easing.linear}],
            [{num:3, easing:Easing.linear}],
            [{num:3, easing:Easing.linear}],

            [{num:5, easing:Easing.linear}],
            [{num:3, easing:Easing.linear}],
            [{num:1, easing:Easing.linear}],
            [{num:5, easing:Easing.linear}],
            [{num:3, easing:Easing.linear}],
            [{num:1, easing:Easing.linear}],
            [{num:5, easing:Easing.linear}],
            [{num:3, easing:Easing.linear}],

            [{num:1, easing:Easing.sineIn}],
            [{num:5, easing:Easing.sineIn}],
            [{num:3, easing:Easing.sineIn}],
            [{num:1, easing:Easing.sineIn}],
            [{num:5, easing:Easing.sineIn}],
            [{num:3, easing:Easing.sineIn}],
            [{num:1, easing:Easing.sineIn}],
            [{num:3, easing:Easing.sineIn}],

            [{num:4, easing:Easing.cubicIn}],
            [{num:4, easing:Easing.cubicIn}],
            [{num:1, easing:Easing.cubicIn}],
            [{num:4, easing:Easing.cubicIn}],
            [{num:4, easing:Easing.cubicIn}],
            [{num:1, easing:Easing.cubicIn}],
            [{num:4, easing:Easing.cubicIn}],
            [{num:4, easing:Easing.cubicIn}],

            [{num:1, easing:Easing.backIn}],
            [{num:4, easing:Easing.quintIn}],
            [{num:4, easing:Easing.quintIn}],
            [{num:1, easing:Easing.backIn}],
            [{num:4, easing:Easing.quintIn}],
            [{num:4, easing:Easing.quintIn}],
            [{num:1, easing:Easing.backIn}],
            [{num:4, easing:Easing.quintIn}],

            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:1, easing:Easing.backIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:1, easing:Easing.backIn}],

            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],

            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],

            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:5, easing:Easing.expoIn}],
            [{num:4, easing:Easing.expoIn}],
            [{num:3, easing:Easing.expoIn}],
            [{num:2, easing:Easing.expoIn}],
            [{num:1, easing:Easing.expoIn}],
            [],
            [],
        ]);

        addChild(frontLayer = new FrontLayer());
        frontLayer.x = center.x;
        frontLayer.y = center.y;

        addChild(juggler);
        juggler.x = center.x;
        juggler.y = center.y * 1.5;

        addChild(title = new Bitmap(new Logo()));
        title.scaleX = title.scaleY = 0.13;
        title.x = center.x - title.width / 2;
        title.y = center.y - title.height / 2;

        // Initialize Context


        // Music Start
        var music = new Music();
        soundChannel = music.play((0).beatToMillisecond(bpm) + startMillisecond * 0.5, 0);
        addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
	}


    private function onFrame(e:Event):Void {
        var currentMillisecond = soundChannel.position;
        var currentBeat:Float = (currentMillisecond - startMillisecond).millisecondToBeat(bpm);
        currentBeat = Math.max(currentBeat, 0);

        var change = new FloatChange(previousBeat, currentBeat);
        change.handleTimelinePart(0, timeline.totalWeight, timeline);
        change.handleRepeatPart(0, 1, totalBeat, frontLayer.update);
        change.handleRepeatPart(16, 17, totalBeat - 16, juggler.update);

        previousBeat = currentBeat;
    }

    // Intro
    function introUpdate(part:FloatChangeTimelinePart) {
        part.handleRepeatPart(0, 1 / 64, 64, introUpdateRepeatPart);
    }

    // Intro 1/4 Beat
    function introUpdateRepeatPart(part:FloatChangeRepeatPart)
    {
        if (part.isFirstEntrance())
        {
            var g = Lib.current.graphics;
            g.beginFill(0x100000);
            g.drawRect(0, 0, size.x, size.y);
        }

        if (part.isEntrance())
        {
            switch (part.repeatIndex % 32)
            {
                case 0, 1, 14, 15, 16, 17, 18:
                    frontLayer.countUpTexture();
            }
        }

        if (part.isLastExit())
        {
            switch (frontLayer.state)
            {
                case Empty:
                case Square(texture, _):
                    frontLayer.state = Square(texture, 1.06);
            }
        }
    }


    // A Part
    function aPartUpdate(part:FloatChangeTimelinePart) {
        part.handleRepeatPart(0, 1 / 32, 32, aPartUpdateRepeatPart);

        if (part.isEntrance())
        {
        }
    }

    // A Part 1/2 Beat
    function aPartUpdateRepeatPart(part:FloatChangeRepeatPart) {

    }
}

class FrontLayer extends Sprite
{
    public var state:CenterState;
    var textures:Array<BitmapData>;
    var mirror:BitmapData;
    var mainShape:Shape;

    public function new ()
    {
        super();

        // Setup
        textures = [
            new Texture1(),
            new Texture2(),
            new Texture3(),
        ];
        for (t in textures)
        {
            t.colorTransform(t.rect, new ColorTransform(0.9, 0.75, 0.6));
        }

        state = Empty;

        // Initialize DispalyObject
        var stageWidth = Lib.current.stage.stageWidth;
        var h = Std.int(Lib.current.stage.stageHeight / 2);
        addChild(mainShape = new Shape());
        var b = new Bitmap(mirror = new BitmapData(stageWidth, h, true, 0));
        addChild(b);
        b.x = -b.width / 2;
        b.y = h * 0.4;
    }

    // Draw
    public function update(part:FloatChangeRepeatPart)
    {
        var position:Float = part.repeatIndex + part.current;
        var g = mainShape.graphics;
        g.clear();

        switch (state)
        {
            case Square(texture, scale):
                g.beginBitmapFill(textures[texture], new Matrix(0.3, 0, 0, 0.3, -position * 2), true, true);

                var r = part.current.yoyo(Easing.quartOut).lerp(60, 60 * scale);
                var da = (Math.max(position, 16) - 16) / (Sample.totalBeat - 16);

                // Draw Square
                var p = new PolarPoint(r, 1 / 8 + da);
                g.moveTo(p.x, p.y);
                for (i in 1...4)
                {
                    p.angle += 1 / 4;
                    g.lineTo(p.x, p.y);
                }
                g.endFill();

            case Empty:
                // nothing to do
        }
    }

    public function countUpTexture() {
        var count = switch (state)
        {
            case Empty:
                0;
            case Square(texture, _):
                (texture + 1) % textures.length;
        }
        state = Square(count, 1.0);
    }
}


class Juggler extends Sprite
{
    public var siteSwaps:Array<Array<SiteSwap>>;
    public var balls:List<Ball>;
    public var mainLayer:Sprite;
    public var mirror:BitmapData;
    var reflectAlphaMap:ReflectAlphaMap;
    var mirrorTmp:BitmapData;

    public function new (siteSwaps:Array<Array<SiteSwap>>)
    {
        super();

        // Initialize Context
        this.siteSwaps = siteSwaps;
        balls = new List();


        // Initialize DisplayObject
        var stageWidth = Lib.current.stage.stageWidth;
        var h = Std.int(Lib.current.stage.stageHeight / 3);
        var b = new Bitmap(mirror = new BitmapData(stageWidth, h, true, 0));
        addChild(b);
        b.x = -b.width / 2;
        reflectAlphaMap = new ReflectAlphaMap(h);

        addChild(mainLayer = new Sprite());
        mirrorTmp = mirror.clone();
    }

    public function update(part:FloatChangeRepeatPart)
    {
        if (part.isEntrance())
        {
            if (siteSwaps.length > 0)
            {
                for (next in siteSwaps.shift())
                {
                    var ball:Ball = {
                        shape: new Shape(),
                        siteSwap: next,
                        startIndex: part.repeatIndex,
                    };

                    var g = ball.shape.graphics;
                    g.beginFill(0xEEBBBBB, 0.5);
                    GraphicTools.drawPolygon(g, 5, 12);

                    mainLayer.addChild(ball.shape);
                    balls.push(ball);
                }
            }
        }

        for (ball in balls)
        {
            var easing = ball.siteSwap.easing;
            var num = ball.siteSwap.num;
            var position = (part.repeatIndex - ball.startIndex + part.current) / num;

            if (position < 1)
            {
                // move
                var shape = ball.shape;
                var centerX = 0.0;
                var centerY = 0.0;

                if (num % 2 == 1) {
                    shape.x = easing(position).lerp(180, -180);
                } else {
                    shape.x = 180;
                }

                shape.y = -easing(position).yoyo(Easing.cubicOut).lerp(0, (12 * num * num) - 12) - 18;
                shape.rotation = -position.quartIn().lerp(0, num * num * 5).rateToDegree();
                shape.scaleX = shape.scaleY = part.current.yoyo(Easing.quartOut).lerp(1, 1.5);

                if (ball.startIndex % 2 != 0)
                {
                    shape.x = -shape.x;
                    shape.rotation = -shape.rotation;
                }
            }
            else
            {
                // Remove
                mainLayer.removeChild(ball.shape);
                balls.remove(ball);
            }
        }

        mirror.fillRect(mirror.rect, 0x00000000);
        mirrorTmp.fillRect(mirror.rect, 0x00000000);
        mirrorTmp.draw(mainLayer, new Matrix(1, 0, 0, -1, mirror.width / 2));
        mirror.copyPixels(mirrorTmp, mirrorTmp.rect, new Point(), reflectAlphaMap, new Point(), true);
    }
}

typedef Ball =
{
    shape: Shape,
    siteSwap: SiteSwap,
    startIndex: Int,
}

typedef SiteSwap =
{
    num:Int,
    easing:Float->Float
}

class CustomEasing
{
    public static function strobo2(rate:Float):Float
    {
        return rate.connectEasing(Easing.warpIn, Easing.warpIn);
    }

    public static function strobo4(rate:Float):Float
    {
        return rate.connectEasing(CustomEasing.strobo2, CustomEasing.strobo2);
    }

    public static function strobo8(rate:Float):Float
    {
        return rate.connectEasing(CustomEasing.strobo4, CustomEasing.strobo4);
    }

    public static function strobo16(rate:Float):Float
    {
        return rate.connectEasing(CustomEasing.strobo8, CustomEasing.strobo8);
    }

    public static function strobo6(rate:Float):Float
    {
        return rate.connectEasing(CustomEasing.strobo2, CustomEasing.strobo4, 1 / 3, 1 / 3);
    }

    public static function strobo12(rate:Float):Float
    {
        return rate.connectEasing(CustomEasing.strobo4, CustomEasing.strobo8, 1 / 3, 1 / 3);
    }

    public static function strobo24(rate:Float):Float
    {
        return rate.connectEasing(CustomEasing.strobo12, CustomEasing.strobo12);
    }

    public static function cubicBounceIn(rate:Float):Float
    {
        return rate.crossfadeEasing(Easing.bounceOut, Easing.warpOut, Easing.sineIn);
    }
}

class GraphicTools
{
    public static function drawPolygon(g:Graphics, num:Int, r:Float)
    {
        var p = new PolarPoint(r, 0.5 / num);
        g.moveTo(p.x, p.y);
        for (i in 1...num)
        {
            p.angle += 1 / num;
            g.lineTo(p.x, p.y);
        }
        g.endFill();
    }
}

enum CenterState
{
    Empty;
    Square(texture:Int, scale:Float);
}

class ReflectAlphaMap extends BitmapData
{
    public function new (height:Int) {
        var stageWidth = Lib.current.stage.stageWidth;
        super(stageWidth, height, true, 0x00000000);
        var matrix:Matrix = new Matrix();
        matrix.createGradientBox(stageWidth, height, Math.PI / 2, 0, 0);

        var shape = new Shape();
        var g = shape.graphics;
        g.beginGradientFill(GradientType.LINEAR, [0x000000, 0x000000], [0.4, 0], [125, 230], matrix);
        g.drawRect(0, 0, stageWidth, height);
        draw(shape);
    }
}

@:sound("music/tsudumi-japan.mp3")
class Music extends Sound {}

@:bitmap("wahu-pattern/hishi1.png")
class Texture1 extends BitmapData
{
    public function new() { super(0, 0); }
}

@:bitmap("wahu-pattern/mari1.png")
class Texture2 extends BitmapData
{
    public function new() { super(0, 0); }
}

@:bitmap("wahu-pattern/ougi1.png")
class Texture3 extends BitmapData
{
    public function new() { super(0, 0); }
}

@:bitmap("logo.png")
class Logo extends BitmapData
{
    public function new() { super(0, 0); }
}
