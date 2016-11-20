package tweenx909.advanced;
import haxe.io.Error;
import haxe.Log;
import haxe.PosInfos;

class CommandX {
    public var command            (default, null):CommandTypeX;
    public var definedPosInfos(default, null):PosInfos;
    function new (command:CommandTypeX, ?posInfos:PosInfos) {
        this.command = command; this.definedPosInfos = posInfos;
    }
}
