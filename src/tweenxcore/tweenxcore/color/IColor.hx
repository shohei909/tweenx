package tweenxcore.color;

interface IColor 
{ 
    public function getRed():Float;
    public function getGreen():Float;
    public function getBlue():Float;
    
    public function getHue():Float;
    public function getSaturation():Float;
    public function getBrightness():Float;
    
    public function toRgb():RgbColor;
    public function toHsv():HsvColor;
    public function toRgbWithAlpha(alpha:Float):ArgbColor;
    public function toHsvWithAlpha(alpha:Float):AhsvColor;
    
    public function toRgbInt():Int;
    public function toRgbHexString():String;
    public function toRgbCssString():String;
}
