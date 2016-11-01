package core.localize.resource;
import component.complex.ComplexEasingSelectItemId;
import core.localize.LocalizeResource;
import core.localize.resource.EnglishResource;
import core.output.OutputMode;
import haxe.EnumTools.EnumValueTools;
import tweenxcore.expr.InOutKind;

class JapaneseResource implements LocalizeResource
{
	private var english:EnglishResource;
	
	public function new() 
	{
		english = new EnglishResource();
	}
	
	public function easingItem(item:ComplexEasingSelectItemId):String 
	{
		var text = switch (item)
		{
			case Linear:    "1次";
			case Quad:      "2次";
			case Cubic:     "3次";
			case Quart:     "4次";
			case Quint:     "5次";
			case Sine:      "サイン";
			case Circ:      "円弧";
			case Expo:      "指数";
			case Back:      "バック";
			case Bounce:    "バウンド";
			case Elastic:   "バネ";
			case Warp:      "ワープ";
			case Bezier:    "ベジェ曲線";
			case Repeat:    "繰り返し";
			case Lerp:      "線形補完";
			case Clamp:     "上限下限";
			case Yoyo:      "ヨーヨー";
			case Zigzag:    "ジグザグ";
			case Composite: "関数合成";
			case Multiply:  "かけ算";
			case Mix:       "ミックス";
			case Connect:   "コネクト";
			case OneTwo:    "ワンツー";
			case Crossfade: "クロスフェード";
		}
		
		return text + "(" + english.easingItem(item) + ")";
	}
	
	public function outputMode(mode:OutputMode):String
	{
		return EnumValueTools.getName(mode);
	}
	
	public function inOut(kind:InOutKind):String
	{
		var text = switch(kind)
		{
			case InOutKind.In:    "先詰め";
			case InOutKind.Out:   "後詰め";
			case InOutKind.InOut: "両詰め";
			case InOutKind.OutIn: "中詰め";
		}
		
		return text + "(" + english.inOut(kind) + ")";
	}
}
