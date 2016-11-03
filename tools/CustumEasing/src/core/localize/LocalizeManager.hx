package core.localize;
import core.RootContext;
import core.localize.resource.EnglishResource;
import core.localize.resource.JapaneseResource;
import core.storage.StorageKey;
import haxe.ds.Option;

class LocalizeManager 
{
	public var resource(default, null):LocalizeResource;
	public var locale(default, null):LocaleKind;
	
	public function new(context:RootContext)
	{
		locale = switch (context.storage.get(StorageKey.Locale))
		{
			case Option.Some(data) if (Std.is(data, LocaleKind)):
				data;
				
			case _:
				LocaleKind.English;
		}
		
		update();
	}
	
	private function update():Void
	{
		resource = switch (locale)
		{
			case LocaleKind.English:
				new EnglishResource();
				
			case LocaleKind.Japanese:
				new JapaneseResource();
		}
	}
	
	
	public function changeLocale(newLocale:LocaleKind, result:ApplyResult):Void
	{
		locale = newLocale;
		update();
		result.requestSave();
	}
	
	public function getLocaleName(locale:LocaleKind):String
	{
		return switch (locale)
		{
			case LocaleKind.English:
				"English";
				
			case LocaleKind.Japanese:
				"日本語";
		}
	}
}
