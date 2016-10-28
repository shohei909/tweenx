package component.complex;
import component.complex.ComplexEasingCreateContext;
import component.unary.UnaryOpComponent;
import haxe.EnumTools;
import haxe.ds.Option;
import tweenxcore.expr.BinaryOpKind;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.SimpleEasingKind;
import tweenxcore.expr.StandardEasingKind;
import tweenxcore.expr.TernaryOpKind;
import tweenxcore.expr.UnaryOpKind;

class ComplexEasingSelectItem 
{
	public static var items:Array<ComplexEasingSelectItem> = [
		for (constructor in EnumTools.getConstructors(ComplexEasingSelectItemId))
		{
			createItem(EnumTools.createByName(ComplexEasingSelectItemId, constructor));
		}
	];
	
	public var id(default, null):ComplexEasingSelectItemId;
	public var name(default, null):String;	
	public var createEasing(default, null):ComplexEasingCreateContext->ComplexEasingKind;
	
	public function new(id:ComplexEasingSelectItemId, name:String, createEasing:ComplexEasingCreateContext->ComplexEasingKind) 
	{
		this.id = id;
		this.name = name;
		this.createEasing = createEasing;
	}
	
	public static function resolveItemId(easing:ComplexEasingKind):ComplexEasingSelectItemId
	{
		return switch (easing)
		{
			case ComplexEasingKind.Simple(kind):
				switch (kind)
				{
					case SimpleEasingKind.Linear:
						ComplexEasingSelectItemId.Linear;
						
					case SimpleEasingKind.Standard(kind, _):
						switch (kind)
						{
							case Quad:    ComplexEasingSelectItemId.Quad;
							case Cubic:   ComplexEasingSelectItemId.Cubic;
							case Quart:   ComplexEasingSelectItemId.Quart;
							case Quint:   ComplexEasingSelectItemId.Quint;
							case Sine:    ComplexEasingSelectItemId.Sine;
							case Circ:    ComplexEasingSelectItemId.Circ;
							case Expo:    ComplexEasingSelectItemId.Expo;
							case Back:    ComplexEasingSelectItemId.Back;
							case Bounce:  ComplexEasingSelectItemId.Bounce;
							case Elastic: ComplexEasingSelectItemId.Elastic;
							case Warp:    ComplexEasingSelectItemId.Warp;
						}
						
					case SimpleEasingKind.Bezier(_):
						ComplexEasingSelectItemId.Bezier;
				}
			
			case ComplexEasingKind.Op(_, op):
				switch (op)
				{
					case UnaryOpKind.Lerp(_):           ComplexEasingSelectItemId.Lerp;
					case UnaryOpKind.Clamp(_):          ComplexEasingSelectItemId.Clamp;
					case UnaryOpKind.Repeat(_):         ComplexEasingSelectItemId.Repeat;
					case UnaryOpKind.RoundTrip(Yoyo):   ComplexEasingSelectItemId.Yoyo;
					case UnaryOpKind.RoundTrip(Zigzag): ComplexEasingSelectItemId.Zigzag;
						
					case UnaryOpKind.Op(_, op):
						switch (op)
						{
							case BinaryOpKind.Composite:  ComplexEasingSelectItemId.Composite;
							case BinaryOpKind.Multiply:   ComplexEasingSelectItemId.Multiply;
							case BinaryOpKind.Mix(_):     ComplexEasingSelectItemId.Mix;
							case BinaryOpKind.Connect(_): ComplexEasingSelectItemId.Connect;
							case BinaryOpKind.OneTwo(_):  ComplexEasingSelectItemId.OneTwo;
							
							case BinaryOpKind.Op(_, TernaryOpKind.Crossfade(_)):
								ComplexEasingSelectItemId.Crossfade;
						}
				}
		}
	}
	
	public static function getItem(id:ComplexEasingSelectItemId):ComplexEasingSelectItem
	{
		return items[EnumValueTools.getIndex(id)];
	}
	
	public static function createItem(id:ComplexEasingSelectItemId):ComplexEasingSelectItem
	{
		var name = EnumValueTools.getName(id);
		return switch (id)
		{
			case ComplexEasingSelectItemId.Linear:    new ComplexEasingSelectItem(id, name, createLinearEasing);
			case ComplexEasingSelectItemId.Quad:      new ComplexEasingSelectItem(id, name, createStandardEasing.bind(StandardEasingKind.Quad));
			case ComplexEasingSelectItemId.Cubic:     new ComplexEasingSelectItem(id, name, createStandardEasing.bind(StandardEasingKind.Cubic));
			case ComplexEasingSelectItemId.Quart:     new ComplexEasingSelectItem(id, name, createStandardEasing.bind(StandardEasingKind.Quart));
			case ComplexEasingSelectItemId.Quint:     new ComplexEasingSelectItem(id, name, createStandardEasing.bind(StandardEasingKind.Quint));
			case ComplexEasingSelectItemId.Sine:      new ComplexEasingSelectItem(id, name, createStandardEasing.bind(StandardEasingKind.Sine));
			case ComplexEasingSelectItemId.Circ:      new ComplexEasingSelectItem(id, name, createStandardEasing.bind(StandardEasingKind.Circ));
			case ComplexEasingSelectItemId.Expo:      new ComplexEasingSelectItem(id, name, createStandardEasing.bind(StandardEasingKind.Expo));
			case ComplexEasingSelectItemId.Back:      new ComplexEasingSelectItem(id, name, createStandardEasing.bind(StandardEasingKind.Back));
			case ComplexEasingSelectItemId.Bounce:    new ComplexEasingSelectItem(id, name, createStandardEasing.bind(StandardEasingKind.Bounce));
			case ComplexEasingSelectItemId.Elastic:   new ComplexEasingSelectItem(id, name, createStandardEasing.bind(StandardEasingKind.Elastic));
			case ComplexEasingSelectItemId.Warp:      new ComplexEasingSelectItem(id, name, createStandardEasing.bind(StandardEasingKind.Warp));
			case ComplexEasingSelectItemId.Bezier:    new ComplexEasingSelectItem(id, name, createBezierEasing);
			case ComplexEasingSelectItemId.Repeat:    new ComplexEasingSelectItem(id, name, createUnaryOp.bind(UnaryOpKind.Repeat(2)));
			case ComplexEasingSelectItemId.Lerp:      new ComplexEasingSelectItem(id, name, createUnaryOp.bind(UnaryOpKind.Lerp(0, 1)));
			case ComplexEasingSelectItemId.Clamp:     new ComplexEasingSelectItem(id, name, createUnaryOp.bind(UnaryOpKind.Clamp(0, 1)));
			case ComplexEasingSelectItemId.Yoyo:      new ComplexEasingSelectItem(id, name, createUnaryOp.bind(UnaryOpKind.RoundTrip(Yoyo)));
			case ComplexEasingSelectItemId.Zigzag:    new ComplexEasingSelectItem(id, name, createUnaryOp.bind(UnaryOpKind.RoundTrip(Zigzag)));
			case ComplexEasingSelectItemId.Composite: new ComplexEasingSelectItem(id, name, createBinaryOp.bind(BinaryOpKind.Composite));
			case ComplexEasingSelectItemId.Multiply:  new ComplexEasingSelectItem(id, name, createBinaryOp.bind(BinaryOpKind.Multiply));
			case ComplexEasingSelectItemId.Mix:       new ComplexEasingSelectItem(id, name, createBinaryOp.bind(BinaryOpKind.Mix(0.5)));
			case ComplexEasingSelectItemId.Connect:   new ComplexEasingSelectItem(id, name, createBinaryOp.bind(BinaryOpKind.Connect(0.5, 0.5)));
			case ComplexEasingSelectItemId.OneTwo:    new ComplexEasingSelectItem(id, name, createBinaryOp.bind(BinaryOpKind.OneTwo(0.5)));
			case ComplexEasingSelectItemId.Crossfade: new ComplexEasingSelectItem(id, name, createTernaryOp.bind(TernaryOpKind.Crossfade(0, 1)));
		}
	}
	
	
	
	public static function createLinearEasing(context:ComplexEasingCreateContext):ComplexEasingKind
	{
		return ComplexEasingKind.Simple(Linear);
	}
	
	public static function createStandardEasing(easing:StandardEasingKind, context:ComplexEasingCreateContext):ComplexEasingKind
	{
		return ComplexEasingKind.Simple(SimpleEasingKind.Standard(easing, context.getInOut()));
	}
	
	public static function createBezierEasing(context:ComplexEasingCreateContext):ComplexEasingKind
	{
		return ComplexEasingKind.Simple(SimpleEasingKind.Bezier([0, 0, 1]));
	}
	
	public static function createUnaryOp(op:UnaryOpKind, context:ComplexEasingCreateContext):ComplexEasingKind
	{
		return ComplexEasingKind.Op(context.getEasing(), op);
	}
	
	public static function createBinaryOp(op:BinaryOpKind, context:ComplexEasingCreateContext):ComplexEasingKind
	{
		return ComplexEasingKind.Op(context.getEasing(), UnaryOpKind.Op(context.getEasing(), op));
	}
	
	public static function createTernaryOp(op:TernaryOpKind, context:ComplexEasingCreateContext):ComplexEasingKind
	{
		return ComplexEasingKind.Op(context.getEasing(), UnaryOpKind.Op(context.getEasing(), BinaryOpKind.Op(context.getEasing(), op)));
	}
}
