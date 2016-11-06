package sample;
import sample.context.DrawContext;
import sample.context.Drawable;

class Sprite implements Drawable {
    private var children:Array<Drawable>;
    
    public function new() {
        children = [];
    }
    
    public function addChild(child:Drawable):Void {
        children.push(child);
    }
    
    public function draw(context:DrawContext):Void {
        for (child in children) {
            child.draw(context);
        }
    }
}
