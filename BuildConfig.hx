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

    static var windows:Map<Int, Setting> = [
        4 => {
            width : 750,
            height : 500,
            grid: false,
            endless: true,
        },
        400 => {
            width : 750,
            height : 500,
            grid: false,
            endless: true,
        },
        900 => {
            width : 720,
            height : 512,
            grid: false,
            endless: true,
        }
    ];

    public static function sampleSetting(num:Int):Setting {
        return if (windows.exists(num)){
            windows[num];
        } else {
            {
                width : 451,
                height : 151,
                grid: true,
                endless: false,
            }
        }
    }

    public static function buildAll() {
        var process = new Process("haxe", ["--wait", "6060"]);

        // TweenX
        for (dir in FileSystem.readDirectory("sample")) {
            var keys = [];

            // temporary
            if (dir == "tweenx")
            {
                continue;
            }

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
                Sys.command("haxelib", ["run", "lime", "build", "SampleProject.hxp", "flash", "--times", "-release", "-sample-" + dir + "-" + key, "--connect", "6060"]);
            }
        }
    }

    public static function copySampleToWebsite() {
        if (!FileSystem.exists("website/sample/swf/")) {
            FileSystem.createDirectory("website/sample/swf/");
        }
        for (fileName in FileSystem.readDirectory("bin/flash/bin")) {
            if (fileName.substr(fileName.length - 4) == ".swf") {
                File.copy("bin/flash/bin/" + fileName, "website/sample/swf/" + fileName);
            }
        }
    }
}

private typedef Setting = {
    width : Int,
    height : Int,
    endless : Bool,
    grid : Bool,
}
