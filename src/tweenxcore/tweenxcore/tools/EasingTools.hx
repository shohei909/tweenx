package tweenxcore.tools;
using tweenxcore.tools.Tools;

class EasingTools {

    public static function linearBlend(
        easing1:Float->Float,
        easing2:Float->Float,
        startOfEasing1Strength:Float,
        endOfEasing1Strength:Float
    ):Float->Float
    {
        return blend(
            easing1,
            easing2,
            function (time:Float) {
                return time.linear().lerp(startOfEasing1Strength, endOfEasing1Strength);
            }
        );
    }

    public static function blend(
        easing1:Float->Float,
        easing2:Float->Float,
        functionForEasing1Strength:Float->Float
    ):Float->Float
    {
        return FunctionTools.merge3(
            functionForEasing1Strength,
            easing1,
            easing2,
            FloatTools.lerp
        );
    }

    public static function join(
        easing1:Float->Float,
        switchTime:Float,
        easing2:Float->Float
    ):Float->Float
    {
        return function(time:Float) {
            return if (time < switchTime) {
                easing1(time);
            } else {
                easing2(time);
            }
        }
    }

    public static function connect(
        easing1:Float->Float,
        switchTime:Float,
        switchValue:Float,
        easing2:Float->Float
    ):Float->Float
    {
        return function(time:Float) {
            return if (time < switchTime) {
                easing1(time).lerp(0, switchValue);
            } else {
                easing2(time).lerp(switchValue, 1);
            }
        }
    }
}
