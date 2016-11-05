package component.basic;
import api.react.React;
import api.react.ReactComponent;
import component.basic.NumberInputId;
import core.RootContext;
import core.drag.DragStateKind;
import haxe.ds.Option;
import js.Browser;
import js.html.CanvasElement;
import js.html.MouseEvent;
import tweenxcore.expr.ComplexEasingKindTools;

class NumberSliderView extends ReactComponentOfProps<NumberSliderProps>
{
	public static var WIDTH:Float = 160;
	public static var HEIGHT:Float = 30;
	public static var BAR_WIDTH:Float = 140;
	public static var BAR_HEIGHT:Float = 4;
	
	public function new(props:NumberSliderProps) 
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
		ctx.clearRect(0, 0, WIDTH, HEIGHT);
		ctx.strokeStyle = "#BBB";
		ctx.fillStyle = "#DEDEDE";
		
		var centerValue, cursorValue;
		
		switch (props.context.drag.stateKind)
		{
			case Option.Some(DragStateKind.NumberSlider(detail)) if (detail.id.equals(props.id)):
				centerValue = detail.centerValue;
				cursorValue = detail.getCurrentValue();
				if (cursorValue < centerValue - 1)
				{
					centerValue = cursorValue + 1;
				}
				else if (centerValue + 1 < cursorValue)
				{
					centerValue = cursorValue - 1;
				}
				
			case _:
				centerValue = props.value;
				cursorValue = props.value;
		}
		
		// bar
		{
			inline function rect(left:Float, top:Float, right:Float, bottom:Float):Void
			{
				ctx.fillRect(left, top, right - left, bottom - top);
			}
			
			var top = (HEIGHT - BAR_HEIGHT) / 2;
			var left = (WIDTH - BAR_WIDTH) / 2;
			var right = (WIDTH + BAR_WIDTH) / 2;
			var bottom = (HEIGHT + BAR_HEIGHT) / 2;
			
			var low = mod(-centerValue, 2) / 2;
			var high = mod(1 - centerValue, 2) / 2;
			if (high < low)
			{
				rect(left, top, high.lerp(left, right), bottom);
				rect(low.lerp(left, right), top, right, bottom);
			}
			else
			{
				rect(low.lerp(left, right), top, high.lerp(left, right), bottom);
			}
			ctx.strokeRect(left, top, BAR_WIDTH, BAR_HEIGHT);
			
			// cursor
			var cursor = (cursorValue - (centerValue - 1)) / 2;
			ctx.beginPath();
			ctx.arc(
				cursor.lerp(left, right),
				(bottom + top) / 2, 
				6, 
				0, 
				Math.PI * 2, 
				false
			);
			ctx.fill();
			ctx.stroke();
		}
		
		// arrow
    }
	
	private static function mod(a:Float, b:Float):Float
	{
		return a - Math.floor(a / b) * b;
	}
	
	override public function render():ReactComponent
	{
		return React.createElement(
			"canvas", 
			{ 
				ref: "canvas", 
				width: WIDTH, 
				height: HEIGHT,
				onMouseDown: onMouseDown,
			}
		);
	}
	
	private function onMouseDown(e:MouseEvent):Void
	{
		props.context.drag.dragNumberSlider(
			props.id, 
			e.pageX, 
			Browser.window.pageXOffset + (this.refs.canvas:CanvasElement).getBoundingClientRect().left + WIDTH / 2,
			props.value
		);
		
		e.preventDefault();
	}
	
}

typedef NumberSliderProps = 
{
	name: String,
	value: Float,
	id: NumberInputId,
	context: RootContext,
}

