package core.localize.resource;
import component.complex.ComplexEasingSelectItemId;
import core.localize.LocalizeResource;
import core.output.OutputMode;
import haxe.EnumTools.EnumValueTools;
import tweenxcore.expr.InOutKind;

class EnglishResource implements LocalizeResource
{
	public function new ()
	{
	}
	
	public function easingItem(itemId:ComplexEasingSelectItemId):String 
	{
		return EnumValueTools.getName(itemId);
	}
	
	public function outputMode(mode:OutputMode):String
	{
		return EnumValueTools.getName(mode);
	}
	
	public function inOut(kind:InOutKind):String
	{
		return EnumValueTools.getName(kind);
	}
	
}
