package tweenxcore.tools;
import haxe.ds.Option;

#if macro
import haxe.macro.Expr;
#end

class OptionTools {

    public static inline function map<T, U>(option:Option<T>, f:T->U):Option<U> {
        return switch (option) {
            case Some(t):
                Some(f(t));

            case None:
                None;
        }
    }

    public static inline function flatMap<T, U>(option:Option<T>, f:T->Option<U>):Option<U> {
        return switch (option) {
            case Some(t):
                f(t);

            case None:
                None;
        }
    }

    public static inline function ifSome<T>(option:Option<T>, f:T->Void):Void {
        switch (option) {
            case Some(t):
                f(t);

            case None:
                false;
        }
    }

    public static inline function isEmpty<T>(option:Option<T>):Bool {
        return switch (option) {
            case Some(x):
                false;

            case None:
                true;
        }
    }

    public static function isDefined<T>(option:Option<T>) {
        return return switch (option) {
            case Some(x):
                true;

            case None:
                false;
        }
    }

    public static inline function getOrElse<T>(option:Option<T>, defaultValue:T):T {
        return switch (option) {
            case Some(x):
                x;

            case None:
                defaultValue;
        }
    }

    public static inline function getOrThrow<T>(option:Option<T>, throwValue:Dynamic):T {
        return switch (option) {
            case Some(x):
                x;

            case None:
                throw throwValue;
        }
    }

    public static inline function flattenOnce<T>(option:Option<Option<T>>):Option<T> {
        return switch (option) {
            case Some(t):
                t;

            case None:
                None;
        }
    }

    public static macro function flatten<T>(option:ExprOf<Option<Option<Dynamic>>>, depth:Int):Expr {
        var expr = option;
        for (i in 0...depth) {
            expr = macro tweenxcore.tools.OptionTools.flatten($expr);
        }
        return expr;
    }

    public static inline function fold<A, B>(option:Option<A>, defaultValue:B, f:A -> B):B {
        return switch (option) {
            case Some(t):
                f(t);

            case None:
                defaultValue;
        }
    }
}
