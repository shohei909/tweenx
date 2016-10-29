package component.basic;
import component.complex.ComplexEasingId;

abstract RateId(String) 
{
	public function new (array:Array<Int>)
	{
		this = array.join(".");
	}
	
	public function rateIndex():Int
	{
		return Std.parseInt(this.split(".").pop());
	}
	
	public function parent():ComplexEasingId
	{
		var arr = this.split(".");
		arr.pop();
		
		return new ComplexEasingId([for (str in arr) Std.parseInt(str)]);
	}
	
	public function toString():String
	{
		return this;
	}
}
