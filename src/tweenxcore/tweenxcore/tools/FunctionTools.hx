package tweenxcore.tools;

class FunctionTools {
    public static inline function composite<T1, T2, T3>(f:T1->T2, g:T2->T3):T1->T3 {
        return function (value:T1) {
            return g(f(value));
        }
    }

    public static inline function merge2<T1, T2, T3, T4>(f:T1->T2, g:T1->T3, mergeFunction:T2->T3->T4):T1->T4 {
        return function (value:T1) {
            return mergeFunction(f(value), g(value));
        }
    }

    public static inline function merge3<T1, T2, T3, T4, T5>(f:T1->T2, g:T1->T3, h:T1->T4, mergeFunction:T2->T3->T4->T5):T1->T5 {
        return function (value:T1) {
            return mergeFunction(f(value), g(value), h(value));
        }
    }
}
