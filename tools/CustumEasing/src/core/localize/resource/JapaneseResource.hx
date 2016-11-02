package core.localize.resource;
import component.complex.ComplexEasingSelectItemId;
import core.localize.LocalizeResource;
import core.localize.ResourceKey;
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
	
	public function common(key:ResourceKey):String
	{
		inline function en():String
		{
			return "(" + english.common(key) + ")";
		}
		
		return switch(key)
		{
			case Title:         "イージングエディタ";
			case Min:           "下限" + en();
			case Max:           "上限" + en();
			case From:          "開始値" + en();
			case To:            "終了値" + en();
			case AnimationTime: "アニメーション時間[秒]";
			case SwitchTime:    "切り替え時刻";
			case SwitchValue:   "切り替え値";
			case Undo:          "元にもどす";
			case Redo:          "やりなおし";
			case Weight:        "重み";
		}
	}
}
