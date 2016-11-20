package tweenxcore;


import tweenxcore.Tools.Easing;
class EaseLookup {
    public function new() {
    }

    /**
    * @private
    */
    private static var _lookup:Map<String, Float->Float>;

    /**
     * Finds the easing function associated with a particular name (String), like "cricOut". This can be useful when
     * loading in XML data that comes in as Strings but needs to be translated to native function references. You can pass in
     * the name with or without the period, and it is case insensitive, so any of the following will find the Easeing.cricOut function: <br /><br /><code>
     * EaseLookup.find("Cric.easeOut") <br />
     * EaseLookup.find("cricEaseOut") <br />
     * EaseLookup.find("cricout") <br /><br /></code>
     *
     * You can translate Strings directly when tweening, like this: <br /><code>
     * TweenX.to(mc, 1, {x:100, ease:EaseLookup.find(myString)});<br /><br /></code>
     *
     * @param param The param of the easing function, with or without the period and case insensitive (i.e. "Cric.easeOut" or "cricOut")
     * @return The easing function associated with the name
     */
    public static function find(param:String):Float->Float {
        if (_lookup == null) {
            buildLookup();
        }
        return _lookup[param.toLowerCase()];
    }

    private static function buildLookup():Void {
        _lookup = new Map<String, Float->Float>();

        addInOut("sine");
        addInOut("quad");
        addInOut("cubic");
        addInOut("quart");
        addInOut("quint");
        addInOut("expo");
        addInOut("circ");
        addInOut("bounce");
        addInOut("back");
        addInOut("elastic");
        addInOut("warp");


        _lookup["linear.easenone"] = _lookup["lineareasenone"] = _lookup["linear"] = Easing.linear;
    }


    private static function addInOut(param:String):Void
    {
        var name:String = param.toLowerCase();
        _lookup[name + ".easein"] = _lookup[name + "easein"] = _lookup[name + "in"] = Reflect.field(Easing, name+"In");
        _lookup[name + ".easeout"] = _lookup[name + "easeout"] = _lookup[name + "out"] = Reflect.field(Easing, name+"Out");
        _lookup[name + ".easeinout"] = _lookup[name + "easeinout"] = _lookup[name + "inout"] = Reflect.field(Easing, name+"InOut");
        _lookup[name + ".easeoutin"] = _lookup[name + "easeoutin"] = _lookup[name + "outin"] = Reflect.field(Easing, name+"OutIn");
    }
}
