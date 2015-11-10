import haxe.ds.Option;
import openfl.geom.Point;
import sample.SampleSuport.SamplePlayer;
import tweenxcore.geom.PolarPoint;
import tweenxcore.structure.FloatChangePart;

import sample.SampleSuport.GridSprite;
import sample.SampleSuport.Square;
import openfl.events.Event;

import tweenxcore.structure.FloatChange;
using tweenxcore.tools.Tools;

class SampleSprite extends GridSprite {
    var square:Square;
    var frame = 0;

	public function new() {
		super();
        addChild(square = new Square(0, GridSprite.CELL_SIZE * 4));

        //Event
        addEventListener(Event.ENTER_FRAME, onFrame);
    }

    function onFrame(e:Event) {
        var change = new FloatChange(frame, frame += 1);
        change.part(0, 20, updateSquare);
	}

    function updateSquare(change:FloatChangePart) {
        square.x = change.current.cubicIn().lerp(0, 420);
    }
}

class Main extends SamplePlayer {
    override function start() {
        return new SampleSprite();
    }
}
