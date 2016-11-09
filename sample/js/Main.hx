package;
import js.Browser;
import js.html.CanvasElement;
import sample.player.ClickToPlaySamplePlayer;
import sample.player.Player;

class Main {
    private static var players:Array<Player>;
    
    public static function main():Void {
        players = [];
        
        attach(CustomEasingSample,    481, 151, ClickToPlay);
        attach(SimplestSample,        481, 151, ClickToPlay);
        attach(EasingSample,          481, 151, ClickToPlay);
        attach(YoyoSample,            481, 151, ClickToPlay);
        attach(ZigzagSample,          481, 151, ClickToPlay);
        attach(CompositeSample,       481, 151, ClickToPlay);
        attach(MixSample,             481, 151, ClickToPlay);
        attach(CrossfadeSample,       481, 151, ClickToPlay);
        attach(ConnectSample,         481, 151, ClickToPlay);
        attach(OneTwoSample,          481, 151, ClickToPlay);
        attach(CrossOverSample,       481, 151, ClickToPlay);
        attach(FloatChangePartSample, 481, 151, ClickToPlay);
        attach(EntranceExitSample,    481, 151, ClickToPlay);
        attach(RepeatSample,          481, 151, ClickToPlay);
        attach(TimelinePartSample,    481, 151, ClickToPlay);
        attach(XySample,              481, 151, ClickToPlay);
        attach(MatrixSample,          481, 151, ClickToPlay);
        attach(PolarSample,           481, 151, ClickToPlay);
        attach(BezierSample,          481, 151, ClickToPlay);
        attach(HsvSample,             481, 151, ClickToPlay);
        attach(ImageSample,           96, 96, ClickToPlay);
        attach(EasingVisualizeSample, 800, 500, Direct);
        
        Browser.window.setInterval(onFrame, 16);
    }
    
    private static function onFrame():Void {
        for (player in players) {
            player.update();
        }
    }
    
    public static function attach(clazz:Class<Dynamic>, width:Int, height:Int, playMode:PlayMode):Void {
        var name = Type.getClassName(clazz);
        var element = Browser.document.getElementById(name);
        if (element != null && Std.is(element, CanvasElement)) {
            var canvas = cast(element, CanvasElement);
            canvas.width = width;
            canvas.height = height;
            
            switch (playMode)
            {
                case PlayMode.ClickToPlay:
                    var totalFrame = untyped clazz.TOTAL_FRAME;
                    addPlayer(canvas, new ClickToPlaySamplePlayer(canvas, clazz, totalFrame));
                    
                case PlayMode.Direct:
                    addPlayer(canvas, Type.createInstance(clazz, [canvas]));
            }
        }
    }
    
    private static function addPlayer(canvas:CanvasElement, player:Player) {
        players.push(player);
        canvas.addEventListener("click", player.onClick);
    }
}

enum PlayMode {
    ClickToPlay;
    Direct;
}
