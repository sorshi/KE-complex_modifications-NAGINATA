# これはなに

Macにキーボード配列の[薙刀式](http://oookaworks.seesaa.net/article/456099128.html)を移植したものです。オリジナルはWindows用でベースはv11です。

Macでの動作は[Karabiner-Elements](https://pqrs.org/osx/karabiner/)が必要となります。

ノートパソコン内蔵キーボードでも利用可能です。

薙刀式は専用キーボードを要求せず、疲れにくく、覚えやすく、効率のよい日本語入力を目指して大岡俊彦さんによって2018年に開発されたものです。比較対象として並べられることの多い約40年前に開発された親指シフト(NICOLA配列)との相違点についてはこちらをご参考ください。
[【入力の話1】親指シフトよりいい方法が、少なくとも10個ある: 大岡俊彦の作品置き場](http://oookaworks.seesaa.net/article/456683570.html)

# インストール

1. まずKarabiner-Elementsをインストールしてください。

2. 次にこのプロジェクトに含まれるjapanese_naginata.jsonを~/.config/karabiner/assets/complex_modifications/に置きます。

3. メニューバーからKarabiner-Elementsの設定(Preferences...)を開いて、Complex ModificationsのRulesからAdd ruleを選びJapanese NAGINATA STYLE(v11)なんとか を選びEnableにします。

4. InputMethodの入力方式はローマ字入力にしてください。

5. 薙刀式の使い方はオリジナル版の詳しいガイドブックをご参考ください。[薙刀式v11完成版マニュアル.pdf](http://oookaworks.up.seesaa.net/image/E89699E58880E5BC8Fv11E5AE8CE68890E78988E3839EE3838BE383A5E382A2E383AB.pdf)

6. (横書き版との併用は下のカスタマイズの項目に記載しています)


# 実装済み機能

- 連続シフト (次の打鍵もセンターシフトを利用するときに、シフトを押したまま次のアクションを入力できる機能)
- 左右カーソル移動 (TキーとYキー)
- バックスペース (Uキーで機能はMacのdeleteキーと同等)
- 改行(V+Mキー同時押し)
- 英数(F+Gキー同時押し)、かな(H+Jキー同時押し)切り替え
- 編集モード1 移動、機能系
- 編集モード2 記号系

# カスタマイズ

japanese_naginata.json.rbを編集して

```
ruby ./japanese_naginata.json.rb > japanese_naginata.json
```

で出力できます。jsonをそのまま編集しても構いません。

カーソル移動や編集モードはオリジナル版のまま縦書き前提の配置となっているので横書きだと使いにくいところもあるかもしれません。次の例のように横書き用はhオプションを付けると矢印キーのアサインを変えた横書き版を出力します。
```
ruby ./japanese_naginata.json.rb h > japanese_naginata_h.json
```
配布状態で縦書き用の定義ファイルjapanese_naginata.jsonと横書き用定義ファイルjapanese_naginata_h.jsonの2つを同梱しています。

Karabiner-ElementsのProfileで縦書きと横書きの2つのプロファイルを作成してメニューから切り替えると使い分けが簡単です。

# ToDo

- オリジナルのWindows版薙刀式を使い込んでないので理解が間違っている箇所があるかもしれません。とくに編集モードは検証が怪しいです。ぜひご感想やプルリクお寄せください。

- JISキーボード以外は記号類が多分動作しません。適当にカスタマイズしてみてください。

# その他

- 薙刀式中断/再開のショートカット(Shift+Ctrl+0/Shift+Ctrl+1)は未実装です。メニューバーから操作してください。

- 機能モード1-YキーはオリジナルではHomeキーがアサインされていますが、Mac版ではMacのHomeキーではなく同じ動作となる行頭へ移動(Ctrl + a)をアサインしています。Endも同様です。基本的に他の機能も動作が同じとなるようなアサインを目指しています。

- 確定アンドゥと再変換はカナキー2回押しの同じ操作が割り当てられています。

- いまのところ「◯」「《」「》」の3記号は入力に対応していません。これはKarabiner-Elementsが入力する文字を入れ替える作りではなく、キー入力を再現する仕組みに由来するものです。
またエディタの構造(NSTextViewを利用しているかどうか?)によって入力できない記号があったり、旧ことえりから名前の変わった純正日本語入力だと入力できるけれども他のInputMethodだと入力できないなど環境依存が強いので入力できない場合には、文字から変換などをお試しください。入力可能記号についてはこの辺をご参考ください。[Mac 記号や特殊文字のキーボードショートカットまとめ（133種類） / Inforati](http://inforati.jp/apple/mac-tips-techniques/system-hints/how-to-use-special-characters-and-symbols-keyboard-shortcut-with-macos.html)

- キーボードショートカットについてはこの辺もご参考ください。[Mac のキーボードショートカット - Apple サポート](https://support.apple.com/ja-jp/HT201236)

- 実際に入力されているキーコードはLaunch Karabiner-EventViewerから起動できるEventViewerでご確認いただけます。

- 縦書きでの検証は純正のテキストエディットで行いました。この環境だと「文頭へ移動」(Cmd + →)のショートカットが他機能と衝突しているため動作しません。

- japanese_naginata.json.rbは[example_japanese_nicola.json.rb](https://github.com/pqrs-org/KE-complex_modifications/blob/master/src/json/example_japanese_nicola.json.rb)をベースに作成させていただきました。

