package core;
import component.basic.RateId;
import core.animation.AnimationManager;
import haxe.ds.Option;
import component.complex.ComplexEasingId;
import core.focus.FocusManager;
import js.Browser;
import js.Lib;
import tweenxcore.expr.BinaryOpKind;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.SimpleEasingKind;
import tweenxcore.expr.TernaryOpKind;
import tweenxcore.expr.UnaryOpKind;

class GlobalContext 
{
	public var focus(default, null):FocusManager;
	public var animation(default, null):AnimationManager;
	
	private var application:Application;
	
	public function new() 
	{
		focus = new FocusManager(this);
		animation = new AnimationManager();
		Browser.window.setTimeout(onFrame, 16);
	}
	
	private function onFrame():Void
	{
		animation.onFrame();
		Browser.window.setTimeout(onFrame, 16);
	}
	
	public function setup(application:Application):Void
	{
		this.application = application;
	}
	
	public function update():Void
	{
		application.forceUpdate();	
	}
	
	public function resolveEasing(id:ComplexEasingId):Option<ComplexEasingKind>
	{
		return _resolveEasing(application.props.easing, id);
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
	
	public function updateEasing(id:ComplexEasingId, easing:ComplexEasingKind):Void
	{
		application.props.easing = _updateEasing(application.props.easing, id, easing);
		update();
	}
	
	public function updateRate(id:RateId, value:Float) 
	{
		switch (resolveEasing(id.parent()))
		{
			case Option.Some(oldEasing):
				var newEasing:ComplexEasingKind = switch [oldEasing, id.rateIndex()] 
				{
					case [Simple(SimpleEasingKind.Bezier(controls)), _]:
						controls[id.rateIndex()] = value;
						Simple(SimpleEasingKind.Bezier(controls));
						
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
				
				updateEasing(id.parent(), newEasing);
				
			case Option.None:
		}
	}
	
	
	private static function _updateEasing(baseEasing:ComplexEasingKind, id:ComplexEasingId, easing:ComplexEasingKind):ComplexEasingKind
	{
		if (id.isEmpty())
		{
			return easing;
		}
		
		return switch [baseEasing, id.current()]
		{
			case [Op(easing1, op), 0]:
				Op(_updateEasing(easing1, id.child(), easing), op);
				
			case [Op(easing1, Op(easing2, op)), 1]:
				Op(easing1, Op(_updateEasing(easing2, id.child(), easing), op));
				
			case [Op(easing1, Op(easing2,  Op(easing3, op))), 2]:
				Op(easing1, Op(easing2, Op(_updateEasing(easing3, id.child(), easing), op)));
				
			case [_, _]:
				baseEasing;
		}
	}
}
