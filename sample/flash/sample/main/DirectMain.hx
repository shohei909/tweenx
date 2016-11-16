package sample.main;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;

class DirectMain {
    static function main() {
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
        Lib.current.addChild(new Main());
    }
}
