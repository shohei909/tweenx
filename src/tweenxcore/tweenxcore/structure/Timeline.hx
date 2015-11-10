package tweenxcore.structure;
using tweenxcore.tools.FloatTools;

/**
 * TODO: Implement
 */
class Timeline<T>
{
    var totalWeight:Float;
    var data:Array<Float>;
    var weightData:Array<Float>;

    public function new(firstData:T, weight:Float)
    {
        if (weight <= 0)
        {
            throw "weight must be positive number";
        }
        data = [firstData];
        weightData = [];
        totalWeight = weight;
    }

    public function get(rate:Float):T
    {
        return data[weightData.binarySearch(rate * totalWeight)];
    }
}
