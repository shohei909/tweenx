package core.localize;
import core.localize.resource.EnglishResource;
import core.localize.resource.JapaneseResource;

class LocalizeManager 
{
	public var resource(default, null):LocalizeResource;
	
	public function new()
	{
		resource = new JapaneseResource();
	}	
}