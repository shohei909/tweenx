package tweenxcore.color;

interface ITransparentColor extends IColor {
    
    public function toArgb():ArgbColor;
    public function toAhsv():AhsvColor;

    public function getAlpha():Float;
    
    public function toArgbInt():Int;
    public function toArgbHexString():String;
    public function toRgbaCssString():String;
}
