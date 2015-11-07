# TweenXCore

TweenXCoreはトゥイーンライブラリ**ではありません**。

TweenXCoreはトゥイーンライブラリが可能にするすべてのことを、トゥイーンライブラリは異なる方法で実現するためのライブラリです。

つまり、**気持ちの良いモーション**を簡単にプログラムで作ることを可能にします。

しかしTweenXCoreはトゥイーンライブラリとは異なり、バックグラウンドで何かが動いているということはありません。モーションのすべてを自分で管理します。
TweenXCoreはトゥイーンライブラリよりも汎用です。ただ単に自由に曲線を描いたり、幾何学的な計算をする用途でも使えます。
そして、TweenXCoreはトゥイーンライブラリよりも高速です。

TweenXCoreは、実行速度と開発速度とそしてモーションの面白さを両立するために作られています。



##　トゥイーンライブラリの問題点

すでにトゥイーンライブラリを十分に使っている多くの人は、トゥイーンライブラリというものがバグの温床になりやすいことに気づいていると思います。

例えば、同じオブジェクトに対して2つのトゥイーンが走ったときの挙動は、そのトゥイーンライブラリの詳細に把握していないとわかりません。
無限に繰り返すトゥイーンの削除を徹底したり、常にメモリリークを気にかけながら実装を行う必要があります。
イベントハンドラの取り扱いを間違えたことで、想定した実行順と異なる順序でコード実行されるかもしれません。

トゥイーンライブラリはとりあえず動くコードを書くのに便利で、プロトタイプや小さなゲームを作るのに向いていますが、製品版のプログラムに使うには心もとないです。


例えば、ゲームの場合、一時停止ボタンが押されたときにゲーム内のアニメーションをすべて一時停止した上で、さらにアニメーション付きでポップアップを表示させたいことがあります。
通信待ちのインジケータをアニメーション付きで実装する場合は、インジケータのフェードイン中に通信が終われば、フェードインの途中からフェードアウトに切り替えをしたいと思うはずです。

このような要求は、トゥイーンライブラリが苦手とする分野です。トゥイーンライブラリを十分に使っている方は、このような実装に苦しんだことがあるかと思います。


もちろんTweenXはそのような用途にも耐えうるように細心の注意をはらって設計していますが、それでもこういった動作を実装する場合は詳細の挙動にまで精通している必要ありますし、コードの量も複雑度も大きくなりがちです。

そういった理由のために、トゥイーンライブラリ自体を敬遠する人がいることも知っています。

わたし自身も気づけばTweenXのto関数のような自動で何かをやってくれるような機能は使わなくなり、TweenXのイージング関数を直接使ってモーションのコードを書くようになっていました。

そして、イージング関数に加えていくつかの関数を用意してあげれば、トゥイーンライブラリ以上の表現力と使い勝手の良さを手に入れられることがわかりました。

これがTweenXCoreの始まりです。


## 速度

既存のFlashプラットフォーム上で動作するトゥイーンライブラリとしておそらく最速であるBetweenAS3よりも、さらに高速に動作しています。


## 対応バージョン

Haxeの3.1.0以降での動作を確認しています。


## 0.0から始まり、1.0で終わる

TweenXCoreの世界では、始まりの値は0.0であり、終わりの値は1.0です。

つまり、モーションの時刻の場合、開始時刻は0.0で表し、終了時刻は1.0を使います。
アルファ値の場合、完全な透明は0.0で、完全な不透明は1.0です。
円の1周の場合、0度は0.0であり、360度は1.0です。
RGBカラーのRed値の場合、0.0が赤みが全くなく、1.0が完全な赤です。

TweenXCoreでは、このような0.0から1.0を基準とする値について`rate`という変数名をよく使います。

TODO:変数名をrateにするかは要検討。

TweenXCoreはトゥイーンライブラリではありません。、**この0.0から1.0を基準とする値を、上手にあやつるためのツール**だと考えてください。



## Hello TweenXCore

TweenXCoreの最初のサンプルとして四角のx座標を0から420まで、動かすコードを見てみます。

```haxe
import sample.SampleSuport.GridSprite;
import sample.SampleSuport.Square;
import openfl.events.Event;

import tweenxcore.structure.FloatChange;
using tweenxcore.tools.Tools;

class SampleSprite extends GridSprite {
    var square:Square;
    var frame = 0;

	public function new() {
		super();
        addChild(square = new Square(0, GridSprite.CELL_SIZE * 4));
        addEventListener(Event.ENTER_FRAME, onFrame);
    }

    // フレームごとに実行される。
    function onFrame(e:Event) {
        var change = new FloatChange(frame, frame += 1);
        change.part(0, 20).ifSome(updateSquare);
	}

    // 四角の位置を更新する。
    function updateSquare(change:FloatChange) {
        square.x = change.current.lerp(0, 420);
    }
}
```

[サンプルコード]

TweenXCoreの説明として重要なのは以下のコードです。

```
using tweenxcore.tools.Tools;
```

```
    // フレームごとに実行される。
    function onFrame(e:Event) {
        var change = new FloatChange(frame, frame += 1);
        change.part(0, 20).ifSome(updateSquare);
	}

    // 四角の位置を更新する。
    function updateSquare(change:FloatChange) {
        square.x = change.current.lerp(0, 420);
    }
```

それでは1つづつ要素を見ていきます。

`using tweenxcore.tools.Tools;`


## Easing関数

[swf]

[サンプルコード]

TweenXCoreでは、Robert Pennerのイージング関数を基本として、中央で減速して再度加速するInOutのモードと、瞬間的に移動を行うwarpが追加された計46個の関数が提供されています。

さて一般的なトゥイーンライブラリとの表面的な部分での違いはあまりありませんが、内部的には大きな違いがあります。

一般的なトゥイーンライブラリでは、cubicInの関数は以下の形です。

```
function cubicIn(t:Float, b:Float, c:Float, d:Float):Float {
    return c * (t /= d) * t * t + b;
}
```

この関数には4つの引数があり、それぞれ

* tは動き始めてからの経過時刻
* bは値の初期値
*　cは値の変化量
* dは完了までの時間

です。

そして、TweenXCoreでのeasing関数は以下の通りです。

```
function cubicIn(t:Float):Float {
    return t * t * t;
}
```

引数が1つだけになっています。一般的なものよりずっとシンプルです。

TweenXCoreの引数が1つしかない理由は明確です。先述の通り、TweenXCoreの世界では**始まりの値は0.0であり、終わりの値は1.0**だからです。このルールに従うと、元の4つの引数は以下のように考えることができます。

* tは、経過時刻を0.0から1.0までで表したもの
* 値の初期値は0.0
*　値の変化量は1.0
* 完了までの時間は1.0

つまり、TweenXCoreの世界では変数なのはtのみで、他は3つは定数と考えられます。

TweenXCoreの場合のEasing関数は、トゥイーン関数に渡すものではなく自分の手で使っていくものですから、引数が4つもあると小回りがきかず不便です。このように引数が1つになることで、Easing関数を直接あつかっても何をやっているのか明瞭でわかりやすくなります。

それでは、この関数を使って先述のサンプルコードにEasingをつけてみましょう。たった1行、以下のように変更を加えてみます。

```
        square.x = change.current.cubicIn().lerp(0, 420);
```

`change.current`の0.0から1.0までの値を、cubicIn()を使ってカーブをつけた後に、`lerp`関数で0から420の座標に変換しています。TweenXCoreを使用するコードでは、このようなFloatの値に対するメソッドチェーンがよく出てきます。

[swf]

[サンプルコード]


## Tools

### FloatTools

###　OptionTools
　
## FloatChange

## 並列のアニメーション、直列のアニメーション、時間差のアニメーション
