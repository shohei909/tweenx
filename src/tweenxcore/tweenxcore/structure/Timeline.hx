package tweenxcore.structure;
using tweenxcore.Tools;

class Timeline<T>
{
    public var totalWeight(default, null):Float;
    var dataArray:Array<T>;
    var weightArray:Array<Float>;

    public var length(get, null):Int;

    function get_length():Int
    {
        return dataArray.length;
    }

    public inline function new()
    {
        this.dataArray = [];
        this.weightArray = [];
        totalWeight = 0;
    }

    public inline function add(data:T, weight:Float = 1.0):Timeline<T>
    {
        if (weight <= 0) {
            throw "weight must be positive number";
        }
        if (dataArray.length == 0) {
            totalWeight = weight;
        } else {
            weightArray.push(totalWeight);
            totalWeight += weight;
        }
        dataArray.push(data);
        return this;
    }

    public inline function search(rate:Float, boundaryMode:BoundaryMode = BoundaryMode.High):TimelineSearchResult<T>
    {
        if (dataArray.length == 0) {
            throw "timeline is not initialized";
        }

        var searchResult = weightArray.binarySearch(rate * totalWeight, boundaryMode);
        var baseWeight = if (searchResult == 0) {
            0;
        } else {
            weightArray[searchResult - 1] / totalWeight;
        }

        var nextWeight = if (searchResult == dataArray.length - 1) {
            1;
        } else {
            weightArray[searchResult] / totalWeight;
        }

        return new TimelineSearchResult(
            dataArray[searchResult],
            searchResult,
            baseWeight,
            nextWeight
        );
    }

    public inline function dataAt(index:Int):T
    {
        if (dataArray.length == 0) {
            throw "timeline is not initialized";
        }
        return dataArray[index];
    }

    public inline function rangeLeft(index:Int):Float
    {
        if (index == 0)
        {
            return 0.0;
        }

        return weightArray[index - 1] / totalWeight;
    }

    public inline function rangeRight(index:Int):Float
    {
        if (index == dataArray.length)
        {
            return 1.0;
        }

        return weightArray[index] / totalWeight;
    }
}
