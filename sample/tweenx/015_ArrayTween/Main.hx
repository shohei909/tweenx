import flash.display.GradientType;
import flash.display.InterpolationMethod;
import flash.display.SpreadMethod;
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.StageScaleMode;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.Lib;
import tweenx909.rule.HsvRuleX;
import tweenxcore.color.HsvColor;

import tweenx909.TweenX;
import tweenx909.EaseX;
using tweenx909.ChainX;

class Main extends Sprite {
    public static inline var CELL_SIZE = 20;

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

        var dump = TweenX.dumpDefaults();

        //Make square
        var square = new GradientSquare(
            [ 0x2C3E50, 0xE74C3C,    0xECF0F1,     ],
            [ 0,         0.5,        1,             ],
            [ 0,         64,         255,          ]
        );
        addChild(square);
        square.x = square.y = CELL_SIZE * 6;

        //Tween!!
        TweenX.to(square,
                {
                    colors:[ HsvColor.of(0x08A689),    HsvColor.of(0xC7D93D),        HsvColor.of(0xE9F2A0)     ],
                    alphas:[ 1,                      0,                          0.5,                 ],
                    ratios:[ 0,                      192,                      255,                 ]
                }).time(2).ease(EaseX.expoInOut).onUpdate(square.update);

    }
}

private class GradientSquare extends Shape{
    public var colors:Array<UInt>;
    public var alphas:Array<Float>;
    public var ratios:Array<Float>;

    public function new(colors:Array<UInt>, alphas:Array<Float>, ratios:Array<Float>) {
        super();
        this.colors = colors;
        this.alphas = alphas;
        this.ratios = ratios;
        update();
    }

    public function update() {
        var size = Main.CELL_SIZE * 8;
        var mtr = new Matrix();
        mtr.createGradientBox(size, size, 0);
        graphics.clear();
        graphics.beginGradientFill(GradientType.RADIAL, colors, alphas, ratios, mtr, null, InterpolationMethod.RGB);
        graphics.drawRect(0, 0, size, size);
    }
}
