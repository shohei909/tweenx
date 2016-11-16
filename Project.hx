import haxe.macro.Compiler;
import sys.FileSystem;
import sys.io.File;

class Project
{
    public static function sampleName(dir:String, num:Int) {
        for (file in FileSystem.readDirectory("sample/" + dir)) {
            if (FileSystem.isDirectory("sample/" + dir + "/" + file)) {
                var segs = file.split("_");
                if (segs.length == 2 && Std.parseInt(segs[0]) == num) {
                    return segs[1];
                }
            }
        }
        return null;
    }

    static var windows:Map<Int, Setting> = [
        4 => {
            width : 750,
            height : 500,
            kind: Repatable(true, false),
        }
    ];

    public static function sampleSetting(num:Int):Setting {
        return if (windows.exists(num)){
            windows[num];
        } else {
            {
                width : 401,
                height : 401,
                kind: Repatable(false, true)
            }
        }
    }

    public static function exportHxml()
    {
        forEachSample(writeHxml);

        var arr = [];

        forEachSample(function (dir, num:Int) {
            var samplePrefix = ("000" + num).substr(-3);
            var sampleName = sampleName(dir, num);
            var str = "";
            str += ("hxml/" + sampleName + ".hxml\n");
            str += ("-swf website/sample/swf/" + sampleName + ".swf\n");
            str += ("--connect 6000\n");
            arr.push(str);
        });

        File.saveContent("buildAll.hxml", arr.join("--next\n\n"));
        File.saveContent("startServer.hxml", "--wait 6000");
    }

    static function forEachSample(func:String->Int->Void)
    {
        var keys:Array<Int> = [];
        for (file in FileSystem.readDirectory("sample/tweenx")) {
            if (FileSystem.isDirectory("sample/tweenx/" + file)) {
                var segs = file.split("_");
                if (segs.length == 2 && Std.parseInt(segs[0]) != null) {
                    keys.push(Std.parseInt(segs[0]));
                }
            }
        }

        keys.sort(function (a, b) return a - b);

        for (key in keys) {
            func("tweenx", key);
        }
    }

    static private function writeHxml(dir:String, num:Int)
    {
        var samplePrefix = ("000" + num).substr(-3);
        var sampleName = sampleName(dir, num);
        var setting = sampleSetting(num);
        var file = File.write("hxml/" + sampleName + ".hxml", true);

        file.writeString('-swf-header ${setting.width}:${setting.height}:60:FFFFFF\n');


        file.writeString("-cp sample/" + dir + "/" + samplePrefix + "_" + sampleName + "\n");
        file.writeString("-cp src/tweenx\n");
        file.writeString("-cp src/tweenxcore\n");
        file.writeString("-cp sample/flash\n");

        switch (setting.kind)
        {
            case Repatable(endless, grid):
                file.writeString('-main sample.main.DirectMain\n');
                if (endless)
                {
                    file.writeString("-D endless\n");
                }
                if (grid)
                {
                    file.writeString("-D grid_background\n");
                }

            case Direct:
                file.writeString('-main sample.main.DirectMain\n');

        }
    }
}

private typedef Setting = {
    width : Int,
    height : Int,
    kind: MainKind,
}

private enum MainKind
{
    Repatable(endless : Bool, grid : Bool);
    Direct;
}
