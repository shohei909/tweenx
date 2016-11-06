package sample.player;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import sample.context.DrawContext;
import sample.context.Updatable.SampleSprite;
import tweenxcore.color.HsvColor;
using tweenxcore.Tools;

class ClickToPlaySamplePlayer implements Player {
    private var state:PlayerState;
    
    private var clazz:Class<Dynamic>;
    private var totalFrame:Int;
    private var context:CanvasRenderingContext2D;
    private var canvas:CanvasElement;
    
    public function new(canvas:CanvasElement, clazz:Class<Dynamic>, totalFrame:Int) {
        this.totalFrame = totalFrame + Style.DELAY_FRAME;
        this.clazz = clazz;
        this.canvas = canvas;
        this.context = canvas.getContext2d();
        
        enterStay();
    }
    
    public function onClick():Void {
        switch (state) {
            case PlayerState.Stay | PlayerState.Finishing(_):
                enterStarting();
                
            case PlayerState.Starting(_) | PlayerState.Playing(_):
                enterPlaying();
        }
    }
    
    public function update():Void {
        switch (state) {
            case PlayerState.Starting(frame):
                if (frame < Style.START_FRAME) {
                    drawStay((1 - Style.startEasing(frame / Style.START_FRAME)));
                    state = PlayerState.Starting(frame + 1);
                } else {
                    enterPlaying();
                }
                
            case PlayerState.Finishing(frame):
                if (frame < Style.FINISH_FRAME) {
                    drawStay(Style.finishEasing(frame / Style.FINISH_FRAME));
                    state = PlayerState.Finishing(frame + 1);
                } else {
                    enterStay();
                }
                
            case PlayerState.Playing(frame, child):
                if (frame < totalFrame) {
                    child.update();
                    clear();
                    drawGrid();
                    
                    var drawContext = new DrawContext(canvas, context);
                    child.draw(drawContext);
                    state = PlayerState.Playing(frame + 1, child);
                } else {
                    enterFinishing();
                }
                
            case PlayerState.Stay:
        }
    }
    
    private function enterFinishing() {
        changeState(PlayerState.Finishing(0));
    }
    
    private function enterStarting():Void {
        changeState(PlayerState.Starting(0));
    }
    
    private function enterStay():Void {
        changeState(PlayerState.Stay);
        drawStay(1.0);
    }
    private function enterPlaying() {
        changeState(PlayerState.Playing(0, Type.createInstance(clazz, [])));
    }
    
    private function drawStay(rate:Float):Void {
        clear();
        drawGrid();
        drawButton(rate);
    }
    
    private function changeState(newState:PlayerState) {
        state = newState;
    }
    
    private function clear():Void {
        context.clearRect(0, 0, canvas.width, canvas.height);
    }
    
    private function drawGrid():Void {
        context.fillStyle = Style.GRID_COLOR.toRgbCssString();
        
        for (i in 0...Math.ceil(canvas.width / Style.GRID_SCALE)) {
            context.fillRect(i * Style.GRID_SCALE, 0, 1, canvas.height);
        }
        for (i in 0...Math.ceil(canvas.height / Style.GRID_SCALE)) {
            context.fillRect(0, i * Style.GRID_SCALE, canvas.width, 1);
        }
    }
    
    private function drawButton(rate:Float):Void {
        context.fillStyle = Style.THEME_COLOR.toRgbCssString();
        
        var size = Style.BUTTON_SIZE * rate.lerp(0.2, 1);
        var centerX = canvas.width / 2;
        var centerY = canvas.height / 2;
        context.beginPath();
        context.arc(centerX, centerY, size, 0, Math.PI * 2);
        context.fill();
        
        var side = size * 0.63;
        context.fillStyle = "#FFFFFF";
        context.beginPath();
        context.moveTo(centerX + side,     centerY );
        context.lineTo(centerX - side / 2, centerY + 0.866 * side);
        context.lineTo(centerX - side / 2, centerY - 0.866 * side);
        context.fill();
        
        
        var color = Style.THEME_COLOR.toHsv().toAhsv(0.4);
        color.s = color.s.sineOut();
        color.v = color.v.lerp(0.1, 0.3);

        context.fillStyle = color.toRgbaCssString();
        
        var height = canvas.height;
        var size = size * 1.1;
        context.beginPath();
        context.moveTo(centerX,        height - 2);
        context.lineTo(centerX - size, height);
        context.lineTo(centerX + size, height);
        context.fill();
    }
}

private enum PlayerState {
    Stay;
    Starting(frame:Int);
    Playing(frame:Int, child:SampleSprite);
    Finishing(frame:Int);
}
