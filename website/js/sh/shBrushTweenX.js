;(function ()
{
	// CommonJS
	SyntaxHighlighter = SyntaxHighlighter || (typeof require !== 'undefined'? require('shCore').SyntaxHighlighter : null);

	function Brush ()
	{

		var inits = 'class interface package macro enum typedef extends implements dynamic in for if while else do try switch case catch';

		var keywords = 'return break continue new throw cast using import function public private inline static untyped callback true false null';
		var className = "Int Float String Void Std Bool Dynamic Array Vector TweenX EaseX ChainX DefaultsX UpdateModeX RgbX HsvX";

		
		this.regexList = [
			{ regex:SyntaxHighlighter.regexLib.singleLineCComments , css:'comments' },
			// one line comments
			{ regex:SyntaxHighlighter.regexLib.multiLineCComments , css:'comments' },
			// multiline comments
			{ regex:SyntaxHighlighter.regexLib.doubleQuotedString , css:'string' },
			// double quoted strings
			{ regex:SyntaxHighlighter.regexLib.singleQuotedString , css:'string' },
			// single quoted strings
			{ regex:/\b([\d]+(\.[\d]+)?|0x[a-f0-9]+)\b/gi , css:'value' },
			// numbers
			{ regex:new RegExp ( this.getKeywords ( inits ) , 'gm' ) , css:'color3' },
			// initializations
			{ regex:new RegExp ( this.getKeywords ( keywords ) , 'gm' ) , css:'keyword' },
			// className
			{ regex:new RegExp ( this.getKeywords ( className ) , 'gm' ) , css:'color2' },
			// keywords
			{ regex:new RegExp ( 'var' , 'gm' ) , css:'variable' },
			// variable
			{ regex:new RegExp ( 'trace' , 'gm' ) , css:'color1' },
			//compiler conditionals
			{ regex:new RegExp ( '#if' , 'gm' ) , css:'comments' },
			{ regex:new RegExp ( '#elseif' , 'gm' ) , css:'comments' },
			{ regex:new RegExp ( '#end' , 'gm' ) , css:'comments' },
			{ regex:new RegExp ( '#error' , 'gm' ) , css:'comments' }
		];
		
		this.forHtmlScript ( SyntaxHighlighter.regexLib.scriptScriptTags );
	}

	;

	Brush.prototype = new SyntaxHighlighter.Highlighter ();
	Brush.aliases = ['haxe', 'hx'];

	SyntaxHighlighter.brushes.Haxe = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
}) ();
