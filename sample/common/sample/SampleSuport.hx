package sample;

import flash.display.BlendMode;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;
import flash.Lib;
import tweenxcore.color.HsvColor;
using tweenxcore.Tools;

class SamplePlayer extends Sprite {
    public static var THEME_COLOR:Int = 0x4EDAE1;
    private var child:Sprite;

    static function drawGrid(graphics:Graphics, size = 15, w = 30, h = 10) {
        //Draw background
        var end = size * w;
        for (i in 0...h + 1) {
            var p = i * size;
            graphics.beginFill(0xF1F1EF, 1);
            graphics.drawRect(0, p, end, 1);
            graphics.endFill();
        }

        var end = size * h;
        for (i in 0...w + 1) {
            var p = i * size;
            graphics.beginFill(0xF1F1EF, 1);
            graphics.drawRect(p, 0, 1, end);
            graphics.endFill();
        }
    }
}

class Square extends Shape {
    public static inline var SIZE:Int = 30;

    public function new() {
        super();
        graphics.beginFill(SamplePlayer.THEME_COLOR);
        graphics.drawRect( -SIZE / 2, -SIZE / 2, SIZE, SIZE);
    }
}

class PlayButton extends Sprite {
    public static inline var SIZE:Int = 33;

    public function new() {
        super();
        var shape = new Shape();
        addChild(shape);

        shape.graphics.beginFill(SamplePlayer.THEME_COLOR);
        shape.graphics.drawCircle(0, 0, SIZE);
        shape.graphics.endFill();

        var side = SIZE * 0.63;

        shape.graphics.beginFill(0xFFFFFF);
        shape.graphics.moveTo(side, 0);
        shape.graphics.lineTo(-side / 2, 0.866 * side);
        shape.graphics.lineTo(-side / 2, -0.866 * side);
        shape.graphics.endFill();

        blendMode = BlendMode.LAYER;
    }
}

class PlayButtonShadow extends Sprite {
    public function new() {
        super();

        var color = HsvColor.of(SamplePlayer.THEME_COLOR);
        color.s = color.s.sineOut();
        color.v = color.v.lerp(0.1, 0.3);

        graphics.beginFill(color.toInt(), 0.4);
        var size = PlayButton.SIZE * 1.1;

        graphics.moveTo(0, -2);
        graphics.lineTo(-size, 0);
        graphics.lineTo(size, 0);

        graphics.endFill();
    }
}
