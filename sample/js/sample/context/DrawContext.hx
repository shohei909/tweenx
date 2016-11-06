package sample.context;
import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;

class DrawContext 
{
    public var context(default, null):CanvasRenderingContext2D;
    public var canvas(default, null):CanvasElement;

    public function new(canvas:CanvasElement, context:CanvasRenderingContext2D) 
    {
        this.context = context;
        this.canvas = canvas;
    }
}