#!/usr/bin/env ruby
#
# You can generate json by executing the following command on Terminal.
#
# $ ruby ./japanese_naginata.json.rb > ../../docs/json/japanese_naginata.json
#
# Horizontal Version
# $ ruby ./japanese_naginata.json.rb h > ../../docs/json/japanese_naginata_h.json
#
# This script made based example_japanese_nicola.json.rb.
#
#
#
# This software based on カナ配列「薙刀式」
# http://oookaworks.seesaa.net/article/456099128.html
#
# This Mac porting version hosted on https://github.com/sorshi/KE-complex_modifications-NAGINATA
# made by DCC-JPL Japan/Sorshi

require 'json'
require 'date'

require_relative '../lib/karabiner.rb'

########################################
# キーコード(親指シフトと違ってそのまんまだから意味ないな…)
if ARGV[0] == 'h' then
  #横書きキーアサイン
  LEFT_ARROW = 'down_arrow'.freeze
  RIGHT_ARROW = 'up_arrow'.freeze
  UP_ARROW = 'left_arrow'.freeze
  DOWN_ARROW = 'right_arrow'.freeze
  MODE = 'Horizontal'.freeze
else
  #デフォルト(縦書き)キーアサイン
  LEFT_ARROW = 'left_arrow'.freeze
  RIGHT_ARROW = 'right_arrow'.freeze
  UP_ARROW = 'up_arrow'.freeze
  DOWN_ARROW = 'down_arrow'.freeze
  MODE = 'Default(Vertical)'.freeze
end
ALWAYS_LEFT_ARROW = 'left_arrow'.freeze
ALWAYS_RIGHT_ARROW = 'right_arrow'.freeze
ALWAYS_UP_ARROW = 'up_arrow'.freeze
ALWAYS_DOWN_ARROW = 'down_arrow'.freeze
SPACEBAR = 'spacebar'.freeze
BACK_SPACE = 'delete_or_backspace'.freeze
ENTER = 'return_or_enter'.freeze
HYPHEN = 'hyphen'.freeze
COMMA = 'comma'.freeze
PERIOD = 'period'.freeze
SEMICOLON = 'semicolon'.freeze
COLON = 'quote'.freeze
SLASH = 'slash'.freeze
HOME = 'home'.freeze
ENDKEY = 'end'.freeze
LEFT_CORNER_BRACKET = 'close_bracket'.freeze #このへんJISで認識されてないキーボードだと変わる
RIGHT_CORNER_BRACKET = 'backslash'.freeze #このへんJISで認識されてないキーボードだと変わる
YEN = 'international3'.freeze
PAGEUP = 'page_up'.freeze
PAGEDOWN = 'page_down'.freeze
ESC = 'escape'.freeze

JPN = 'lang1'.freeze
ENG = 'lang2'.freeze
########################################
# 有効になる条件

CONDITIONS = [
  Karabiner.input_source_if([
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.Hiragana',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.Katakana',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.HalfWidthKana',
    },
  ]),
  Karabiner.frontmost_application_unless(['loginwindow']),
].freeze

# 連続シフト用
CONDITIONS_SHIFT = [
  Karabiner.input_source_if([
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.Hiragana',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.Katakana',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.HalfWidthKana',
    },
  ]),
  Karabiner.frontmost_application_unless(['loginwindow']),
  {
    'type' =>'variable_if',
    'name' => 'shifted',
    'value' =>  1
  }
].freeze

########################################
# ローマ字入力の定義

def key(key_code)
  {
    'key_code' => key_code,
    'repeat' => false,
  }
end

def key_with_repeat(key_code)
  {
    'key_code' => key_code,
    'repeat' => true,
  }
end

def key_with_control(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_control',
    ],
    'repeat' => false,
  }
end

def key_with_control_shift(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_control',
      'left_shift'
    ],
    'repeat' => false,
  }
end

def key_with_shift(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_shift',
    ],
    'repeat' => false,
  }
end

def key_with_option(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_alt',
    ],
    'repeat' => false,
  }
end

def key_with_option_shift(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_shift',
      'left_alt'
    ],
    'repeat' => false,
  }
end

def key_with_command(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_gui'
    ],
    'repeat' => false,
  }
end

def key_with_command_shift(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_shift',
      'left_gui'
    ],
    'repeat' => false,
  }
end

ROMAN_MAP = {
  'あ' => [key('a')],
  'い' => [key('i')],
  'う' => [key('u')],
  'え' => [key('e')],
  'お' => [key('o')],
  'か' => [key('k'), key('a')],
  'き' => [key('k'), key('i')],
  'く' => [key('k'), key('u')],
  'け' => [key('k'), key('e')],
  'こ' => [key('k'), key('o')],
  'さ' => [key('s'), key('a')],
  'し' => [key('s'), key('i')],
  'す' => [key('s'), key('u')],
  'せ' => [key('s'), key('e')],
  'そ' => [key('s'), key('o')],
  'た' => [key('t'), key('a')],
  'ち' => [key('t'), key('i')],
  'つ' => [key('t'), key('u')],
  'て' => [key('t'), key('e')],
  'と' => [key('t'), key('o')],
  'な' => [key('n'), key('a')],
  'に' => [key('n'), key('i')],
  'ぬ' => [key('n'), key('u')],
  'ね' => [key('n'), key('e')],
  'の' => [key('n'), key('o')],
  'は' => [key('h'), key('a')],
  'ひ' => [key('h'), key('i')],
  'ふ' => [key('h'), key('u')],
  'へ' => [key('h'), key('e')],
  'ほ' => [key('h'), key('o')],
  'ま' => [key('m'), key('a')],
  'み' => [key('m'), key('i')],
  'む' => [key('m'), key('u')],
  'め' => [key('m'), key('e')],
  'も' => [key('m'), key('o')],
  'や' => [key('y'), key('a')],
  'ゆ' => [key('y'), key('u')],
  'よ' => [key('y'), key('o')],
  'ら' => [key('r'), key('a')],
  'り' => [key('r'), key('i')],
  'る' => [key('r'), key('u')],
  'れ' => [key('r'), key('e')],
  'ろ' => [key('r'), key('o')],
  'わ' => [key('w'), key('a')],
  'を' => [key('w'), key('o')],
  'ん' => [key('n'), key('n')],
  'ゃ' => [key('x'), key('y'), key('a')],
  'ゅ' => [key('x'), key('y'), key('u')],
  'ょ' => [key('x'), key('y'), key('o')],
  'ぁ' => [key('x'), key('a')],
  'ぃ' => [key('x'), key('i')],
  'ぅ' => [key('x'), key('u')],
  'ぇ' => [key('x'), key('e')],
  'ぉ' => [key('x'), key('o')],
  'っ' => [key('x'), key('t'), key('u')],
  'ゎ' => [key('x'), key('w'), key('a')],
  'が' => [key('g'), key('a')],
  'ぎ' => [key('g'), key('i')],
  'ぐ' => [key('g'), key('u')],
  'げ' => [key('g'), key('e')],
  'ご' => [key('g'), key('o')],
  'ざ' => [key('z'), key('a')],
  'じ' => [key('z'), key('i')],
  'ず' => [key('z'), key('u')],
  'ぜ' => [key('z'), key('e')],
  'ぞ' => [key('z'), key('o')],
  'だ' => [key('d'), key('a')],
  'ぢ' => [key('d'), key('i')],
  'づ' => [key('d'), key('u')],
  'で' => [key('d'), key('e')],
  'ど' => [key('d'), key('o')],
  'ば' => [key('b'), key('a')],
  'び' => [key('b'), key('i')],
  'ぶ' => [key('b'), key('u')],
  'べ' => [key('b'), key('e')],
  'ぼ' => [key('b'), key('o')],
  'ぱ' => [key('p'),key('a')],
  'ぴ' => [key('p'),key('i')],
  'ぷ' => [key('p'),key('u')],
  'ぺ' => [key('p'),key('e')],
  'ぽ' => [key('p'),key('o')],
  'ヴ' => [key('v'), key('u')],
  'きゃ' => [key('k'), key('y'), key('a')],
  'きゅ' => [key('k'), key('y'), key('u')],
  'きょ' => [key('k'), key('y'), key('o')],
  'しゃ' => [key('s'), key('y'), key('a')],
  'しゅ' => [key('s'), key('y'), key('u')],
  'しょ' => [key('s'), key('y'), key('o')],
  'ちゃ' => [key('t'), key('y'), key('a')],
  'ちゅ' => [key('t'), key('y'), key('u')],
  'ちょ' => [key('t'), key('y'), key('o')],
  'にゃ' => [key('n'), key('y'), key('a')],
  'にゅ' => [key('n'), key('y'), key('u')],
  'にょ' => [key('n'), key('y'), key('o')],
  'ひゃ' => [key('h'), key('y'), key('a')],
  'ひゅ' => [key('h'), key('y'), key('u')],
  'ひょ' => [key('h'), key('y'), key('o')],
  'ぴゃ' => [key('p'), key('y'), key('a')],
  'ぴゅ' => [key('p'), key('y'), key('u')],
  'ぴょ' => [key('p'), key('y'), key('o')],
  'みゃ' => [key('m'), key('y'), key('a')],
  'みゅ' => [key('m'), key('y'), key('u')],
  'みょ' => [key('m'), key('y'), key('o')],
  'ぎゃ' => [key('g'), key('y'), key('a')],
  'ぎゅ' => [key('g'), key('y'), key('u')],
  'ぎょ' => [key('g'), key('y'), key('o')],
  'ぎぃ' => [key('g'), key('y'), key('i')],
  'ぎぇ' => [key('g'), key('y'), key('e')],
  'じゃ' => [key('z'), key('y'), key('a')],
  'じゅ' => [key('z'), key('y'), key('u')],
  'じょ' => [key('z'), key('y'), key('o')],
  'じぃ' => [key('j'), key('y'), key('i')],
  'じぇ' => [key('j'), key('y'), key('e')],
  'ぢゃ' => [key('d'), key('y'), key('a')],
  'ぢゅ' => [key('d'), key('y'), key('u')],
  'ぢょ' => [key('d'), key('y'), key('o')],
  'ぢぃ' => [key('d'), key('y'), key('i')],
  'ぢぇ' => [key('d'), key('y'), key('e')],
  'びゃ' => [key('b'), key('y'), key('a')],
  'びゅ' => [key('b'), key('y'), key('u')],
  'びょ' => [key('b'), key('y'), key('o')],
  'びぃ' => [key('b'), key('y'), key('i')],
  'びぇ' => [key('b'), key('y'), key('e')],
  'てぃ' => [key('t'), key('h'), key('i')],
  'てゅ' => [key('t'), key('h'), key('u')],
  'でぃ' => [key('d'), key('h'), key('i')],
  'でゅ' => [key('d'), key('h'), key('u')],
  'でゃ' => [key('d'), key('h'), key('a')],
  'でぇ' => [key('d'), key('h'), key('e')],
  'でょ' => [key('d'), key('h'), key('o')],
  'とぅ' => [key('t'), key('w'), key('u')],
  'どぅ' => [key('d'), key('w'), key('u')],
  'ヴぁ' => [key('v'), key('a')],
  'ヴぃ' => [key('v'), key('i')],
  'ヴぇ' => [key('v'), key('e')],
  'ヴぉ' => [key('v'), key('o')],
  'ヴゃ' => [key('v'), key('y'), key('a')],
  'ヴゅ' => [key('v'), key('y'), key('u')],
  'ヴょ' => [key('v'), key('y'), key('o')],
  'つぁ' => [key('t'), key('s'), key('a')],
  'つぃ' => [key('t'), key('s'), key('i')],
  'つぇ' => [key('t'), key('s'), key('e')],
  'つぉ' => [key('t'), key('s'), key('o')],
  'ふぁ' => [key('f'), key('a')],
  'ふぃ' => [key('f'), key('i')],
  'ふぇ' => [key('f'), key('e')],
  'ふぉ' => [key('f'), key('o')],
  'ふゅ' => [key('f'), key('y'), key('u')],
  'しぇ' => [key('s'), key('y'), key('e')],
  'ちぇ' => [key('t'), key('y'), key('e')],
  'いぇ' => [key('y'), key('e')],
  'うぁ' => [key('w'),key('h'),key('a')],
  'うぃ' => [key('w'),key('h'),key('i')],
  'うぇ' => [key('w'),key('h'),key('e')],
  'うぉ' => [key('w'),key('h'),key('o')],
  'りゃ' => [key('r'),key('y'),key('a')],
  'りぃ' => [key('r'),key('y'),key('i')],
  'りゅ' => [key('r'),key('y'),key('u')],
  'りぇ' => [key('r'),key('y'),key('e')],
  'りょ' => [key('r'),key('y'),key('o')],
  'ー' => [key(HYPHEN)],
  '、' => [key(COMMA)],
  '。' => [key(PERIOD)],
  '削' => [key_with_repeat(BACK_SPACE)],
  '→' => [key(RIGHT_ARROW)],
  '←' => [key(LEFT_ARROW)],
  '改' => [key(ENTER)],
  '英' => [key(ENG)],
  '仮' => [key(JPN)],
  '。改' => [key(PERIOD),key(ENTER)],
  #編集モード1定義
  '文末' => [key_with_command(LEFT_ARROW)],
  '文頭' => [key_with_command(RIGHT_ARROW)],
  '十字目' => [key_with_control('a'),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW)],
  'リドゥ' => [key_with_command_shift('z')],
  '保存' => [key_with_command('s')],
  '頁下' => [key(PAGEDOWN)],
  '頁上' => [key(PAGEUP)],
  '二十字目' => [key_with_control('a'),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW)],
  'アンドゥ' => [key_with_command('z')],
  'カット' => [key_with_command('x')],
  'コピー' => [key_with_command('c')],
  'ペースト' => [key_with_command('v')],
  '三十字目' => [key_with_control('a'),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW)],

  '行頭' => [key_with_control('a')],
  '行末削除' => [key_with_control('k')], #カーソル位置から行末まで削除
  '再変換' => [key_with_option_shift('r')],
  '削除' => [key_with_control('d')],
  '入力撤回' => [key(ESC),key(ESC)],
  '確定エンド' => [key(ENTER),key_with_control('e')],
  '上矢印' => [key(UP_ARROW)],
  'シフト上矢印' => [key_with_shift(UP_ARROW)],
  '五上矢印' => [key(UP_ARROW),key(UP_ARROW),key(UP_ARROW),key(UP_ARROW),key(UP_ARROW)],
  'カタカナに' => [key_with_control('k')],
  '行末' => [key_with_control('e')],
  '下矢印' => [key(DOWN_ARROW)],
  'シフト下矢印' => [key_with_shift(DOWN_ARROW)],
  '五下矢印' => [key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW),key(DOWN_ARROW)],
  'ひらがなに' => [key_with_control('j')],

  #編集モード2定義
  '／改' => [key(SLASH),key(ENTER)],
  '：改' => [key(COLON),key(ENTER)],
  '・改' => [key_with_option(SLASH),key(ENTER)],
  '○改' => [key('s'), key('i'),key('r'), key('o'),key('m'), key('a'),key('r'), key('u')],
  '行頭空白改' => [key_with_control('a'),key(SPACEBAR),key(ENTER),key_with_control('e')],

  '【改' => [key_with_option('8'),key(ENTER)],
  '〈改' => [key_with_option_shift('3'),key(ENTER)],
  '！改' => [key_with_shift('1'),key(ENTER)],
  '？改' => [key_with_shift(SLASH),key(ENTER)],
  '行頭空白三改' => [key_with_control('a'),key(SPACEBAR),key(SPACEBAR),key(SPACEBAR),key(ENTER),key_with_control('e')],

  '】改' => [key_with_option('9'),key(ENTER)],
  '〉改' => [key_with_option_shift('4'),key(ENTER)],
  '……改' => [key_with_option(SEMICOLON),key_with_option(SEMICOLON),key(ENTER)],
  '──改' => [key_with_option_shift(HYPHEN),key_with_option_shift(HYPHEN),key(ENTER)],
  '三空白' => [key(SPACEBAR),key(SPACEBAR),key(SPACEBAR)],

  '」改改空' => [key(RIGHT_CORNER_BRACKET),key(ENTER),key(ENTER),key(SPACEBAR)],
  '行頭削除' => [key_with_command_shift(UP_ARROW),key_with_repeat(BACK_SPACE)], #カーソル位置から行頭まで削除
  '確定復行' => [key(JPN),key(JPN)],#再変換と同一
  '縦棒改' => [key_with_shift(YEN),key(ENTER)],
  'ルビ' => [key_with_shift(YEN),key(ENTER),key('k'),key('a'),key('k'),key('k'),key('o')],#入力不可能

  '」改「' => [key(RIGHT_CORNER_BRACKET),key(ENTER),key(ENTER),key(LEFT_CORNER_BRACKET),key(ENTER)],
  '「改' => [key(LEFT_CORNER_BRACKET),key(ENTER),],
  '『改' => [key_with_shift(LEFT_CORNER_BRACKET),key(ENTER)],
  '《改' => [key('k'),key('a'),key('k'),key('k'),key('o')],#入力不可能
  '（改' => [key_with_shift('8'),key(ENTER)],

  '」改改' => [key(RIGHT_CORNER_BRACKET),key(ENTER),key(ENTER)],
  '」改' => [key(RIGHT_CORNER_BRACKET),key(ENTER)],
  '』改' => [key_with_shift(RIGHT_CORNER_BRACKET),key(ENTER)],
  '》改' => [key('k'),key('a'),key('k'),key('k'),key('o')],#入力不可能
  '）改' => [key_with_shift('9'),key(ENTER)],

}.freeze
########################################

def main
  now = Time.now.to_i
  puts JSON.pretty_generate(
    'title' => 'Japanese NAGINATA STYLE (v11)',
    'rules' => [
      {
        'description' => "Japanese NAGINATA STYLE (v11) #{MODE} Build #{now} ",
        'manipulators' => [
          # 同時打鍵数の多いものから書く
          shiftkeydef(),#連続シフト用定義
          #編集モード1定義
          editmode_one_left('q','文末'),
          editmode_one_left('w','文頭'),
          # E,Rは未使用
          editmode_one_left('t','十字目'),
          editmode_one_left('a','リドゥ'),#shift + command + z
          editmode_one_left('s','保存'),
          editmode_one_left('d','頁下'),
          editmode_one_left('f','頁上'),
          editmode_one_left('g','二十字目'),
          editmode_one_left('z','アンドゥ'),
          editmode_one_left('x','カット'),
          editmode_one_left('c','コピー'),
          editmode_one_left('v','ペースト'),
          editmode_one_left('b','三十字目'),
          editmode_one_right('y','行頭'),
          editmode_one_right('u','行末削除'),
          editmode_one_right('i','再変換'),
          editmode_one_right('o','削除'),
          editmode_one_right('p','入力撤回'),
          editmode_one_right('h','確定エンド'),
          editmode_one_right('j','上矢印'),
          editmode_one_right('k','シフト上矢印'),
          editmode_one_right('l','五上矢印'),
          editmode_one_right(SEMICOLON,'カタカナに'),
          editmode_one_right('n','行末'),
          editmode_one_right('m','下矢印'),
          editmode_one_right(COMMA,'シフト下矢印'),
          editmode_one_right(PERIOD,'五下矢印'),
          editmode_one_right(SLASH,'ひらがなに'),
          #編集モード2定義
          editmode_two_left('q','／改'),
          editmode_two_left('w','：改'),
          editmode_two_left('e','・改'),
          editmode_two_left('r','○改'),
          editmode_two_left('t','行頭空白改'),
          editmode_two_left('a','【改'),
          editmode_two_left('s','〈改'),
          editmode_two_left('d','！改'),
          editmode_two_left('f','？改'),
          editmode_two_left('g','行頭空白三改'),
          editmode_two_left('z','】改'),
          editmode_two_left('x','〉改'),
          editmode_two_left('c','……改'),
          editmode_two_left('v','──改'),
          editmode_two_left('b','三空白'),
          editmode_two_right('y','」改改空'),
          editmode_two_right('u','行頭削除'),
          editmode_two_right('i','確定復行'),#確定Undo
          editmode_two_right('o','縦棒改'),
          editmode_two_right('p','ルビ'),
          editmode_two_right('h','」改「'),
          editmode_two_right('j','「改'),
          editmode_two_right('k','『改'),
          editmode_two_right('l','《改'),
          editmode_two_right(SEMICOLON,'（改'),
          editmode_two_right('n','」改改'),
          editmode_two_right('m','」改'),
          editmode_two_right(COMMA,'』改'),
          editmode_two_right(PERIOD,'》改'),
          editmode_two_right(SLASH,'）改'),
          # 3同時打鍵
          # 小書き： シフト半濁音同時押し
          three_keys(SPACEBAR,'v','j','ぁ'),
          three_keys(SPACEBAR,'v','k','ぃ'),
          three_keys(SPACEBAR,'v','l','ぅ'),
          three_keys(SPACEBAR,'v','p','ぇ'),
          three_keys(SPACEBAR,'v','n','ぉ'),
          three_keys(SPACEBAR,'v',SEMICOLON,'ゃ'),
          three_keys(SPACEBAR,'v','o','ゅ'),
          three_keys(SPACEBAR,'v','i','ょ'),
          three_keys(SPACEBAR,'v','h','ゎ'),
          # シフト「りゅ」のみ「てゅ」に定義
          three_keys(SPACEBAR, 'e','o','てゅ'),
          three_keys('s','j',SEMICOLON,'ぎゃ'),
          three_keys('r','j',SEMICOLON,'じゃ'),
          three_keys('g','j',SEMICOLON,'ぢゃ'),
          three_keys('x','j',SEMICOLON,'びゃ'),
          three_keys('s','j','o','ぎゅ'),
          three_keys('r','j','o','じゅ'),
          three_keys('g','j','o','ぢゅ'),
          three_keys('x','j','o','びゅ'),
          three_keys('s','j','i','ぎょ'),
          three_keys('r','j','i','じょ'),
          three_keys('g','j','i','ぢょ'),
          three_keys('x','j','i','びょ'),
          # じゅぎゅが打ちにくいので、例外的に半濁音キーでもオーケーとする
          three_keys('r','m','i','じょ'),
          three_keys('r','m',SEMICOLON,'じゃ'),
          three_keys('r','m','o','じゅ'),
          three_keys('s','m','i','ぎょ'),
          three_keys('s','m',SEMICOLON,'ぎゃ'),
          three_keys('s','m','o','ぎゅ'),
          three_keys('g','m','i','ぢょ'),
          three_keys('g','m',SEMICOLON,'ぢゃ'),
          three_keys('g','m','o','ぢゅ'),
          three_keys('x','j','i','びょ'),
          three_keys('x','j','o','びゅ'),
          # 半濁音ゃゅょは「ぴ」のみ
          three_keys('x','m','i','ぴょ'),
          three_keys('x','m',SEMICOLON,'ぴゃ'),
          three_keys('x','m','o','ぴゅ'),
          three_keys('e','j','o','でゅ'),
          three_keys('r','j','p','じぇ'),
          three_keys('g','j','p','ぢぇ'),
          three_keys('e','j','k','でぃ'),
          three_keys('d','j','l','どぅ'),
          #ツァ行は「う」「つ」が同じキーにあるためシフトを押しながら
          three_keys(SPACEBAR, 'l','j','つぁ'),
          three_keys(SPACEBAR, 'l','k','つぃ'),
          three_keys(SPACEBAR, 'l','p','つぇ'),
          three_keys(SPACEBAR, 'l','n','つぉ'),
          # ------------------------------
          # 2同時打鍵
          # 右手濁点
          two_keys('u','f','ざ'),
          two_keys('o','f','ず'),
          two_keys('p','f','べ'),
          two_keys('h','f','ぐ'),
          two_keys('l','f','づ'),
          two_keys('n','f','だ'),
          two_keys(PERIOD,'f','ぶ'),
          # 左手濁点
          two_keys('s','j','ぎ'),
          two_keys('e','j','で'),
          two_keys('r','j','じ'),
          two_keys('z','j','ぼ'),
          two_keys('c','j','げ'),
          two_keys('d','j','ど'),
          two_keys('f','j','が'),
          two_keys('g','j','ぢ'),
          two_keys('a','j','ぜ'),
          two_keys('x','j','び'),
          two_keys('w','j','ば'),
          two_keys('v','j','ご'),
          two_keys('b','j','ぞ'),
          # 右手半濁音
          two_keys('p','v','ぺ'),
          two_keys(PERIOD,'v','ぷ'),
          # 左手半濁音
          two_keys('z','m','ぽ'),
          two_keys('x','m','ぴ'),
          two_keys('w','m','ぱ'),
          # 拗音シフト やゆよと同時押しで、ゃゅょが付く
          two_keys('s',SEMICOLON,'きゃ'),
          two_keys('e',SEMICOLON,'りゃ'),
          two_keys('r',SEMICOLON,'しゃ'),
          two_keys('w',SEMICOLON,'みゃ'),
          two_keys('d',SEMICOLON,'にゃ'),
          two_keys('g',SEMICOLON,'ちゃ'),
          two_keys('x',SEMICOLON,'ひゃ'),
          two_keys('s','o','きゅ'),
          two_keys('e','o','りゅ'),
          two_keys('r','o','しゅ'),
          two_keys('w','o','みゅ'),
          two_keys('d','o','にゅ'),
          two_keys('g','o','ちゅ'),
          two_keys('x','o','ひゅ'),
          two_keys('s','i','きょ'),
          two_keys('e','i','りょ'),
          two_keys('r','i','しょ'),
          two_keys('d','i','にょ'),
          two_keys('g','i','ちょ'),
          two_keys('x','i','ひょ'),
          two_keys('w','i','みょ'),
          two_keys('w',SEMICOLON,'みゃ'),
          two_keys('w','o','みゅ'),
          two_keys('r','i','しょ'),
          two_keys('r',SEMICOLON,'しゃ'),
          two_keys('r','o','しゅ'),
          two_keys('s','i','きょ'),
          two_keys('s',SEMICOLON,'きゃ'),
          two_keys('s','o','きゅ'),
          two_keys('d','i','にょ'),
          two_keys('d',SEMICOLON,'にゃ'),
          two_keys('d','o','にゅ'),
          two_keys('g','i','ちょ'),
          two_keys('g',SEMICOLON,'ちゃ'),
          two_keys('g','o','ちゅ'),
          two_keys('x','i','ひょ'),
          two_keys('x',SEMICOLON,'ひゃ'),
          two_keys('x','o','ひゅ'),
          # 外来音
          two_keys('e','k','てぃ'),
          two_keys('d','l','とぅ'),
          two_keys('q','p','ヴぇ'),
          two_keys('q','j','ヴぁ'),
          two_keys('q','k','ヴぃ'),
          two_keys('q','n','ヴぉ'),
          two_keys('q','o','ヴゅ'),
          # 右手領域の同時押し外来音
          two_keys('l','j','うぁ'),
          two_keys('l','k','うぃ'),
          two_keys('l','p','うぇ'),
          two_keys('l','n','うぉ'),
          two_keys(PERIOD,'j','ふぁ'),
          two_keys(PERIOD,'k','ふぃ'),
          two_keys(PERIOD,'p','ふぇ'),
          two_keys(PERIOD,'n','ふぉ'),
          two_keys(PERIOD,'o','ふゅ'),
          two_keys('r','p','しぇ'),
          two_keys('g','p','ちぇ'),
          #特殊操作
          two_keys('v','m','改'),
          two_keys_always('h','j','仮'),#USモードでも効く定義
          two_keys('f','g','英'),
          # ------------------------------
          # シフト(スペースキー)
          #shift_key('q', ''),
          shift_key('s', 'ね'),
          shift_key('e', 'り'),
          shift_key(COMMA, 'む'),
          #shift_key('t', ''),
          #shift_key('y', ''),
          shift_key('u', 'さ'),
          shift_key('i', 'よ'),
          shift_key('p', 'え'),
          shift_key('r', 'め'),
          #shift_key('a', ''),
          shift_key('w', 'み'),
          shift_key('d', 'に'),
          shift_key('f', 'ま'),
          shift_key('g', 'ち'),
          shift_key('h', 'わ'),
          shift_key('j', 'の'),
          shift_key('k', 'も'),
          shift_key('l', 'つ'),
          shift_key(SEMICOLON, 'や'),
          shift_key('a', 'せ'),
          #shift_key('x', 'ひ'),
          shift_key('c', 'を'),
          shift_key('v', '、'),
          shift_key('b', 'ぬ'),
          shift_key('n', 'お'),
          shift_key('m', '。改'),
          shift_key('o', 'ゆ'),
          shift_key(PERIOD, 'ふ'),
          #shift_key('/', ''),
          # ------------------------------
          # 連続シフトシフト(スペースキー)
          #continuous_shift('q', ''),
          continuous_shift('s', 'ね'),
          continuous_shift('e', 'り'),
          continuous_shift(COMMA, 'む'),
          #continuous_shift('t', ''),
          #continuous_shift('y', ''),
          continuous_shift('u', 'さ'),
          continuous_shift('i', 'よ'),
          continuous_shift('p', 'え'),
          continuous_shift('r', 'め'),
          #continuous_shift('a', ''),
          continuous_shift('w', 'み'),
          continuous_shift('d', 'に'),
          continuous_shift('f', 'ま'),
          continuous_shift('g', 'ち'),
          continuous_shift('h', 'わ'),
          continuous_shift('j', 'の'),
          continuous_shift('k', 'も'),
          continuous_shift('l', 'つ'),
          continuous_shift(SEMICOLON, 'や'),
          continuous_shift('a', 'せ'),
          #continuous_shift('x', 'ひ'),
          continuous_shift('c', 'を'),
          continuous_shift('v', '、'),
          continuous_shift('b', 'ぬ'),
          continuous_shift('n', 'お'),
          continuous_shift('m', '。改'),
          continuous_shift('o', 'ゆ'),
          continuous_shift(PERIOD, 'ふ'),
          #continuous_shift('/', ''),
          # ------------------------------
          # シフトなし(単打)
          normal_key('q', 'ヴ'),
          normal_key('s', 'き'),
          normal_key('e', 'て'),
          normal_key('r', 'し'),
          normal_key('t', '←'),
          normal_key('y', '→'),
          normal_key('u', '削'),
          normal_key('i', 'る'),
          normal_key('o', 'す'),
          normal_key('p', 'へ'),
          normal_key('z', 'ほ'),
          normal_key('c', 'け'),
          normal_key('d', 'と'),
          normal_key('f', 'か'),
          normal_key('g', 'っ'),
          normal_key('h', 'く'),
          normal_key('j', 'あ'),
          normal_key('k', 'い'),
          normal_key('l', 'う'),
          normal_key(SEMICOLON, 'ー'),
          normal_key('a', 'ろ'),
          normal_key('x', 'ひ'),
          normal_key('w', 'は'),
          normal_key('v', 'こ'),
          normal_key('b', 'そ'),
          normal_key('n', 'た'),
          normal_key('m', 'な'),
          normal_key(COMMA, 'ん'),
          normal_key(PERIOD, 'ら'),
          normal_key(SLASH, 'れ'),
          #PC用キーボード定義
          normal_key_always('international4','仮'),#PC用JISキーボードつないだときの定義 (変換)& USモードでも効く定義
          normal_key('international5','英'),#PC用JISキーボードつないだときの定義 (無変換)


        ],
      },
    ]
  )
end


def shiftkeydef()
  {
    'type' => 'basic',
    'from' => {
      'key_code' => SPACEBAR,
    },
    'to' => [
      'set_variable'=>
        {'name' => 'shifted','value' => 1}
    ],
    'to_if_alone' => [
      'key_code' => SPACEBAR
    ],
    'to_after_key_up' => [
      'set_variable'=>
        {'name' => 'shifted','value' => 0}
    ],
    'conditions' => CONDITIONS,
  }
end

def normal_key(key, char)
  {
    'type' => 'basic',
    'from' => {
      'key_code' => key,
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def normal_key_always(key, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        }
      ],
    },
    'to' => ROMAN_MAP[char],
  }
end

def continuous_shift(key, char)
  {
    'type' => 'basic',
    'from' => {
      'key_code' => key,
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS_SHIFT,
  }
end

def shift_key(key, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => SPACEBAR,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    #'set_variable': { 'name': 'shifted','value': 1 },
    'conditions' => CONDITIONS,
    'to_after_key_up': [
      {
        'set_variable': {
          'name': 'shifted',
          'value': 0
        }
      }
    ]
  }
end

def two_keys(key,key2, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => key2,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def two_keys_always(key,key2, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => key2,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
  }
end

def three_keys(key,key2,key3, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => key2,
        },
        {
          'key_code' => key3,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def four_keys(key,key2,key3,key4, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => key2,
        },
        {
          'key_code' => key3,
        },
        {
          'key_code' => key4,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def editmode_two_left(key,char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => 'm',
        },
        {
          'key_code' => COMMA,
        },
        {
          'key_code' => key,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def editmode_two_right(key,char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => 'v',
        },
        {
          'key_code' => 'c',
        },
        {
          'key_code' => key,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def editmode_one_left(key,char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => 'j',
        },
        {
          'key_code' => 'k',
        },
        {
          'key_code' => key,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def editmode_one_right(key,char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => 'd',
        },
        {
          'key_code' => 'f',
        },
        {
          'key_code' => key,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

main
