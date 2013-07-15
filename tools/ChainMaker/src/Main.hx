package ;


import haxe.Resource;
import haxe.Template;
import neko.Lib;
import sys.io.File;

/**
 * ...
 * @author shohei909
 */

class Main {
	static var data:Array<Array<Dynamic>> = [
		//Sprite
		[0, "alpha" ],
		[0, "x" ],
		[0, "y" ],
		[0, "z" ],
		[0, "scaleX" ],
		[0, "scaleY" ],
		[0, "scaleZ" ],
		[0, "rotation" ],
		[0, "rotationX" ],
		[0, "rotationY" ],
		[0, "rotationZ" ],
		[0, "top" ],
		[0, "left" ],
		[0, "right" ],
		[0, "bottom" ],
		[0, "width" ],
		[0, "height" ],
		[0, "visible",				"Bool"],
		[0, "enabled",				"Bool"],
		[0, "doubleClickEnabled",	"Bool"],
		[0, "tabEnabled",			"Bool"],
		[0, "mouseEnabled",			"Bool"],
		[0, "mouseChildren",		"Bool"],
		[0, "tabChildren",			"Bool"],
		[1, "", "x", "y" ],
		[1, "scale", "X", "Y" ],
		[1, "rotation", "X", "Y" ],
		[2, "", "x", "y", "z" ],
		[2, "scale", "X", "Y", "Z" ],
		[2, "rotation", "X", "Y", "Z" ],
		
		//Matrix
		[0, "a" ],
		[0, "b" ],
		[0, "c" ],
		[0, "d" ],
		[0, "tx" ],
		[0, "ty" ],
		
		//ColorTransform
		[0, "alphaOffset" ],
		[0, "alphaMultiplier" ],
		[0, "redOffset" ],
		[0, "redMultiplier" ],
		[0, "greenOffset" ],
		[0, "greenMultiplier" ],
		[0, "blueOffset" ],
		[0, "blueMultiplier" ],
		
		//Filter
		[0, "blurX" ],
		[0, "blurY" ],
		[0, "highlightAlpha"],
		[0, "highlightColor",	"IntOrColor" ],
		[0, "shadowAlpha"],
		[0, "shadowColor",		"IntOrColor" ],
		[0, "strength"],
		[0, "quality"],
		[0, "color", 			"IntOrColor" ],
		[0, "angle" ],
		[0, "distance"],
		[0, "bias"],
		[0, "alphas", 			"Array<Float>" ],
		[0, "ratios",			"Array<Float>" ],
		[0, "knockout",			"Bool"],
		[0, "inner",			"Bool"],
		
		//Bitmap
		[0, "bitmapData", 		["Dynamic", "TimelineX"] ],
		
		//SoundTransform
		[0, "pan" ],
		[0, "volume" ],
		[0, "leftToLeft" ],
		[0, "leftToRight" ],
		[0, "rightToRight" ],
		[0, "rightToLeft" ],
		
	];
	
	static function main() {
		var top 		= new Template(Resource.getString( "top" ));
		var func1 		= new Template(Resource.getString( "func1" ));
		var func2 		= new Template(Resource.getString( "func2" ));
		var func3 		= new Template(Resource.getString( "func3" ));
		var str1 = "";
		var str2 = "";
		
		for ( d in data ) {
			switch( d[0] ) {
				case 0:{
					var name 	= d[1];
					
					var cl0 		= "Float"; 
					var cl1 		= "Float"; 
					
					if ( d.length > 2 ) {
						var el:Dynamic = d[2];
						if ( Std.is( el, String ) ) cl0 = cl1 = el;
						else if ( Std.is( el, Array ) ) {
							cl0 = el[0];
							cl1 = el[1];
						}
					}
					
					var t 		= '{var $name(null,null):$cl0;}';
					var it 		= 'Iterable<{var $name(null,null):$cl0;}>';
					
					str1 += func1.execute( { name: name, "class":cl1, t:t, method:"setTo", prefix:"" } );
					str2 += func1.execute( { name: name, "class":cl1, t:it, method:"setTo", prefix:"", array:true } );
					
					if ( cl1 == "Float" ) {
						str1 += func1.execute( { name: name, "class":cl1, t:t, method:"setRelativeTo", prefix:"_" } );
						str2 += func1.execute( { name: name, "class":cl1, t:it, method:"setRelativeTo", prefix:"_", array:true } );
						str1 += func1.execute( { name: name, "class":cl1, t:t, method:"setRelativeTo2", prefix:"__" } );
						str2 += func1.execute( { name: name, "class":cl1, t:it, method:"setRelativeTo2", prefix:"__", array:true } );
					}
				}
				case 1:{
					var name 	= d[1] + d[2] + d[3];
					var name1 	= d[1] + d[2];
					var name2 	= d[1] + d[3];
					var cl 		= (d.length > 4) ? d[4] : "Float"; 
					var t 		= '{var $name1(null,null):$cl;var $name2(null,null):$cl;}';
					var it 		= 'Iterable<{var $name1(null,null):$cl;var $name2(null,null):$cl;}>';
					str1 += func2.execute( { name: name, name1: name1, name2: name2, "class":cl, t:t, method:"setTo", prefix:"" } );
					str2 += func2.execute( { name: name, name1: name1, name2: name2, "class":cl, t:it, method:"setTo", prefix:"", array:true } );
					if ( cl == "Float" ) {
						str1 += func2.execute( { name: name, name1: name1, name2: name2, "class":cl, t:t, method:"setRelativeTo", prefix:"_" } );
						str2 += func2.execute( { name: name, name1: name1, name2: name2, "class":cl, t:it, method:"setRelativeTo", prefix:"_", array:true } );
						str1 += func2.execute( { name: name, name1: name1, name2: name2, "class":cl, t:t, method:"setRelativeTo2", prefix:"__" } );
						str2 += func2.execute( { name: name, name1: name1, name2: name2, "class":cl, t:it, method:"setRelativeTo2", prefix:"__", array:true } );
					}
				}
				case 2:{
					var name 	= d[1] + d[2] + d[3] + d[4];
					var name1 	= d[1] + d[2];
					var name2 	= d[1] + d[3];
					var name3 	= d[1] + d[4];
					
					var cl 		= (d.length > 5) ? d[5] : "Float"; 
					var t 		= '{var $name1(null,null):$cl;var $name2(null,null):$cl;var $name3(null,null):$cl;}';
					var it 		= 'Iterable<{var $name1(null,null):$cl;var $name2(null,null):$cl;var $name3(null,null):$cl;}>';
					
					str1 += func3.execute( { name: name, name1: name1, name2: name2, name3: name3, "class":cl, t:t, method:"setTo", prefix:"" } );
					str2 += func3.execute( { name: name, name1: name1, name2: name2, name3: name3, "class":cl, t:it, method:"setTo", prefix:"", array:true } );
					if ( cl == "Float" ) {
						str1 += func3.execute( { name: name, name1: name1, name2: name2, name3: name3, "class":cl, t:t, method:"setRelativeTo", prefix:"_" } );
						str2 += func3.execute( { name: name, name1: name1, name2: name2, name3: name3, "class":cl, t:it, method:"setRelativeTo", prefix:"_", array:true } );
						str1 += func3.execute( { name: name, name1: name1, name2: name2, name3: name3, "class":cl, t:t, method:"setRelativeTo2", prefix:"__" } );
						str2 += func3.execute( { name: name, name1: name1, name2: name2, name3: name3, "class":cl, t:it, method:"setRelativeTo2", prefix:"__", array:true } );
					}
				}
			}
		}
		
		var file = File.write( "ChainX.hx", false );
		file.writeString( top.execute( {content1:str1, content2:str2} ) );
		file.close();
	}
}