import sys.FileSystem;
import sys.io.File;
import sys.io.Process;

class BuildConfig {

	public static function sampleName(num:Int) {
		for (file in FileSystem.readDirectory("sample")) {
			if (FileSystem.isDirectory("sample/" + file)) {
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
				width : 401,
				height : 401,
			}
		}
	}

	public static function buildAll() {
		var keys = [];

		for (file in FileSystem.readDirectory("sample")) {
			if (FileSystem.isDirectory("sample/" + file)) {
				var segs = file.split("_");
				if (segs.length == 2 && Std.parseInt(segs[0]) != null) {
					keys.push(Std.parseInt(segs[0]));
				}
			}
		}

		keys.sort(function (a, b) return a - b);

        var server = new Process("haxe", ["--wait", "6000"]);

		for (key in keys) {
			Sys.command("haxelib", ["run", "lime", "build", "SampleProject.hxp", "flash", "-release", "-sample-" + key]);
		}

        server.kill();
	}
}

private typedef WindowSize = {
	width : Int,
	height : Int,
}
