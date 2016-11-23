package component.basic;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import js.html.CanvasElement;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ComplexEasingKindTools;

class GraphView extends ReactComponentOfProps<GraphProps>
{
	public static var WIDTH:Float = 180;
	public static var HEIGHT:Float = 120;
	
	public function new(props:GraphProps) 
	{
		super(props);
	}
	
	override function componentDidMount():Void 
	{
		draw();
	}
	
	override function componentDidUpdate(prevProps, prevState:Dynamic):Void 
	{
		draw();
	}
	
	private function draw():Void
	{
		var ctx = (this.refs.canvas:CanvasElement).getContext2d();
        var w = WIDTH * props.scale;
        var h = HEIGHT * props.scale;
		var len = Math.floor(w);
        var min = 0.0;
        var max = 1.0;
        
		for (line in props.lines)
		{
			var func = line.easing;
			for (i in 1...len + 1)
			{
                var value = 1 - func(i / len);
                if (value < min)
                {
                    min = value;
                } else if (max < value)
                {
                    max = value;
                }
            }
        }
        
		var top = h * -min / (max - min);
		var left = 0;
		var right = w - 0;
		var bottom = h * (1 - min) / (max - min);
        ctx.clearRect(0, 0, w, h);
		ctx.strokeStyle = "#BBB";
		
		// frame
		ctx.beginPath();
		ctx.moveTo(left, 0);
		ctx.lineTo(left, h);
		ctx.stroke();
		ctx.beginPath();
		ctx.moveTo(right, 0);
		ctx.lineTo(right, h);
		ctx.stroke();
		ctx.beginPath();
		ctx.moveTo(0, top);
		ctx.lineTo(w, top);
		ctx.stroke();
		ctx.beginPath();
		ctx.moveTo(0, bottom);
		ctx.lineTo(w, bottom);
		ctx.stroke();
		
		for (line in props.lines)
		{
			ctx.strokeStyle = line.color.toColorString();
			
			var func = line.easing;
			ctx.beginPath();
			ctx.moveTo(left, func(0).lerp(bottom, top));
			for (i in 1...len + 1)
			{
				var rate = i / len;
				ctx.lineTo(
					rate.lerp(left, right), 
					func(rate).lerp(bottom, top)
				);
			}
			ctx.stroke();
		}
        
		for (partation in props.partations)
		{
			ctx.strokeStyle = GraphColor.Sub.toColorString();
			
			ctx.beginPath();
			ctx.moveTo(left + partation * w, top);
			ctx.lineTo(left + partation * w, bottom);
			ctx.stroke();
		}
        
    }
	
		
	override public function render():ReactComponent
	{
        var w = WIDTH * props.scale;
        var h = HEIGHT * props.scale;
        
		return React.createElement(
			"div",
			{ class_name: "graph" },
			React.createElement("canvas", { ref: "canvas", width: w, height: h })
		);
	}
}

typedef GraphProps =
{
	lines: Array<GraphLine>,
    partations: Array<Float>,
    scale: Float,
}
