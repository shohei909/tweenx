package tweenxcore.expr;
import haxe.PosInfos;
import haxe.macro.Context;
import haxe.macro.Expr;
import tweenxcore.expr.ExprMaker.ExprMakeTools;

class ExprMakeTools
{
    public static function floatToExpr(float:Float):ExprOf<Float>
    {
        return { 
            expr: ExprDef.EConst(Constant.CFloat(Std.string(float))),
            pos: pos(),
        }
    }
    
    public static function floatArrayToExpr(floats:Array<Float>):ExprOf<Array<Float>>
    {
        return {
            expr: ExprDef.EArrayDecl([for (float in floats) floatToExpr(float)]),
            pos: pos(),
        }
    }
    
    public static function pos():Position
    {
        return 
        #if macro
            Context.currentPos();
        #else
            null;
        #end
    }
}