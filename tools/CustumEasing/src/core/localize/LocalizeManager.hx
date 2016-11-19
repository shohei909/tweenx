package core.localize;
import core.RootContext;
import core.localize.resource.EnglishResource;
import core.localize.resource.JapaneseResource;
import core.storage.StorageKey;
import haxe.ds.Option;
import js.Browser;

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
        
        var code = resource.getCode();
        var element = Browser.document.getElementById("header");
        for (child in element.children)
        {
            if (child.className == code)
            {
                child.hidden = false;
            }
            else
            {
                child.hidden = true;
            }
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
