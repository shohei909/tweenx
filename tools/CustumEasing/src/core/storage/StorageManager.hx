package core.storage;
import core.localize.LocaleKind;
import haxe.EnumTools.EnumValueTools;
import haxe.Serializer;
import haxe.Unserializer;
import haxe.ds.Option;
import js.Browser;
import js.html.Storage;

class StorageManager 
{
    private var context:RootContext;
    private var storage:Storage;
    public function new(context:RootContext) 
    {
        storage = Browser.window.localStorage;
        this.context = context;    
    }
    
    public function save():Void
    {
        set(StorageKey.Output, context.output.mode);
        set(StorageKey.Locale, context.localize.locale);
    }
    
    private function set(key:StorageKey, data:Dynamic):Void
    {
        storage.setItem(EnumValueTools.getName(key), Serializer.run(data));
    }
    
    public function get(key:StorageKey):Option<Dynamic>
    {
        var data = storage.getItem(EnumValueTools.getName(key));
        return if (data == null) Option.None else Option.Some(Unserializer.run(data));
    }
}