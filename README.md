# これはなに

Macにキーボード配列の[薙刀式](http://oookaworks.seesaa.net/article/456099128.html)を移植したものです。オリジナルはWindows用でベースはv11です。

Macでの動作は[Karabiner-Elements](https://pqrs.org/osx/karabiner/)が必要となります。

ノートパソコン内蔵キーボードでも利用可能です。

薙刀式は専用キーボードを要求せず、疲れにくく、覚えやすく、効率のよい日本語入力を目指して大岡俊彦さんによって2018年に開発されたものです。比較対象として並べられることの多い約40年前に開発された親指シフト(NICOLA配列)との相違点についてはこちらをご参考ください。
[【入力の話1】親指シフトよりいい方法が、少なくとも10個ある: 大岡俊彦の作品置き場](http://oookaworks.seesaa.net/article/456683570.html)

# インストール手順

1. Macのシステム環境設定→言語と地域→キーボード環境設定→入力ソース→＋→その他→「Unicode 16進数入力」を追加します。

   [Mac の「言語と地域」環境設定を変更する - Apple サポート](https://support.apple.com/ja-jp/guide/mac-help/intl163/mac )

   [入力ソースを使って Mac で別の言語を入力する - Apple サポート ](https://support.apple.com/ja-jp/guide/mac-help/mchlp1406/mac )

   ![Screenshot Unicode 16進数入力](https://pbs.twimg.com/media/EFkh70oUcAYOdNc?format=png)

2. キーマップ変更ユーティリティの[Karabiner-Elements](https://pqrs.org/osx/karabiner/)をインストールします。

3. 次にこのプロジェクトに含まれる/docs/json/japanese_naginata.jsonとjapanese_naginata_h.jsonの2つを~/.config/karabiner/assets/complex_modifications/に置きます。

4. メニューバーからKarabiner-Elementsの設定(Preferences...)を開いて、Complex ModificationsのRulesからAdd ruleを選びJapanese NAGINATA STYLE(v11)なんとか を選びEnableにします。(なんとかの部分には横書き版/縦書き版のHorizontal/Default(Vertical)やビルドタイムスタンプが入ります)

5. InputMethodの入力方式はローマ字入力に設定します。

6. 薙刀式の使い方はオリジナル版の詳しいガイドブックをご参考ください。[薙刀式v11完成版マニュアル.pdf](http://oookaworks.up.seesaa.net/image/E89699E58880E5BC8Fv11E5AE8CE68890E78988E3839EE3838BE383A5E382A2E383AB.pdf)

7. (横書き版との併用は下のカスタマイズの項目に記載しています)


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
ruby ./japanese_naginata.json.rb v > japanese_naginata.json
```

で出力できます。jsonをそのまま編集しても構いません。

カーソル移動や編集モードはオリジナル版のまま縦書き前提の配置となっているので横書きだと使いにくいところもあるかもしれません。次の例のように横書き用はhオプションを付けると矢印キーのアサインを変えた横書き版を出力します。
```
ruby ./japanese_naginata.json.rb h > japanese_naginata_h.json
```
配布状態で縦書き用の定義ファイルjapanese_naginata.jsonと横書き用定義ファイルjapanese_naginata_h.jsonの2つを同梱しています。横書き用の薙刀式配列図は原作者の大岡さんによってこちらで公開されています。[【薙刀式】横書き用](http://oookaworks.seesaa.net/article/467784995.html)

Karabiner-ElementsのProfileで縦書きと横書きの2つのプロファイルを作成してメニューから切り替えると使い分けが簡単です。

# ToDo

- オリジナルのWindows版薙刀式を使い込んでないので理解が間違っている箇所があるかもしれません。とくに編集モードは検証が怪しいです。ぜひご感想やプルリクお寄せください。
- JISキーボード以外は記号類が多分動作しません。適当にカスタマイズしてみてください。
- 〇,〈,〉,《,》のUnicode記号は変換確定後に入力してください。また微妙に入力タイミングにシビアなところがあります。その場合は何度か試してみてください。

# その他

- 薙刀式中断/再開のショートカット(Shift+Ctrl+0/Shift+Ctrl+1)は未実装です。メニューバーから操作してください。

- 固有名詞ショートカットは未実装です。

- [Google日本語入力](https://www.google.co.jp/ime/)だと中黒・や隅付き括弧【】などの一部記号が出せません。(旧称ことえりと異なりOptionスラッシュで中黒が出せないなど未アサインの記号が多数あるためです)

- 機能モード1-YキーはオリジナルではHomeキーがアサインされていますが、Mac版ではMacのHomeキーではなく同じ動作となる行頭へ移動(Ctrl + a)をアサインしています。Endも同様です。基本的に他の機能も動作が同じとなるようなアサインを目指しています。

- エディタの構造(NSTextViewを利用しているかどうか?)によって入力できない記号があったり、旧ことえりから名前の変わった純正日本語入力だと入力できるけれども他のInputMethodだと入力できないなど環境依存が強いので入力できない場合には、文字から変換などをお試しください。入力可能記号についてはこの辺をご参考ください。[Mac 記号や特殊文字のキーボードショートカットまとめ（133種類） / Inforati](http://inforati.jp/apple/mac-tips-techniques/system-hints/how-to-use-special-characters-and-symbols-keyboard-shortcut-with-macos.html)

- 再変換は効かないエディタもあります。

- キーボードショートカットについてはこの辺もご参考ください。[Mac のキーボードショートカット - Apple サポート](https://support.apple.com/ja-jp/HT201236)

- 実際に入力されているキーコードはLaunch Karabiner-EventViewerから起動できるEventViewerでご確認いただけます。

- 縦書きでの検証は純正のテキストエディットで行いました。この環境だと「文頭へ移動」(Cmd + →)のショートカットが他機能と衝突しているため動作しません。

- japanese_naginata.json.rbは[example_japanese_nicola.json.rb](https://github.com/pqrs-org/KE-complex_modifications/blob/master/src/json/example_japanese_nicola.json.rb)をベースに作成させていただきました。

- Mac版独自の拡張としてオリジナルでは未アサインだと思いこんでいたセンターシフト+Tに「え」、センターシフト+Yに「へ」を割り当ててる機能を付けたら、作者の大岡さんに

  > センターシフトTYには、←→のシフト、つまり行選択（縦書きの場合）が入ってます。[【薙刀式】Mac版に改造アイデアが。: 大岡俊彦の作品置き場](http://oookaworks.seesaa.net/article/470898497.html)

  と教えていただきましたので同じ動作のShift+矢印を実装しました。

  jsonを出力するときに2番目のオプションにmを指定すると、センターシフト+Tを「え」、センターシフト+Yを「へ」に入れ替えます。

  `ruby ./japanese_naginata.json.rb h m > japanese_naginata_h_m.json`

  Pキーの機能はそのままなので「え」はセンターシフト+Tでもセンターシフト+Pでも打てます。同様に「へ」はセンターシフト+YでもP単打でも打てます。替え指として使いやすい方を利用してください。
