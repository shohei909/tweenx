package tweenxcore.geom;
using tweenxcore.Tools;

class PolarPoint {
    public var distance:Float;
    public var angle:Float;

    public var x(get, never):Float;
    function get_x() {
        return angle.cosByRate() * distance;
    }

    public var y(get, never):Float;
    function get_y() {
        return angle.sinByRate() * distance;
    }

    public inline function new(distance:Float, angle:Float) {
        this.distance = distance;
        this.angle = angle;
    }

    public static inline function fromXy(x:Float, y:Float):PolarPoint {
        return new PolarPoint(Math.sqrt(x * x + y * y), Math.atan2(y, x));
    }

    public static inline function fromPoint(point:Point):PolarPoint {
        return fromXy(point.x, point.y);
    }

    public inline function setXy(x:Float, y:Float) {
        distance = Math.sqrt(x * x + y * y);
        angle = Math.atan2(y, x);
    }

    public inline function setPoint(point:Point) {
        distance = Math.sqrt(x * x + y * y);
        angle = Math.atan2(y, x);
    }

    public inline function clone(point:PolarPoint) {
        return new PolarPoint(distance, angle);
    }
}
