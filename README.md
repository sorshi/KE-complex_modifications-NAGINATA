# これはなに

Macにキーボード配列の[薙刀式](http://oookaworks.seesaa.net/article/456099128.html)を移植したものです。オリジナルはWindows用です。ベースはv11です。

Macでの動作は[Karabiner-Elements](https://pqrs.org/osx/karabiner/)が必要となります。

# インストール

1. まずKarabiner-Elementsをインストールしてください。

2. 次にこのプロジェクトに含まれるjapanese_naginata.jsonを~/.config/karabiner/assets/complex_modifications/に置きます。

3. そしてKarabiner-Elementsの設定を開いて、Complex ModificationsのRulesからAdd ruleを選びJapanese NAGINATA STYLEなんとか を選びEnableにします。

4. InputMethodの入力方式はローマ字入力にしてください。


# 実装済み機能

- 連続シフト
- 左右カーソル移動
- バックスペース(Macのdeleteキーと同等)
- 改行
- 英数、かな切り替え
- 編集モード2 記号系

# カスタマイズ

japanese_naginata.json.rbを編集して

```
ruby ./japanese_naginata.json.rb > japanese_naginata.json
```

で出力できます。jsonをそのまま編集しても構いません。

# ToDo

- オリジナルのWindows版薙刀式を使い込んでないので理解が間違っている箇所があるかもしれません。

- JISキーボード以外は多分動作しません。適当にカスタマイズしてみてください。

- 編集モード1 移動、機能系は未実装です。

# その他

- Karabiner-Elementsは文字を入力するわけではなく押下するキーを変更する種類のソフトウェアなため、薙刀式でアサインされていてもキー入力で入力できない記号類は非対応となります。またエディタの構造(NSTextViewを利用しているかどうか?)によって入力できない記号があったり、旧ことえりから名前の変わった純正日本語入力だと入力できるけれども他のInputMethodだと入力できないなど環境依存が強いので入力できなかったら適当に変更してみてください。入力可能記号についてはこの辺をご参考ください。[Mac 記号や特殊文字のキーボードショートカットまとめ（133種類） / Inforati](http://inforati.jp/apple/mac-tips-techniques/system-hints/how-to-use-special-characters-and-symbols-keyboard-shortcut-with-macos.html)

- japanese_naginata.json.rbは[example_japanese_nicola.json.rb](https://github.com/pqrs-org/KE-complex_modifications/blob/master/src/json/example_japanese_nicola.json.rb)をベースに作成させていただきました。