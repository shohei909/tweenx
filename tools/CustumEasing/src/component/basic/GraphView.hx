package component.basic;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import js.html.CanvasElement;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ComplexEasingKindTools;

class GraphView extends ReactComponentOfProps<GraphProps>
{
	public static var MARGIN:Float = 30;
	public static var WIDTH:Float = 120;
	public static var HEIGHT:Float = 140;
	
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
		var top = MARGIN;
		var left = 0;
		var right = WIDTH - 0;
		var bottom = HEIGHT - MARGIN;
		ctx.clearRect(0, 0, WIDTH, HEIGHT);
		ctx.strokeStyle = "#BBB";
		
		// frame
		ctx.beginPath();
		ctx.moveTo(left, 0);
		ctx.lineTo(left, HEIGHT);
		ctx.stroke();
		ctx.beginPath();
		ctx.moveTo(right, 0);
		ctx.lineTo(right, HEIGHT);
		ctx.stroke();
		ctx.beginPath();
		ctx.moveTo(0, top);
		ctx.lineTo(WIDTH, top);
		ctx.stroke();
		ctx.beginPath();
		ctx.moveTo(0, bottom);
		ctx.lineTo(WIDTH, bottom);
		ctx.stroke();
		
		for (line in props.lines)
		{
			ctx.strokeStyle = switch (line.color)
			{
				case Theme:
					"#11B";
					
				case Sub:
					"#B11";
			}
			
			var func = ComplexEasingKindTools.toFunction(line.easing);
			ctx.beginPath();
			ctx.moveTo(left, func(0).lerp(bottom, top));
			var len = Math.floor(WIDTH - MARGIN * 2);
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
    }
	
		
	override public function render():ReactComponent
	{
		return React.createElement(
			"div",
			{ class_name: "graph" },
			React.createElement("canvas", { ref: "canvas", width: WIDTH, height: HEIGHT })
		);
	}
}

typedef GraphProps =
{
	lines: Array<GraphLine>,
}

typedef GraphLine = 
{
	color: GraphColor,
	easing: ComplexEasingKind,
}

enum GraphColor
{
	Theme;
	Sub;
}