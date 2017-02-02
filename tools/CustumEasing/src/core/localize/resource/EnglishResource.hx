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
        return switch(mode)
        {
            case OutputMode.Unity: "Unity (TweenCore#)";
            case _: EnumValueTools.getName(mode);
        }
    }
    
    public function inOut(kind:InOutKind):String
    {
        return EnumValueTools.getName(kind);
    }
    
    public function common(key:ResourceKey):String
    {
        return switch(key)
        {
            case Title:         "Easing Editor";
            case Min:           "Min";
            case Max:           "Max";
            case From:          "From";
            case To:            "To";
            case AnimationTime: "Animation Time[sec]";
            case SwitchTime:    "Switch Time";
            case SwitchValue:   "Switch Value";
            case Undo:          "Undo";
            case Redo:          "Redo";
            case Weight:        "Weight";
            case Repeat:        "Repeat";
            case DropToMove:      "Move";
            case DropToDuplicate: "Duplicate";
        }
    }
    
    public function getCode():String {
        return "en";
    }
}
