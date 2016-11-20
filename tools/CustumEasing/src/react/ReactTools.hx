package react;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;

class ReactTools 
{
    public static function createElement<TProps>(type:Class<ReactComponentOfProps<TProps>>, ?attrs:TProps):ReactComponentOfProps<TProps>
    {
        return cast React.createElement(type, attrs);
    }
}

class ReactStringTools 
{
    public static function createElement(type:String, attrs:Dynamic, ?children0:Dynamic):ReactComponent
    {
        return cast React.createElement(type, attrs, children0);
    }
}
