package tweenx909.advanced;

/**
 * ...
 * @author shohei909
 */
enum UpdateModeX{
    MANUAL;
    TIME(frameRate:Float);
    #if (flash)
    FRAME;
    #end
}
