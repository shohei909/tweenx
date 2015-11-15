
import haxe.Log;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.text.Font;
import openfl.text.TextField;
import openfl.text.TextFormat;
import tweenx909.advanced.UpdateModeX;
import tweenx909.EaseX;
import tweenx909.rule.QuakeRuleX;
import tweenxcore.structure.Quake;
using tweenx909.TweenX;
using tweenx909.ChainX;

class Main extends Sprite {
    public static inline var HEIGHT     = 512 - 72;
    public static inline var WIDTH         = 720;
    public static inline var BACK_COLOR = 0x000000;

    var font:Font;
    var format:TextFormat;
    var formatTheme:TextFormat;
    var formatBlack:TextFormat;
    var body:Sprite;
    var tween:TweenX;
    var tfList:Array<TextField>;
    var player:TweenXPlayer;

    public function new() {
        //Init
        super();

        TweenX.updateMode = UpdateModeX.MANUAL;

        //Layer
        addChild(new Bitmap(new BitmapData(WIDTH, HEIGHT, false,BACK_COLOR))).y = HEIGHT + TweenXPlayer.HEIGHT;
        addChild(new Bitmap(new BitmapData(WIDTH, HEIGHT, false, BACK_COLOR)));
        var back    = addChild(new Bitmap(new BitmapData(WIDTH, HEIGHT, false, 0xFFFFFF)));
        back.alpha  = 0;
        addChild(body = new Sprite());


        //TextField
        font        = Assets.getFont("assets/font/Pixcell.ttf");
        tfList = [];
        var tf0 = addTextField("HA E", format = new TextFormat(font.fontName, 64, 0xFFFFFF));
        var tf1 = addTextField("  X ", formatTheme = new TextFormat(font.fontName, 64, 0xFF2200));
        var tf2 = addTextField('Has A " " insidE',format);
        var tf3 = addTextField("       X        ",formatTheme);
        var tf4 = addTextField("tween ", format);
        var tf5 = addTextField("the e iting library", format);
        var tf6 = addTextField("     X             ", formatTheme);
        var tf7 = addTextField("enjoy it!!", formatBlack = new TextFormat(font.fontName, 64, 0x000000));


        //Value
        var centerY = (HEIGHT - tf0.height) / 2;
        var bottomY = (HEIGHT - 100 - tf0.height);
        tf7.from().y(centerY).play();


        var defaults = TweenX.dumpDefaults();
        defaults.time(2);

        //Tween
        tween = [

            //HAXE
            [tf0, tf1].to()
                .alpha(0.4)
                .y(centerY)
                .ease(EaseX.bounceOut),

            TweenX.wait(1),

            [tf0,tf1].to()
                .alpha(1)
                .time(0.05)
                .yoyo()
                .repeat(7)
                .ease(EaseX.quartOut),

            //Has A X insideE
            TweenX.wait(1),

            [
                [tf0, tf1].to()
                    .y(bottomY)
                    .alpha(0)
                    .ease(EaseX.expoOut),

                [tf2, tf3].to()
                    .y(centerY)
                    .alpha(1)
                    .ease(EaseX.expoOut),

            ].parallel(),

            //tweenX
            TweenX.wait(1),

            [
                tf2.to().alpha(0),

                [
                    tf3.to()
                        .x((WIDTH - tf3.width) / 2 + tf3.width * 3 / 14)
                        .ease(EaseX.quintOut),

                    tf4.to()
                        .y((HEIGHT - tf0.height) / 2)
                        .alpha(1)

                ].parallel()

            ].lag(1, defaults.clone().ease(EaseX.backOut)),

            body.to({ "x":new Quake(0,80,EaseX.quintIn), "y":new Quake(0,80,EaseX.quintIn) }).time(4),

            TweenX.wait(1),

            //the exciting library
            [
                [tf3, tf4].to().alpha(0).y(bottomY),
                [tf5, tf6].to().alpha(1).y(centerY)

            ].parallel(defaults.clone().ease(EaseX.sineIn)),

            [
                back.to().alpha(1).time(4),
                [tf5, tf6].to().alpha(0).time(4)

            ].lag(2, defaults.clone().ease(EaseX.expoIn)),

            //enjoy it!!
            tf7.to().alpha(1).ease(EaseX.expoIn),

            TweenX.wait(1)

        ].serial(defaults).play();

        addChildAt(player = new TweenXPlayer(tween, WIDTH), 0).y = HEIGHT;
        addEventListener("enterFrame", onFrame);
        onFrame(null);
    }

    public function addTextField(str:String, format:TextFormat) {
        var tf = new TextField();
        tf.embedFonts = true;
        tf.defaultTextFormat = format;
        setTextField(tf, str);

        tf.y             = 100;
        tf.alpha        = 0;
        tf.selectable   = false;
        body.addChild(tf);
        tfList.push(tf);
        return tf;
    }

    public function setTextField(tf:TextField, str:String) {
        tf.text         = str;
        tf.width        = tf.textWidth;
        tf.height        = tf.textHeight * 1.3;
        tf.x             = (WIDTH - tf.width) / 2;
    }

    public function onFrame(e) { TweenX.manualUpdate(1/60); }
}
