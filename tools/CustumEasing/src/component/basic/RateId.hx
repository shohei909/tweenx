package component.basic;
import component.complex.ComplexEasingId;

abstract RateId(Array<Int>) 
{
	public function new (array:Array<Int>)
	{
		this = array;
	}
	
	public function isEmpty():Bool
	{
		return this.length == 0;
	}
	
	public function rateIndex():Int
	{
		return this[this.length - 1];
	}
	
	public function parent():ComplexEasingId
	{
		return new ComplexEasingId(this.slice(0, this.length - 1));
	}
	
	@:op(A == B)
	public static function equals(a:RateId, b:RateId):Bool
	{
		return a.toString() == b.toString();
	}
	
	public function toString():String
	{
		return this.join(".");
	}
}
