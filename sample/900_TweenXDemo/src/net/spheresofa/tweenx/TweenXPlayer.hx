package net.spheresofa.tweenx;

import haxe.Log;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Shape;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.text.TextFormat;
import tweenx909.EaseX;
import tweenx909.EventX;
import tweenx909.TweenX;
using tweenx909.ChainX;

class TweenXPlayer extends Sprite {
	static public inline var HEIGHT 	= 72;
	
    var pauseBtn:BitmapButton;
    var playBtn:BitmapButton;
    var backBtn:BitmapButton;
    var forwardBtn:BitmapButton;
    var btns:Array<BitmapButton>;
    var bar:ProgressBar;
    var selected:Int;
    var tween:TweenX;
    static var margin = 4;
    
    public function new( tween:TweenX, width:Float ) {
        super();

        this.tween = tween;
        
        //event
        tween.addEventListener( EventX.UPDATE, onUpdate );
        tween.addEventListener( EventX.STOP, onStop );
        
        //background
        var backFill = Assets.getBitmapData( "img/bar.png" );
        var fill = new Shape();
        var g = fill.graphics;
        g.beginBitmapFill( backFill );
        g.drawRect( 0, 0, width, TweenXPlayer.HEIGHT );
        addChild( fill );
        
        
        //button
        btns = [];
        var bx = -64;
        backBtn         = addButton( Assets.getBitmapData("img/back.png"), (bx += 64 + margin), back );
        pauseBtn        = addButton( Assets.getBitmapData("img/pause.png"), (bx += 64 + margin), pause );
        playBtn         = addButton( Assets.getBitmapData("img/play.png"), bx, play );
        forwardBtn      = addButton( Assets.getBitmapData("img/forward.png"), (bx += 64 + margin), forward );
        playBtn.visible = false;
        selected = 2;
        
        //bar
        bx += 64 + margin * 2;
        addChild( bar = new ProgressBar( width - bx - margin, TweenXPlayer.HEIGHT, tween ) );
        bar.x = bx;
    }
    
    function back() {
        if ( tween.currentTime <= 0 ) return;
        tween.timeScale = -16;
        tween.play();
        change( 0 );
    }
    function pause() {
        tween.timeScale = 0;
        tween.stop();
    }
    function play() {
        if ( tween.currentTime >= tween.totalTime ) return;
        tween.timeScale = 1;
        tween.play();
        change( 2 );
    }
    function forward() {
        if ( tween.currentTime >= tween.totalTime ) return;
        tween.timeScale = 16;
        tween.play();
        change( 3 );
    }
    
    function change( num:Int ) {
        if ( selected == num ) return;
        var count:Int = 0;
        var t = 0.1;
        var ease = EaseX.linear;
		
        for ( i in 0...btns.length ) {
            var b = btns[i];
            if ( i == num ) {
                b.draw();
                TweenX.to( b ).y( margin + TweenXPlayer.HEIGHT ).time( t ).ease( ease );
            }else {
                b.visible       = true;
                if( selected != i ){
                    TweenX.to( b ).x( margin + (64 + margin) * count ).time( t ).ease( ease );
                }else {
                    TweenX.from( b ).x( margin + (64 + margin) * count ).y( margin - TweenXPlayer.HEIGHT );
                    TweenX.to( b ).y( margin ).time( t ).ease( ease );
                }
                count++;
            }
        }
		
        selected = num;
		onUpdate(null);
    }
    
    function addButton( data, x, func ) {
        var btn;
        addChild( btn = new BitmapButton( data, func ) );
        btn.x = x;
        btn.y = margin;
        btns.push( btn );
        return btn;
    }
	
    function onStop( e ) { change( 1 ); }
    
    function onUpdate( e ) {
		for ( i in 0...btns.length )
			btns[i].mouseEnabled  = (i != selected);
			
		if ( tween.currentTime == 0 )                  backBtn.mouseEnabled = false;
        if ( tween.currentTime == tween.totalTime )    forwardBtn.mouseEnabled = playBtn.mouseEnabled = false;
        for ( b in btns ) b.draw();

        bar.update( tween.currentTime / tween.totalTime );
    }
}

private class BitmapButton extends Sprite {
    var texture:Shape;
    var onClick:Void->Void;
	
    public function new( data:BitmapData, onClick:Void->Void ) {
        super();

        texture = new Shape();
        addChild( texture );
        draw();
        
        addChild( new Bitmap( data ) );
        
		this.onClick = onClick;
        addEventListener( MouseEvent.MOUSE_DOWN, f );
    }
    
	public function f(e) {
		onClick(); 
	}
    public function draw() {
        var g = texture.graphics;
        g.clear();
        
        if( mouseEnabled ){
            var backFill = Assets.getBitmapData( "img/bar.png" );
            g.lineStyle( 1, 0x444444, 0.8 );
            g.beginBitmapFill( backFill );
            g.drawRect( 0, 0, 64, 64 );
        }else {
            var backFill = Assets.getBitmapData( "img/bar_disable.png" );
            g.lineStyle( 1, 0x444444, 0.8 );
            g.beginBitmapFill( backFill );
            g.drawRect( 0, 0, 64, 64 );
        }
    }
}

private class ProgressBar extends Sprite {
    static var thumbWidth:Float     = 40;
    
    var right:Float;
    var left:Float;
    var length:Float;
    
    var bar:Sprite;
    var thumb:Thumb;
    var tween:TweenX;
    var w:Float;
    var time:Float;
    
    public function new( w:Float, h:Float, tween:TweenX ) {
        super();

        this.w = w;
        this.tween = tween;
        var thick = 11;
        bar = new Sprite();
        addChild( bar );
        
        var g = bar.graphics;
        g.lineStyle( 1, 0x444444, 0.8 );
        g.beginFill( 0xFFFFFF );
        g.drawRoundRect( right = (thumbWidth / 2), (h - thick) / 2, length = (w - thumbWidth), thick, 10, 10 );
        left = length + right;
        bar.addEventListener( MouseEvent.MOUSE_DOWN, onClick );
        
        addChild( thumb = new Thumb( thumbWidth ) );
        thumb.y = h / 2;
        addEventListener( Event.ADDED_TO_STAGE, addedToStage );
        addEventListener( Event.REMOVED_FROM_STAGE, removedFromStage );
        thumb.addEventListener( MouseEvent.MOUSE_DOWN, onThumbDown );
        update(0);
    }
    
    
    public function update( t:Float ) {
        if ( thumbDown ) return;
        time = t;
        thumb.x = right + length * t;
    }
    
    function addedToStage(e) {
        stage.addEventListener( MouseEvent.MOUSE_UP, onThumbUp );
        stage.addEventListener( MouseEvent.MOUSE_MOVE, onThumbMove );
    }
    
    function removedFromStage(e) {
        stage.removeEventListener( MouseEvent.MOUSE_UP, onThumbUp );
        stage.removeEventListener( MouseEvent.MOUSE_MOVE, onThumbMove );
    }
    
    function onClick(e) {
		tween.goto( tween.totalTime * (mouseX - right) / length );
    }
    
    var thumbDown:Bool;
    var startPos:Float;
    var playing:Bool;
    function onThumbUp(e) {
        if (! thumbDown ) return;
        thumbDown = false;
        var x = (length * time) + mouseX - startPos;
        tween.play();
        tween.goto( tween.totalTime * (x / length) ); 
    }
    function onThumbDown(e) { 
        thumbDown = true;
        playing = tween.playing;
        tween.stop();
        startPos = mouseX; 
    }
    function onThumbMove(e) { 
        if (! thumbDown ) return;
        var x = (right + length * time) + mouseX - startPos;
        if ( x < right ) x = right;
        if ( x > left ) x = left;
        thumb.x = x;
    }
}

private class Thumb extends Sprite {
    public function new( width:Float ) {
        super();

        var shape = new Shape();
        var g = shape.graphics;
        g.lineStyle( 1, 0x444444, 0.8 );
        g.beginBitmapFill( Assets.getBitmapData( "img/bar_disable.png" ) );
        g.drawRect( 0, 0, width, 64 );
        addChild( shape );
        shape.x = -width / 2;
        shape.y = -32;
    }
}