import sys.FileSystem;
import sys.io.File;
import sys.io.Process;

class BuildConfig {

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

    static var windows:Map<Int, WindowSize> = [
        4 => {
            width : 750,
            height : 500,
        },
        900 => {
            width : 720,
            height : 512,
        }
    ];

    public static function sampleWindowSize(num:Int):WindowSize {
        return if (windows.exists(num)){
            windows[num];
        } else {
            {
                width : 451,
                height : 151,
            }
        }
    }

    public static function buildAll() {
        // TweenX
        for (dir in FileSystem.readDirectory("sample")) {
            var keys = [];

            for (file in FileSystem.readDirectory("sample/" + dir)) {
                if (FileSystem.isDirectory("sample/" + dir + "/" + file)) {
                    var segs = file.split("_");
                    if (segs.length == 2 && Std.parseInt(segs[0]) != null) {
                        keys.push(Std.parseInt(segs[0]));
                    }
                }
            }

            keys.sort(function (a, b) return a - b);

            for (key in keys) {
                Sys.command("haxelib", ["run", "lime", "build", "SampleProject.hxp", "flash", "--time", "-release", "-sample-" + dir + "-" + key, ""]);
            }
        }
    }
}

private typedef WindowSize = {
    width : Int,
    height : Int,
}
