package cases;
import haxe.Json;
import haxe.macro.Expr;
import haxe.macro.Printer;
import nanotest.NanoTestCase;
import tweenxcore.expr.ComplexEasingKindTools;

class ExprTestCase extends NanoTestCase 
{
    
    public static var jsons:Array<String> =
    [
        '["Op",["Op",["Simple",["Standard","Quad","OutIn"]],["Op",["Simple",["Standard","Quart","OutIn"]],"Composite"]],["Op",["Simple","Linear"],["Mix",0.14]]]',
        '["Op",["Op",["Simple",["Standard","Back","In"]],["Op",["Op",["Simple","Linear"],["Lerp",0,1.7]],"Composite"]],["Op",["Op",["Simple",["Standard","Bounce","Out"]],["Op",["Op",["Simple","Linear"],["Lerp",-0.7,1]],"Composite"]],["Op",["Op",["Op",["Simple","Linear"],["Lerp",-1,2]],["Clamp",0,1]],["Crossfade",0,1]]]]',
        '["Op",["Op",["Simple",["Standard","Quad","Out"]],["RoundTrip","Yoyo"]],["Op",["Op",["Simple","Linear"],["Lerp",0,3]],["Mix",0.33333]]]',
        '["Op",["Simple",["Standard","Cubic","Out"]],["Op",["Simple",["Standard","Cubic","In"]],["Connect",0.9,-0.2]]]',
        '["Op",["Simple",["Standard","Sine","InOut"]],["Op",["Op",["Simple",["Standard","Quint","InOut"]],["Op",["Simple",["Standard","Quint","InOut"]],"Composite"]],["Mix",0.8]]]',
        '["Op",["Op",["Simple",["Standard","Expo","In"]],["Op",["Simple",["Standard","Quint","In"]],"Composite"]],["Op",["Op",["Simple",["Standard","Quint","Out"]],["Op",["Simple",["Standard","Cubic","Out"]],"Composite"]],["Mix",1.2]]]',
        '["Op",["Op",["Simple",["Line","UniformQuadraticBSpline",[1.34,0,1,-1]]],["Op",["Simple",["Line","Polyline",[0,-0.58,1,0]]],"Multiply"]],["Op",["Op",["Simple",["Line","Bezier",[0,0,1,1]]],["RoundTrip","Zigzag"]],["OneTwo",0.5]]]',
        '["Simple",["Standard","Bounce","Out"]]',
        '["Op",["Simple",["Standard","Warp","In"]],["Repeat",2]]',
        '["Op",["Simple","Linear"],["Op",["Simple",["Standard","Cubic","In"]],["Op",["Simple",["Standard","Back","In"]],["Crossfade",0,1]]]]',
        '["Op",["Simple",["Standard","Back","In"]],["Op",["Op",["Simple","Linear"],["Lerp",0,1.7]],"Composite"]]',
        '["Simple",["Standard","Quint","OutIn"]]',
        '["Simple",["Standard","Circ","In"]]',
        '["Simple",["Standard","Circ","Out"]]',
        '["Simple",["Standard","Circ","OutIn"]]',
        '["Simple",["Standard","Circ","InOut"]]',
        '["Simple",["Standard","Elastic","In"]]',
        '["Simple",["Standard","Elastic","Out"]]',
        '["Simple",["Standard","Elastic","OutIn"]]',
        '["Simple",["Standard","Elastic","InOut"]]',
        '["Simple",["Standard","Bounce","In"]]',
        '["Simple",["Standard","Bounce","Out"]]',
        '["Simple",["Standard","Bounce","OutIn"]]',
        '["Simple",["Standard","Bounce","InOut"]]',
        '["Simple",["Standard","Back","In"]]',
        '["Simple",["Standard","Back","Out"]]',
        '["Simple",["Standard","Back","OutIn"]]',
        '["Simple",["Standard","Back","InOut"]]',
        '["Op",["Simple",["Standard","Circ","In"]],["Op",["Simple",["Standard","Cubic","OutIn"]],["Mix",0.5]]]',
        '["Op",["Simple",["Line","Polyline",[0,1]]],["Op",["Simple",["Standard","Expo","OutIn"]],["OneTwo",0.5]]]',
    ];
    
    public static var caseValues:Array<Float> = [ -3, -1.4, -1.001, -1, -0.9999, -3 / 7, -0.0001, 0, 0.00001, 2 / 13, 0.25, 0.5, 0.75, 0.79, 0.99999999999, 1, 1.0000000000001, 2, 3, 11 / 3];
    
    #if !macro
    public static var functions1:Array<Float->Float> = createFunctionExprs1();
    public static var functions2:Array<Float->Float> = createFunctionExprs2();
    public static var values:Array<Array<Float>> = createValues();
    
    public function new() {
        super();
    }
    
    public function test():Void
    {
        for (i in 0...jsons.length)
        {
            var json = jsons[i];
            var runtimeFunc = ComplexEasingKindTools.toFunction(ComplexEasingKindTools.fromJsonable(Json.parse(json)));
            var compileTimeFunc1 = functions1[i];
            var compileTimeFunc2 = functions2[i];
            
            for (j in 0...caseValues.length)
            {
                var value = caseValues[j];
                var runtimeValue = runtimeFunc(value);
                assertEquals(runtimeValue, compileTimeFunc1(value)).label(value).label(json);
                assertEquals(runtimeValue, compileTimeFunc2(value)).label(value).label(json);
                
                // nearly equals
                assertTrue(runtimeValue == values[i][j] || Math.abs(runtimeValue - values[i][j]) <= Math.abs(runtimeValue) * 0.00001).label(runtimeValue).label(values[i][j]).label(value).label(json);
            }
        }
    }
    #end
    
    public static macro function createFunctionExprs1():Expr
    {
        var exprs = [
            for (json in jsons)
            {
                ComplexEasingKindTools.toFunctionExpr(ComplexEasingKindTools.fromJsonable(Json.parse(json)));
            }
        ];
        
        return macro $a{exprs};
    }
    
    
    public static macro function createFunctionExprs2():Expr
    {
        var exprs = [
            for (json in jsons)
            {
                var expr = ComplexEasingKindTools.toExpr(ComplexEasingKindTools.fromJsonable(Json.parse(json)), macro rate);
                macro function (rate:Float) { return $expr; }
            }
        ];
        
        return macro $a{exprs};
    }
    
    
    public static macro function createValues():Expr
    {
        var exprs = [
            for (json in jsons)
            {
                var func = ComplexEasingKindTools.toFunction(ComplexEasingKindTools.fromJsonable(Json.parse(json)));
                
                var innerExprs = [
                    for (value in caseValues) 
                    {
                        macro $v{func(value)}
                    }
                ];
                
                macro $a{innerExprs};
            }
        ];
        
        return macro $a{exprs};
    }
}
