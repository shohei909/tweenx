import haxe.macro.Format;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.MouseEvent;
import sample.Sprite;
import sample.player.Player;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangeRepeatPart;
import tweenxcore.Tools.Easing;
using tweenxcore.Tools;

class EasingVisualizeSample implements Player {
    private var canvas:CanvasElement;
    
    public static var MOTION_END:Float = 240;
    public static inline var CELL_SIZE = 20;
    public var charts:Array<Chart>;
    public var frameCount:Int;

    public function new(canvas:CanvasElement) {
        this.canvas = canvas;
        this.frameCount = 0;
        
        var eases:Array<Array<Array<Dynamic>>> = [
            [
                [ "linear", Easing.linear ],
            ],
            [
                [ "quadIn",         Easing.quadIn ],
                [ "quadOut",        Easing.quadOut ],
                [ "quadInOut",      Easing.quadInOut ],
                [ "quadOutIn",      Easing.quadOutIn ],
            ],
            [
                [ "cubicIn",        Easing.cubicIn ],
                [ "cubicOut",       Easing.cubicOut ],
                [ "cubicInOut",     Easing.cubicInOut ],
                [ "cubicOutIn",     Easing.cubicOutIn ],
            ],
            [
                [ "quartIn",        Easing.quartIn ],
                [ "quartOut",       Easing.quartOut ],
                [ "quartInOut",     Easing.quartInOut ],
                [ "quartOutIn",     Easing.quartOutIn ],
            ],
            [
                [ "quintIn",        Easing.quintIn ],
                [ "quintOut",       Easing.quintOut ],
                [ "quintInOut",     Easing.quintInOut ],
                [ "quintOutIn",     Easing.quintOutIn ],
            ],
            [
                [ "sineIn",         Easing.sineIn ],
                [ "sineOut",        Easing.sineOut ],
                [ "sineInOut",      Easing.sineInOut ],
                [ "sineOutIn",      Easing.sineOutIn ],
            ],
            [
                [ "circIn",         Easing.circIn ],
                [ "circOut",        Easing.circOut ],
                [ "circInOut",      Easing.circInOut ],
                [ "circOutIn",      Easing.circOutIn ],
            ],
            [
                [ "expoIn",         Easing.expoIn ],
                [ "expoOut",        Easing.expoOut ],
                [ "expoInOut",      Easing.expoInOut ],
                [ "expoOutIn",      Easing.expoOutIn ],
            ],
            [
                [ "backIn",         Easing.backIn ],
                [ "backOut",        Easing.backOut ],
                [ "backInOut",      Easing.backInOut ],
                [ "backOutIn",      Easing.backOutIn ],
            ],
            [
                [ "bounceIn",       Easing.bounceIn ],
                [ "bounceOut",      Easing.bounceOut ],
                [ "bounceInOut",    Easing.bounceInOut ],
                [ "bounceOutIn",    Easing.bounceOutIn ],
            ],
            [
                [ "elasticIn",      Easing.elasticIn ],
                [ "elasticOut",     Easing.elasticOut ],
                [ "elasticInOut",   Easing.elasticInOut ],
                [ "elasticOutIn",   Easing.elasticOutIn ],
            ],
            [
                [ "warpIn",         Easing.warpIn ],
                [ "warpOut",        Easing.warpOut ],
                [ "warpInOut",      Easing.warpInOut ],
                [ "warpOutIn",      Easing.warpOutIn ],
            ],
        ];

        var y = CELL_SIZE, i = 0, sx =  CELL_SIZE * 0.5;
        charts = [];

        for (arr in eases) {
            var x = sx;
            for (e in arr) {
                var chart = new Chart(x, y, e[0], e[1], canvas.getContext2d());
                charts.push(chart);

                x += CELL_SIZE * 4.5;
            }

            if (++i % 6 == 0) {
                y = CELL_SIZE;
                sx = CELL_SIZE * ((4.5 * 4 + 1) * (i / 6) + 0.5);
            } else {
                y += CELL_SIZE * 4;
            }
        }
        
        frameCount = 120;
        updatePart(new FloatChange(0, 1));
    }

    public function update() {
        var change = new FloatChange(frameCount, frameCount += 1);
        change.handlePart(0, 120, updatePart);
    }

    private function updatePart(change:FloatChange) {
        var curvedChange = change.mapFloatChange(Easing.cubicInOut);
        var body = 0.3;
        var margin = 1 - body;
        var length = charts.length;

        for (i in 0...length) {
            var start = (i / (length - 1)).lerp(0, margin);
            curvedChange.handlePart(start, start + body, charts[i].update);
        }
    }
    
    public function onClick():Void {
        var context = canvas.getContext2d();
        context.clearRect(0, 0, canvas.width, canvas.height);
        frameCount = 0;
        
        for (chart in charts) {
            chart.init();
        }
    }
    
    public function onMouseMove(e:MouseEvent):Void {}
}

private class Chart {
    private var title:String;
    public var easing:Float->Float;
    public static inline var H:Float = EasingVisualizeSample.CELL_SIZE * 3;
    public static inline var W:Float = EasingVisualizeSample.CELL_SIZE * 4;
    
    private var repeat = 128;
    private var prevRate:Float = 0;
    private var context:CanvasRenderingContext2D;
    private var y:Float;
    private var x:Float;
    
    public function new(x:Float, y:Float, title:String = "ease", easing:Float->Float, context:CanvasRenderingContext2D) {
        this.x = x;
        this.y = y;
        this.context = context;
        this.title = title;
        this.easing = easing;
        init();
    }
    
    public function init():Void {
        context.fillStyle = "#EEEEEE";
        
        var end = EasingVisualizeSample.CELL_SIZE * 4;
        for (i in 0...4) {
            var p = i * EasingVisualizeSample.CELL_SIZE;
            context.fillRect(x, y + p, end, 1);
        }
        
        var end = EasingVisualizeSample.CELL_SIZE * 3;
        for (i in 0...5) {
            var p = i * EasingVisualizeSample.CELL_SIZE;
            context.fillRect(x + p, y, 1, end);
        }
        
        context.fillStyle = "#666666";
        context.font = "12px monospace";
        context.fillText(title, x, y - 1);
        prevRate = 0;
    }

    public function update(change:FloatChange) {
        change.handleRepeatPart(0, 1 / repeat, repeat, updatePart);
    }

    public function updatePart(change:FloatChangeRepeatPart) {
        if (change.isExit()) {
            var index = change.repeatIndex;
            var rate = easing((change.current + index) / change.repeatLength);
            
            context.strokeStyle = Style.DARKEN_THEME_COLOR.toRgbCssString();
            context.lineWidth = 1;
            
            context.beginPath();
            context.moveTo(x + W * index / repeat, y + H * (1 - prevRate));
            context.lineTo(x + W * ((index + 1) / repeat), y + H * (1 - rate));
            context.stroke();
            
            prevRate = rate;
        }
    }
}
