package cases;
import nanotest.NanoTestCase;

class ExpoBenchCase extends NanoTestCase {
    private static inline var L = 10000000; 
    private static inline var LN_2_10  = 6.931471805599453;
    
    public function testBench() {
        var p = [];
        var p2 = [];
        var e = [];
        
        for (i in 0...10)
        {
            p.push(tracePow());
            p2.push(tracePow2());
            e.push(traceExp());
        }
    }
    
    public function standardDeviation(p:Array<Float>) {
        var m = mean(p);
        var v = 0.0;
        for (f in p)
        {
            v += (f - m) * (f - m) / p.length;
        }
        
        return Math.sqrt(v);
    }
    
    public function mean(p:Array<Float>):Float
    {
        var v = 0.0;
        for (f in p)
        {
            v += f / p.length;
        }
        
        return v;
    }
    
    public function tracePow():Float
    {
        var time = Date.now().getTime();
        var v = 0.0;
        for (i in 0...L) {
            var t = i / L;
            v = Math.pow(2, 10 * (t - 1));
        }
        
        var result = (Date.now().getTime() - time);
        trace("Pow:" + v + ":"  + result);
        return result;
    }
    
    public function traceExp()
    {
        var time = Date.now().getTime();
        var v = 0.0;
        for (i in 0...L) {
            var t = i / L;
            v = Math.exp(LN_2_10 * (t - 1));
        }
        
        var result = (Date.now().getTime() - time);
        trace("Exp:" + v + ":"  + result);
        return result;
    }
    
    public function test() {
        var len = 20;
        for (i in 0...len) {
            var t = i / (len - 1);
            this.assertTrue(Math.abs(Math.pow(2, 10 * (t - 1)) - Math.exp(LN_2_10 * (t - 1))) < 0.000000000001).label(i);
        }
    }
}
