# これはなに

Macにキーボード配列の[薙刀式](http://oookaworks.seesaa.net/article/456099128.html)を移植したものです。オリジナルはWindows用です。ベースはv11です。

Macでの動作は[Karabiner-Elements](https://pqrs.org/osx/karabiner/)が必要となります。

# インストール

まずKarabiner-Elementsをインストールしてください。

次にこのプロジェクトに含まれるjapanese_naginata.jsonを~/.config/karabiner/assets/complex_modifications/に置きます。

そしてKarabiner-Elementsの設定を開いて、Complex ModificationsのRulesからAdd ruleを選びJapanese NAGINATA STYLEなんとかを選びEnableにします。

InputMethodの入力方式はローマ字入力にしてください。

# 実装済み機能

- 連続シフト
- 左右カーソル移動
- バックスペース(Macのdeleteキーと同等)
- 改行
- 英数、かな切り替え

# カスタマイズ

japanese_naginata.json.rbを編集して

```
ruby ./japanese_naginata.json.rb > japanese_naginata.json
```

で出力できます。jsonをそのまま編集しても構いません。

# ToDo

オリジナルのWindows版薙刀式を使ったことがないので理解が間違っている箇所があるかもしれません。

JISキーボード以外はまだ想定していません。

編集系メニューは未実装です。

これから薙刀式の練習を始めます。

# その他

japanese_naginata.json.rbは[example_japanese_nicola.json.rb](https://github.com/pqrs-org/KE-complex_modifications/blob/master/src/json/example_japanese_nicola.json.rb)をベースに作成させていただきました。