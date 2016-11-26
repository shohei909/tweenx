package;
import cases.ExpoBenchCase;
import cases.ExprTestCase;
import nanotest.NanoTestRunner;

class TestMain {

    public static function main() 
    {
        var runner = new NanoTestRunner();
        runner.add(new ExprTestCase());
        runner.add(new ExpoBenchCase());
        runner.run();
    }   
}
