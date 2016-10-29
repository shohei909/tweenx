package core.easing;
import component.basic.RateId;
import component.complex.ComplexEasingId;
import core.GlobalCommand;
import core.easing.EasingManager;
import haxe.ds.Option;
import tweenxcore.expr.BinaryOpKind;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.InOutKind;
import tweenxcore.expr.SimpleEasingKind;
import tweenxcore.expr.TernaryOpKind;
import tweenxcore.expr.UnaryOpKind;

class EasingManager 
{
	public var current(default, null):ComplexEasingKind;
	private var context:GlobalContext;
	
	public function new(context:GlobalContext) 
	{
		this.context = context;
		this.current = ComplexEasingKind.Simple(SimpleEasingKind.Linear);
	}
	
	// ------------------------------------------
	// Resolve
	// ------------------------------------------
	public function resolveEasing(id:ComplexEasingId):Option<ComplexEasingKind>
	{
		return _resolveEasing(current, id);
	}
	
	private static function _resolveEasing(easing:ComplexEasingKind, id:ComplexEasingId):Option<ComplexEasingKind>
	{
		if (id.isEmpty())
		{
			return Option.Some(easing);
		}
		
		return switch [easing, id.current()]
		{
			case [ComplexEasingKind.Op(easing, _), 0]:
				_resolveEasing(easing, id.child());
				
			case [ComplexEasingKind.Op(_, Op(easing, _)), 1]:
				_resolveEasing(easing, id.child());
				
			case [ComplexEasingKind.Op(_, Op(_, Op(easing, _))), 2]:
				_resolveEasing(easing, id.child());
				
			case [_, _]:
				Option.None;
		}
	}
	
	// ------------------------------------------
	// Change
	// ------------------------------------------
	public function changeEasing(id:ComplexEasingId, easing:ComplexEasingKind, result:ApplyResult):Void
	{
		var prev = current;
		var next = _changeEasing(prev, id, easing);
		
		if (!prev.equals(next))
		{
			result.addUndoCommand(GlobalCommand.ChangeEasing(ComplexEasingId.root(), prev));
			current = next;
		}
	}
	
	public function changeInOut(id:ComplexEasingId, inOut:InOutKind, result:ApplyResult):Void
	{
		switch (resolveEasing(id))
		{
			case Option.Some(ComplexEasingKind.Simple(SimpleEasingKind.Standard(easing, _))):
				changeEasing(id, ComplexEasingKind.Simple(SimpleEasingKind.Standard(easing, inOut)), result);
				
			case _:
		}
	}
	
	public function changeRate(id:RateId, value:Float, result:ApplyResult):Void
	{
		switch (resolveEasing(id.parent()))
		{
			case Option.Some(oldEasing):
				var newEasing:ComplexEasingKind = switch [oldEasing, id.rateIndex()] 
				{
					case [Simple(SimpleEasingKind.Bezier(controls)), _]:
						if (controls[id.rateIndex()] != value)
						{
							var newControls = controls.slice(0);
							newControls[id.rateIndex()] = value;
							Simple(SimpleEasingKind.Bezier(newControls));
						}
						else
						{
							oldEasing;
						}
						
					case [Op(easing1, UnaryOpKind.Lerp(_, max)), 0]:
						Op(easing1, UnaryOpKind.Lerp(value, max));
						
					case [Op(easing1, UnaryOpKind.Lerp(min, _)), 1]:
						Op(easing1, UnaryOpKind.Lerp(min, value));
						
					case [Op(easing1, UnaryOpKind.Clamp(_, max)), 0]:
						Op(easing1, UnaryOpKind.Clamp(value, max));
						
					case [Op(easing1, UnaryOpKind.Clamp(min, _)), 1]:
						Op(easing1, UnaryOpKind.Clamp(min, value));
						
					case [Op(easing1, UnaryOpKind.Repeat(_)), 0]:
						Op(easing1, UnaryOpKind.Repeat(value));
						
					case [Op(easing1, Op(easing2, BinaryOpKind.Mix(_))), 0]:
						Op(easing1, Op(easing2, BinaryOpKind.Mix(value)));
						
					case [Op(easing1, Op(easing2, BinaryOpKind.Connect(_, _value))), 0]:
						Op(easing1, Op(easing2, BinaryOpKind.Connect(value, _value)));
						
					case [Op(easing1, Op(easing2, BinaryOpKind.Connect(time, _))), 1]:
						Op(easing1, Op(easing2, BinaryOpKind.Connect(time, value)));
						
					case [Op(easing1, Op(easing2, BinaryOpKind.OneTwo(_))), 0]:
						Op(easing1, Op(easing2, BinaryOpKind.OneTwo(value)));
						
					case [Op(easing1, Op(easing2, Op(easing3, TernaryOpKind.Crossfade(_, max)))), 0]:
						Op(easing1, Op(easing2, Op(easing3, TernaryOpKind.Crossfade(value, max))));
						
					case [Op(easing1, Op(easing2, Op(easing3, TernaryOpKind.Crossfade(min, _)))), 1]:
						Op(easing1, Op(easing2, Op(easing3, TernaryOpKind.Crossfade(min, value))));
						
					case [_, _]:
						oldEasing;
				}
				
				changeEasing(id.parent(), newEasing, result);
				
			case Option.None:
		}
	}
	
	private static function _changeEasing(baseEasing:ComplexEasingKind, id:ComplexEasingId, easing:ComplexEasingKind):ComplexEasingKind
	{
		if (id.isEmpty())
		{
			return easing;
		}
		
		return switch [baseEasing, id.current()]
		{
			case [Op(easing1, op), 0]:
				Op(_changeEasing(easing1, id.child(), easing), op);
				
			case [Op(easing1, Op(easing2, op)), 1]:
				Op(easing1, Op(_changeEasing(easing2, id.child(), easing), op));
				
			case [Op(easing1, Op(easing2,  Op(easing3, op))), 2]:
				Op(easing1, Op(easing2, Op(_changeEasing(easing3, id.child(), easing), op)));
				
			case [_, _]:
				baseEasing;
		}
	}
}