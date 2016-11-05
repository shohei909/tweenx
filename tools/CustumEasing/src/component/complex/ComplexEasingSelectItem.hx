package component.complex;
import component.complex.ComplexEasingCreateContext;
import haxe.EnumTools;
import tweenxcore.expr.BinaryOpKind;
import tweenxcore.expr.ComplexEasingKind;
import tweenxcore.expr.LineKind;
import tweenxcore.expr.SimpleEasingKind;
import tweenxcore.expr.StandardEasingKind;
import tweenxcore.expr.TernaryOpKind;
import tweenxcore.expr.UnaryOpKind;

class ComplexEasingSelectItem 
{
    public static var itemIds:Array<Array<ComplexEasingSelectItemId>> = [
        [
            Linear,
            
            // Standard
            Quad,
            Cubic,
            Quart,
            Quint,
            Sine,
            Circ,
            Expo,
            Back,
            Bounce,
            Elastic,
            Warp,
        ],
        [
            // Free line
            Polyline,
            Bezier,
            UniformQuadraticBSpline
        ],
        [
            // Unary Op
            Lerp,
            Clamp,
            Repeat,
            Yoyo,
            Zigzag,
        ],
        [
            // Binary Op
            Composite,
            Multiply,
            Connect,
            OneTwo,
            Mix,
            
            // Ternary Op
            Crossfade,
        ]
    ];
    
    public var id(default, null):ComplexEasingSelectItemId;
    public var createEasing(default, null):ComplexEasingCreateContext->ComplexEasingKind;
    
    public function new(id:ComplexEasingSelectItemId, createEasing:ComplexEasingCreateContext->ComplexEasingKind) 
    {
        this.id = id;
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
                        
                    case SimpleEasingKind.Line(kind, _):
                        switch (kind)
                        {
                            case Bezier:    ComplexEasingSelectItemId.Bezier;
                            case Polyline:  ComplexEasingSelectItemId.Polyline;
                            case UniformQuadraticBSpline:  ComplexEasingSelectItemId.UniformQuadraticBSpline;
                        }
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
    
    public static function createItem(id:ComplexEasingSelectItemId):ComplexEasingSelectItem
    {
        return switch (id)
        {
            case ComplexEasingSelectItemId.Linear:                  new ComplexEasingSelectItem(id, createLinear);
            case ComplexEasingSelectItemId.Quad:                    new ComplexEasingSelectItem(id, createStandard.bind(StandardEasingKind.Quad));
            case ComplexEasingSelectItemId.Cubic:                   new ComplexEasingSelectItem(id, createStandard.bind(StandardEasingKind.Cubic));
            case ComplexEasingSelectItemId.Quart:                   new ComplexEasingSelectItem(id, createStandard.bind(StandardEasingKind.Quart));
            case ComplexEasingSelectItemId.Quint:                   new ComplexEasingSelectItem(id, createStandard.bind(StandardEasingKind.Quint));
            case ComplexEasingSelectItemId.Sine:                    new ComplexEasingSelectItem(id, createStandard.bind(StandardEasingKind.Sine));
            case ComplexEasingSelectItemId.Circ:                    new ComplexEasingSelectItem(id, createStandard.bind(StandardEasingKind.Circ));
            case ComplexEasingSelectItemId.Expo:                    new ComplexEasingSelectItem(id, createStandard.bind(StandardEasingKind.Expo));
            case ComplexEasingSelectItemId.Back:                    new ComplexEasingSelectItem(id, createStandard.bind(StandardEasingKind.Back));
            case ComplexEasingSelectItemId.Bounce:                  new ComplexEasingSelectItem(id, createStandard.bind(StandardEasingKind.Bounce));
            case ComplexEasingSelectItemId.Elastic:                 new ComplexEasingSelectItem(id, createStandard.bind(StandardEasingKind.Elastic));
            case ComplexEasingSelectItemId.Warp:                    new ComplexEasingSelectItem(id, createStandard.bind(StandardEasingKind.Warp));
            case ComplexEasingSelectItemId.Bezier:                  new ComplexEasingSelectItem(id, createPolyline.bind(LineKind.Bezier));
            case ComplexEasingSelectItemId.Polyline:                new ComplexEasingSelectItem(id, createPolyline.bind(LineKind.Polyline));
            case ComplexEasingSelectItemId.UniformQuadraticBSpline: new ComplexEasingSelectItem(id, createPolyline.bind(LineKind.UniformQuadraticBSpline));
            case ComplexEasingSelectItemId.Repeat:                  new ComplexEasingSelectItem(id, createUnaryOp.bind(UnaryOpKind.Repeat(2)));
            case ComplexEasingSelectItemId.Lerp:                    new ComplexEasingSelectItem(id, createUnaryOp.bind(UnaryOpKind.Lerp(0, 1)));
            case ComplexEasingSelectItemId.Clamp:                   new ComplexEasingSelectItem(id, createUnaryOp.bind(UnaryOpKind.Clamp(0, 1)));
            case ComplexEasingSelectItemId.Yoyo:                    new ComplexEasingSelectItem(id, createUnaryOp.bind(UnaryOpKind.RoundTrip(Yoyo)));
            case ComplexEasingSelectItemId.Zigzag:                  new ComplexEasingSelectItem(id, createUnaryOp.bind(UnaryOpKind.RoundTrip(Zigzag)));
            case ComplexEasingSelectItemId.Composite:               new ComplexEasingSelectItem(id, createBinaryOp.bind(BinaryOpKind.Composite));
            case ComplexEasingSelectItemId.Multiply:                new ComplexEasingSelectItem(id, createBinaryOp.bind(BinaryOpKind.Multiply));
            case ComplexEasingSelectItemId.Mix:                     new ComplexEasingSelectItem(id, createBinaryOp.bind(BinaryOpKind.Mix(0.5)));
            case ComplexEasingSelectItemId.Connect:                 new ComplexEasingSelectItem(id, createBinaryOp.bind(BinaryOpKind.Connect(0.5, 0.5)));
            case ComplexEasingSelectItemId.OneTwo:                  new ComplexEasingSelectItem(id, createBinaryOp.bind(BinaryOpKind.OneTwo(0.5)));
            case ComplexEasingSelectItemId.Crossfade:               new ComplexEasingSelectItem(id, createTernaryOp.bind(TernaryOpKind.Crossfade(0, 1)));
        }
    }
    
    private static function createLinear(context:ComplexEasingCreateContext):ComplexEasingKind
    {
        return ComplexEasingKind.Simple(Linear);
    }
    
    private static function createStandard(easing:StandardEasingKind, context:ComplexEasingCreateContext):ComplexEasingKind
    {
        return ComplexEasingKind.Simple(SimpleEasingKind.Standard(easing, context.getInOut()));
    }
    
    private static function createPolyline(polyline:LineKind, context:ComplexEasingCreateContext):ComplexEasingKind
    {
        return ComplexEasingKind.Simple(SimpleEasingKind.Line(polyline, context.getControls()));
    }
    
    private static function createUnaryOp(op:UnaryOpKind, context:ComplexEasingCreateContext):ComplexEasingKind
    {
        return ComplexEasingKind.Op(context.getEasing(), op);
    }
    
    private static function createBinaryOp(op:BinaryOpKind, context:ComplexEasingCreateContext):ComplexEasingKind
    {
        return ComplexEasingKind.Op(context.getEasing(), UnaryOpKind.Op(context.getEasing(), op));
    }
    
    private static function createTernaryOp(op:TernaryOpKind, context:ComplexEasingCreateContext):ComplexEasingKind
    {
        return ComplexEasingKind.Op(context.getEasing(), UnaryOpKind.Op(context.getEasing(), BinaryOpKind.Op(context.getEasing(), op)));
    }
}
