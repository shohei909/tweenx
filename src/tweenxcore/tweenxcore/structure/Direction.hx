package tweenxcore.structure;

#if haxe-ver >= 3.10
@:enum abstract Direction(Int) {
   Backward = -1;
   Stopped = 0;
   Forward = 1;
}
#else
enum Direction {
   Backward;
   Stopped;
   Forward;
}
#end
