package react;
import api.react.React;
import api.react.ReactComponent.ReactComponentOfProps;

class ReactTools 
{
	public static function createElement<TProps>(type:Class<ReactComponentOfProps<TProps>>, ?attrs:TProps):ReactComponentOfProps<TProps>
	{
		return cast React.createElement(type, attrs);
	}
}
