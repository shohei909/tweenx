package core.output;
import core.ApplyResult;
import haxe.Json;
import haxe.macro.Printer;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.ComplexEasingKindTools;

class OutputManager 
{
	public var mode(default, null):OutputMode;
	private var context:GlobalContext;
	
	public function new(context:GlobalContext) 
	{
		this.context = context;
		this.mode = OutputMode.Json;
	}
	
	public function getString():String
	{
		var easing = context.easing.current;
		return switch (mode)
		{
			case OutputMode.Json:
				Json.stringify(
					ComplexEasingKindTools.toJsonable(easing),
					null
				);
				
			case OutputMode.Haxe:
				var print = new Printer();
				var bodyExpr = ComplexEasingKindTools.toExpr(easing, macro value);
				print.printExpr(
					macro function customEase(value:Float):Void
					{
						$bodyExpr;
					}
				);
		}
	}
	
	public function changeMode(newMode:OutputMode, result:ApplyResult):Void
	{
		mode = newMode;
	}
}
