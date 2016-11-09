package;
import js.html.Image;
import sample.Sprite;
import sample.context.DrawContext;
import sample.context.Drawable;
import tweenxcore.Tools.Easing;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
import tweenxcore.structure.Timeline;
using tweenxcore.Tools;

class ImageSample extends Sprite { 
    public static var TOTAL_FRAME:Int = 1000;
    private var frameCount:Int = 0;
    private var image:FaceImage;
    private var timeline:Timeline<Int>;
    
    public function new() {
        super();
        
        addChild(image = new FaceImage());
        timeline = new Timeline();
        timeline.add(0, 0.5);
        for (i in 1...16) {
            timeline.add(i);
        }
        timeline.add(0, 0.5);
    }

    private function update() {
        var change = new FloatChange(frameCount, frameCount += 1);
        change.handleRepeatPart(0, 100, 10, updatePart);
    }

    private function updatePart(part:FloatChangePart) {
        var curve = part.current.mixEasing(
            Easing.linear, 
            FloatTools.connectEasing.bind(_, Easing.quadInOut, Easing.quadInOut), 
            0.5
        );
        image.index = timeline.search(curve).data;
    }
}


private class FaceImage implements Drawable
{
    private var image:Image;
    private static var WIDTH:Int  = 96;
    private static var HEIGHT:Int = 96;
    public var index:Int = 0;
    
    public function new ()
    {
        image = new Image();
        image.src = "/images/character.png";
    }
    
    
    public function draw(context:DrawContext):Void
    {
        context.context.drawImage(image, WIDTH * index, 0, WIDTH, HEIGHT, 0, 0, WIDTH, HEIGHT);
    }
}
