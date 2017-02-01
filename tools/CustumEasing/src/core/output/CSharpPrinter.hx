/*
 * this class is based on haxe/macro/Printer.hx
 * 
 * Copyright (C)2005-2017 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package core.output;

import haxe.macro.Expr;
using Lambda;
using StringTools;

class CSharpPrinter 
{

	var tabs:String;
	var tabString:String;
    
	public function new(?tabString = "\t") {
		tabs = "";
		this.tabString = tabString;
	}
    
	public function printBinop(op:Binop) return switch(op) {
		case OpAdd: "+";
		case OpMult: "*";
		case OpDiv: "/";
		case OpSub: "-";
		case OpAssign: "=";
		case OpEq: "==";
		case OpNotEq: "!=";
		case OpGt: ">";
		case OpGte: ">=";
		case OpLt: "<";
		case OpLte: "<=";
		case OpAnd: "&";
		case OpOr: "|";
		case OpXor: "^";
		case OpBoolAnd: "&&";
		case OpBoolOr: "||";
		case OpShl: "<<";
		case OpShr: ">>";
		case OpUShr: ">>>";
		case OpMod: "%";
		case OpInterval: "...";
		case OpArrow: "=>";
		case OpAssignOp(op):
			printBinop(op)
			+ "=";
	}
    
	public function printExpr(e:Expr) return switch(e.expr) 
    {
		case EConst(c): printConstant(c);
		case EBinop(op, e1, e2): '${printExpr(e1)} ${printBinop(op)} ${printExpr(e2)}';
        case EField(_.expr => EConst(CIdent("tweenxcore")), "Tools"): 
            'TweenCore';
        case EField(e1, n): 
            n = n.substr(0, 1).toUpperCase() + n.substr(1);
            '${printExpr(e1)}.$n';
            
		case EParenthesis(e1): '(${printExpr(e1)})';
		case EArrayDecl(el): 'new float[]{${printExprs(el, ", ")}}';
		case ECall(_.expr => EField(e1, "bind"), el): printBind(e1, el);
		case ECall(e1, el): '${printExpr(e1)}(${printExprs(el,", ")})';
		case EFunction(_, func): printFunction(func);
		case EVars(vl): "var " +vl.map(printVar).join(", ");
		case _: throw "not supported" + e.expr;
	}
    
	public function printComplexType(ct:ComplexType) return switch(ct) {
		case TPath(tp): printTypePath(tp);
		case TFunction(args, ret):
			function printArg(ct) return switch ct {
				case TFunction(_): "(" + printComplexType(ct) + ")";
				default: printComplexType(ct);
			};
			(args.length>0 ? args.map(printArg).join(" -> ") :"Void") + " -> " + printComplexType(ret);
		case TAnonymous(fields): throw "not supported";
		case TParent(ct): "(" + printComplexType(ct) + ")";
		case TOptional(ct): "?" + printComplexType(ct);
		case TExtend(tpl, fields): throw "not supported";
	}
	public function printFunctionArg(arg:FunctionArg) return
		(arg.opt ? "?" : "")
		+ arg.name
		+ opt(arg.value, printExpr, " = ");

	public function printFunction(func:Function) return
		"(" + func.args.map(printFunctionArg).join(", ") + ") => "
        + switch(func.expr.expr)
        {
            case EReturn(e): printExpr(e);
            case _: printExpr(func.expr);
        }
        
	public function printBind(e1:Expr, el:Array<Expr>)
    {
        var args1 = [];
        var args2 = [];
        for (e in el)
        {
            switch (e.expr)
            {
                case EConst(CIdent("_")): 
                    var name = "arg" + args1.length;
                    args1.push(name);
                    args2.push(name);
                    
                case _:
                    args2.push(printExpr(e));
            }
        }
        return '(${args1.join(", ")}) => ${printExpr(e1)}(${args2.join(", ")})';
    }

	public function printExprs(el:Array<Expr>, sep:String) {
		return el.map(printExpr).join(sep);
	}
    
	public function printTypePath(tp:TypePath) return
		(tp.pack.length > 0 ? tp.pack.join(".") + "." : "")
		+ tp.name
		+ (tp.sub != null ? '.${tp.sub}' : "");

	public function printVar(v:Var) return
		printComplexType(v.type) + " " + v.name
		+ opt(v.expr, printExpr, " = ");
        
	public function printConstant(c:Constant) return switch(c) {
		case CString(s): printString(s);
		case CIdent(s),
            CInt(s):
                s;
		case CFloat(s):
				s + "f";
		case CRegexp(s,opt): '~/$s/$opt';
	}
    
	public function printString(s:String) {
        return escapeString(s,'"');
	}

	function escapeString(s:String,delim:String) {
		return delim + s.replace("\n","\\n").replace("\t","\\t").replace("'","\\'").replace('"',"\\\"") #if sys .replace("\x00","\\x00") #end + delim;
	}
    
	function opt<T>(v:T, f:T->String, prefix = "") return v == null ? "" : (prefix + f(v));
}
