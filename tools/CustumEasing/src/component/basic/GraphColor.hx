package component.basic;

#if (haxe_ver < 4.3) @:enum #else enum #end
abstract GraphColor(Int) to Int
{
	var Theme = 0x0E5ABB;
	var Sub = 0xFF64B1;
    
    public function toColorString():String
    {
        return "#" + StringTools.hex(this, 6);
    }
}
