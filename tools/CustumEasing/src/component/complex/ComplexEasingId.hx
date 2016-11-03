package component.complex;
import component.basic.NumberInputId;
import component.basic.RateId;

abstract ComplexEasingId(Array<Int>) 
{
	public function new (array:Array<Int>)
	{
		this = array;
	}
	
	public static function root() :ComplexEasingId
	{
		return new ComplexEasingId([]);
	}
	
	public function isEmpty():Bool
	{
		return this.length == 0;
	}
	
	public function current():Int
	{
		return this[0];
	}
	
	public function child():ComplexEasingId
	{
		return new ComplexEasingId(this.slice(1));
	}
	
	public function concat(id:Int):ComplexEasingId
	{
		return new ComplexEasingId(this.concat([id]));
	}
	
	public function rateId(id:Int):RateId
	{
		return new RateId(this.concat([id]));
	}
	
	public function numberInputId(id:Int):NumberInputId
	{
		return NumberInputId.EasingRate(new RateId(this.concat([id])));
	}
	
	@:op(A == B)
	public static function equals(a:ComplexEasingId, b:ComplexEasingId):Bool
	{
		return a.toString() == b.toString();
	}
	
	public static function fromString(string:String):ComplexEasingId 
	{
		return new ComplexEasingId([for (str in string.split(".")) Std.parseInt(str)]);
	}
	
	public function toString():String
	{
		return this.join(".");
	}
}
