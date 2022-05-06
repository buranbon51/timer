
time_initCheckFileAndFolderMakeFile()



fontNum9 := cetimer_timerFontFromDpiAndFontSize(9, 8, 6)
fontNum10 := cetimer_timerFontFromDpiAndFontSize(10, 9, 7)
fontNum12 := cetimer_timerFontFromDpiAndFontSize(12, 10, 8)
fontNum14 := cetimer_timerFontFromDpiAndFontSize(14, 12, 10)


tmpW70 := cetimer_timerNumFromDpiAndFontSize(3, 5, 70, 70, 70)
tmpW80 := cetimer_timerNumFromDpiAndFontSize(7, 13, 80, 80, 80)
tmpW100 := cetimer_timerNumFromDpiAndFontSize(8, 14, 100, 100, 100)
tmpW110 := cetimer_timerNumFromDpiAndFontSize(9, 15, 110, 110, 110)
tmpW130 := cetimer_timerNumFromDpiAndFontSize(11, 16, 130, 130, 130)
tmpW180 := cetimer_timerNumFromDpiAndFontSize(15, 17, 180, 180, 180)
tmpW200 := cetimer_timerNumFromDpiAndFontSize(16, 18, 200, 200, 200)
tmpW230 := cetimer_timerNumFromDpiAndFontSize(18, 20, 230, 230, 230)



guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 20)
outstime_bgPictureAddEnyExtFileTimer(glotimer_docDir . glotimer_timeBGName, "X0 Y0", 20)
Gui, 20:Add, Picture, X10 Y5 w32 h32  , %glotimer_iconTimer%

Gui, 20:Add, Text,      x+10 yp+10  w%tmpW110%  vText20_1, 時刻で指定
Gui, 20:Add, Text,      x+0  yp+0   w80   vText20_1_3

Gui, 20:Add, Text,    X10 y+15, (&T)
Gui, 20:Font, S%fontNum16%
tmpW := cetimer_timerNumFromDpiAndFontSize(2, 10, 100, 100, 100)
Gui, 20:Add, DateTime,  x+5 yp+0  w%tmpW% 1 vDateTime20_1 , Time

Gui, 20:Font, S%fontNum10%
Gui, 20:Add, Button,  X10 y+5  w%tmpW100%  gSubButton20_1_1  Default, スタート(&S)
Gui, 20:Add, Button,   x+20 yp+0  w%tmpW80% vButton20_1_2  gSubButton20_1_2, 停止(&O)
Gui, 20:Add, Text,     xp+0 y+20, 時刻リスト(&I)
Gui, 20:Add, ListBox,   xp+0 y+5 w%tmpW110% vList20_1  VScroll  R5  AltSubmit  gSubList20_1, 時刻1||時刻2|時刻3|時刻4|時刻5

Gui, 20:Add, Button,  X10 yp+0  w%tmpW80%  gSubButton20_1_4, 設定(&P)
Gui, 20:Add, Button,  X10 y+10  w%tmpW80%  gSubButton20_1_3, ソフト(&F)
Gui, 20:Add, Button,  X10 y+20  w%tmpW80% gSubButton20_1_5, 終了(&E)

Gui, 20:Add, Button,  X10 y+10 w%tmpW200% gSubButton20_7, 今からの時間で指定(&A)

Gui, 20:+Resize
Gui, 20:-MaximizeBox




guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 21)
outstime_bgPictureAddEnyExtFileTimer(glotimer_docDir . glotimer_numeralBGName, "X0 Y0", 21)
Gui, 21:Add, Picture, X10 Y5 w32 h32  , %glotimer_iconStopWatch%
Gui, 21:Add, Text,      x+10 yp+10 vText21_2, 今からの時間で指定
;Gui, 21:Font, S12
Gui, 21:Add, Text,      x+0  yp+0   w%tmpW110% vText21_2_3


Gui, 21:Add, Text,    X10 y+15 , (&T)
Gui, 21:Font, S%fontNum12%
tmpW := cetimer_timerNumFromDpiAndFontSize(3, 8, 45, 45, 45)
Gui, 21:Add, Edit,      x+2 yp+0  w%tmpW%  Number  Limit2 vUpDown21_1
Gui, 21:Add, UpDown, Range0-23  Wrap 128, 0
Gui, 21:Font, S%fontNum10%
Gui, 21:Add, Text,      x+2 yp+3, 時間

Gui, 21:Add, Text,      x+0 yp+0, (&M)
Gui, 21:Font, S%fontNum12%
tmpW := cetimer_timerNumFromDpiAndFontSize(4, 7, 60, 60, 60)
Gui, 21:Add, Edit,      x+5 yp-3  w%tmpW%  Number  Limit4 vUpDown21_2
Gui, 21:Add, UpDown, Range0-1439  Wrap 128, 0
Gui, 21:Font, S%fontNum10%
Gui, 21:Add, Text,      x+2 yp+3, 分

Gui, 21:Add, Text,      x+0 yp+0, (&B)
Gui, 21:Font, S%fontNum12%
tmpW := cetimer_timerNumFromDpiAndFontSize(5, 9, 70, 70, 70)
Gui, 21:Add, Edit,      x+5 yp-3  w%tmpW%  Number  Limit5 vUpDown21_3
Gui, 21:Add, UpDown, Range0-86399  Wrap 128, 0
Gui, 21:Font, S%fontNum10%
Gui, 21:Add, Text,      x+2 yp+3, 秒 後

Gui, 21:Font, S%fontNum10%
Gui, 21:Add, Button,  X10 y+10  w%tmpW100%  gSubButton21_2_1 Default, スタート(&S)
Gui, 21:Add, Button,    x+20 yp+0  w%tmpW110%  vButton21_2_2  gSubButton21_2_2, 一時停止(&O)

Gui, 21:Add, Text,      xp+0 y+20, 今からの時間リスト(&I)
Gui, 21:Add, ListBox,   xp+0 y+5  w%tmpW110% vList21_2  VScroll  R5  AltSubmit  gSubList21_2, 数字指定1||数字指定2|数字指定3|数字指定4|数字指定5

Gui, 21:Add, Button,  X10 yp+0 w%tmpW80% gSubButton21_2_4, 設定(&P)
Gui, 21:Add, Button,  X10 y+10  w%tmpW80%  gSubButton21_2_3, ソフト(&F)
Gui, 21:Add, Button,  X10 y+20  w%tmpW80% gSubButton21_2_5, 終了(&E)

Gui, 21:Add, Button,  X10 y+10 w%tmpW200% gSubButton21_7, 時刻で指定(&A)

Gui, 21:+Resize
Gui, 21:-MaximizeBox






guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 22)
outstime_bgPictureAddEnyExtFileTimer(glotimer_docDir . glotimer_timeSubBGName, "X0 Y0", 22)
Gui, 22:Add, Picture,X10 Y5 w32 h32  , %glotimer_iconTimer%
Gui, 22:Add, Text,    x+10 yp+10 , 時刻の指定で使用

Gui, 22:Font, S%fontNum10%
tmpNumGroupW := cetimer_timerNumFromDpiAndFontSize(15, 14, 270, 250, 230)
tmpNumGroupH := cetimer_timerNumFromDpiAndFontSize(4, 6, 90, 90, 90)
Gui, 22:Add, GroupBox, X10 y+5  w%tmpNumGroupW% h%tmpNumGroupH%
Gui, 22:Add, Text,       X20 yp+15 , アラームの種類
Gui, 22:Add, Radio,      X20   y+10  vRadio22_1  Checked , パターン１(&1)
Gui, 22:Add, Radio,       x+20 yp+0   vRadio22_2  ,  パターン２(&2)
Gui, 22:Add, Radio,      X20 y+10      vRadio22_3  ,  パターン３(&3)
Gui, 22:Add, Radio,       x+20 yp+0   vRadio22_4  ,  パターン４(&4)

Gui, 22:Add, Text,    X10 y+25, 表示する文字(&H)
Gui, 22:Add, Edit,     xp+10 y+5  w%tmpW230%  vEdit22_1

Gui, 22:Add, Button,  X10 y+15  w%tmpW200% gSubButton22_1_3,  時刻の保存・読み出し(&L)
Gui, 22:Add, Button,  X10 y+20  w%tmpW130% gSubButton22_1_6,  アイコンにする(&I)
Gui, 22:Add, Button,  X10 y+20  w%tmpW130% gSubButton22_1_5, 根幹の設定(&P)

Gui, 22:Add, Button,  X30 y+20  w%tmpW80% Default gSubButton22_1_4, 閉じる(&O)

Gui, 22:+Resize
Gui, 22:-MaximizeBox



guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 23)
outstime_bgPictureAddEnyExtFileTimer(glotimer_docDir . glotimer_timeSoftBGName, "X0 Y0", 23)
Gui, 23:Add, Checkbox,X10 Y15  vCheckbox23_1 gSubCheckbox23_1, アラームではなくソフトを起動(&A)
Gui, 23:Add, Text,    X50 y+10, ソフトのパス(&S)
Gui, 23:Add, Edit,    X50 y+5  w%tmpW180%  vEdit23_1  gSubEdit23_1
Gui, 23:Add, Picture, X50 y+5  w32 h32  vPicture23_1
Gui, 23:Add, Button,  X120 yp+0  w%tmpW110%  gSubButton23_1  , ファイル(&F)
Gui, 23:Add, Text,    X50 y+5, パラメータ(&P)
Gui, 23:Add, Edit,    X50 y+5  w%tmpW180%  vEdit23_2
Gui, 23:Add, Text,    X50 y+5, 作業フォルダ(&W)
Gui, 23:Add, Edit,    X50 y+5  w%tmpW180%  vEdit23_3
Gui, 23:Add, Button,  X80 y+5  w%tmpW100% Default gSubButton23_2 , 閉じる(&O)
;fontNum8 := cetimer_timerFontFromDpiAndFontSize(8, 7, 5)
;Gui, 23:Font, S%fontNum12%
Gui, 23:Add, Button,  X10 y+15 w%tmpW200%  gSubButton23_3, 上の情報を登録(&E)
;Gui, 23:Font, S%fontNum10%
Gui, 23:Add, Text,    X10 y+25, 登録ソフト(&I)
Gui, 23:Add, ComboBox,  x+15 yp+0 w%tmpW110% vComboBox23_1  gSubComboBox23_1 R8 Sort
Gui, 23:Add, Button,  X50 y+10 w%tmpW180%  gSubButton23_4, このソフトを削除

Gui, 23:+Resize
Gui, 23:-MaximizeBox
;Gui, 23:+AlwaysOnTop



guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 24)
Gui, 24:Add, Text,    X10 Y8,  根幹の設定

tmpNumGroupW := cetimer_timerNumFromDpiAndFontSize(20, 23, 280, 280, 280)
tmpNumGroupH := cetimer_timerNumFromDpiAndFontSize(6, 6, 110, 110, 110)
Gui, 24:Font, S%fontNum10%
Gui, 24:Add, GroupBox, X10 y+5  w%tmpNumGroupW% h%tmpNumGroupH%
Gui, 24:Add, Text,    X20 yp+15,  アラームの種類の設定
Gui, 24:Add, Button,  X20 y+5  w%tmpW100% gSubButton24_1, パターン１(&1)
Gui, 24:Add, Button,    x+20  yp+0  w%tmpW100% gSubButton24_2, パターン２(&2)
Gui, 24:Add, Button,  X20  y+10  w%tmpW100% gSubButton24_3, パターン３(&3)
Gui, 24:Add, Button,    x+20  yp+0  w%tmpW100% gSubButton24_4, パターン４(&4)
Gui, 24:Font, S%fontNum12%
tmpW := cetimer_timerNumFromDpiAndFontSize(3, 7, 55, 55, 55)
Gui, 24:Add, Text,    X10 y+35,  「あと何秒。」を表示する間隔(&A)
Gui, 24:Add, Edit,      x+10 yp-3  w%tmpW%  vUpDown24_1 Limit4
Gui, 24:Add, UpDown, Range0-9999 128, 5
Gui, 24:Add, Text,      x+5  yp+3  , 秒ごとに表示
Gui, 24:Add, Checkbox,X10 y+20  vCheckbox24_1 ,(&W)
Gui, 24:Add, Text,     x+0 yp+0, アラームのウインドウを自動で閉じないようにする
Gui, 24:Add, Checkbox,X10 y+20  vCheckbox24_2 ,(&Q)
Gui, 24:Add, Text,     x+0 yp+0, メインのウインドウを閉じても、`nこのソフトが終了しないようにする
Gui, 24:Add, Checkbox,X10 y+20  vCheckbox24_4 ,(&E)
Gui, 24:Add, Text,     x+0 yp+0, タイマーを実行した後はソフトを終了する


tmpNumGroupW := cetimer_timerNumFromDpiAndFontSize(26, 28, 430, 400, 370)
tmpNumGroupH := cetimer_timerNumFromDpiAndFontSize(8, 9, 185, 165, 145)
Gui, 24:Add, GroupBox, X10 y+5  w%tmpNumGroupW% h%tmpNumGroupH%

Gui, 24:Add, Text,  X20 yp+25 cFFA23E, なお、これらの設定は、再起動したときのみ反映される。
Gui, 24:Add, Text,  X20 y+10 , ソフト全体のフォントのサイズ(&S)
Gui, 24:Add, DropDownList,  x+10 yp-3 w%tmpW130% vDropDownList24_1 AltSubmit R8,かなり小さく|小さく|やや小さく|標準|やや大きく|大きく|かなり大きく|さらに大きく
Gui, 24:Add, Text,  X20 y+10 , ソフト全体のフォント名を指定(&F)
Gui, 24:Add, Edit,     x+10 yp-5 w%tmpW130%  vEdit24_2

Gui, 24:Add, Text,  X20 y+15 , アラームを停止するショートカットキーを設定する(&K)
Gui, 24:Add, Edit,  X20 y+5 w%tmpW80%  vEdit24_3
Gui, 24:Add, Text,     x+15 yp+5 , キー入力補助(&H)
Gui, 24:Add, Hotkey,   x+5 yp-5 w%tmpW130% vHotkey24_1 gSubHotkey24_1 Limit1

Gui, 24:Add, Checkbox,X10 y+40  vCheckbox24_3 ,(&N)
Gui, 24:Add, Text,     x+0 yp+0, アラームを鳴らすとき、`n通知のウインドウを表示させないようにする



guf_guiFontFromSizeAndName(fontNum10, "", 24)

Gui, 24:Add, Button,  X10  y+15  w%tmpW80%  Default , OK(&O)
Gui, 24:Add, Button,    x+20  yp+0  w%tmpW80% , Cancel(&C)

Gui, 24:+Resize
Gui, 24:-MaximizeBox




guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 25)
outstime_bgPictureAddEnyExtFileTimer(glotimer_docDir . glotimer_numeralSubBGName, "X0 Y0", 25)
Gui, 25:Add, Picture,X10 Y5 w32 h32  , %glotimer_iconStopWatch%
Gui, 25:Add, Text,    x+10 yp+10 , 今からの時間の指定で使用

guf_guiFontFromSizeAndName(fontNum10, "", 25)
tmpNumGroupW := cetimer_timerNumFromDpiAndFontSize(15, 14, 270, 250, 230)
tmpNumGroupH := cetimer_timerNumFromDpiAndFontSize(4, 6, 90, 90, 90)
Gui, 25:Add, GroupBox, X10 y+5  w%tmpNumGroupW% h%tmpNumGroupH%
Gui, 25:Add, Text,       X20 yp+15 , アラームの種類
Gui, 25:Add, Radio,      X20   y+10  vRadio25_1  Checked , パターン１(&1)
Gui, 25:Add, Radio,       x+20 yp+0   vRadio25_2  ,  パターン２(&2)
Gui, 25:Add, Radio,      X20 y+10      vRadio25_3  ,  パターン３(&3)
Gui, 25:Add, Radio,       x+20 yp+0   vRadio25_4  ,  パターン４(&4)

Gui, 25:Add, Text,    X10 y+25, 表示する文字(&H)
Gui, 25:Add, Edit,      xp+10 y+5  w%tmpW230%  vEdit25_1

Gui, 25:Add, Button,  X10 y+15  w%tmpW230% gSubButton25_1_3,  数字指定の保存・読み出し(&L)
Gui, 25:Add, Button,  X10 y+20  w%tmpW130% gSubButton22_1_6,  アイコンにする(&I)
Gui, 25:Add, Button,  X10 y+20  w%tmpW130% gSubButton22_1_5, 根幹の設定(&P)

Gui, 25:Add, Button,  X30 y+20  w%tmpW80% Default gSubButton25_1_4, 閉じる(&O)

Gui, 25:+Resize
Gui, 25:-MaximizeBox




guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 26)
outstime_bgPictureAddEnyExtFileTimer(glotimer_docDir . glotimer_numeralSoftBGName, "X0 Y0", 26)
Gui, 26:Add, Checkbox,X10 Y15  vCheckbox26_1 gSubCheckbox26_1, アラームではなくソフトを起動(&A)
Gui, 26:Add, Text,    X50 y+10, ソフトのパス(&S)
Gui, 26:Add, Edit,    X50 y+5  w%tmpW180%  vEdit26_1  gSubEdit26_1
Gui, 26:Add, Picture, X50 y+5  w32 h32  vPicture26_1
Gui, 26:Add, Button,  X120 yp+0  w%tmpW110%  gSubButton26_1  , ファイル(&F)
Gui, 26:Add, Text,    X50 y+5, パラメータ(&P)
Gui, 26:Add, Edit,    X50 y+5  w%tmpW180%  vEdit26_2
Gui, 26:Add, Text,    X50 y+5, 作業フォルダ(&W)
Gui, 26:Add, Edit,    X50 y+5  w%tmpW180%  vEdit26_3
Gui, 26:Add, Button,  X80 y+5  w%tmpW100% Default gSubButton26_2 , 閉じる(&O)
;Gui, 26:Font, S%fontNum8%
;Gui, 26:Font, S%fontNum12%
Gui, 26:Add, Button,  X10 y+15 w%tmpW200% gSubButton26_3, 上の情報を登録(&E)
;Gui, 26:Font, S%fontNum10%
Gui, 26:Add, Text,    X10 y+25, 登録ソフト(&I)
Gui, 26:Add, ComboBox,  x+15 yp+0 w%tmpW110%  vComboBox26_1  gSubComboBox26_1 R8 Sort
Gui, 26:Add, Button,  X50 y+10 w%tmpW180%  gSubButton26_4, このソフトを削除

Gui, 26:+Resize
Gui, 26:-MaximizeBox
;Gui, 26:+AlwaysOnTop




guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 27)
Gui, 27:Add, Text,  X10 Y8 vText27_1, アラームの「パターン1」 の設定
Gui, 27:Add, Text,  X30 y+15 , アラームを流す時間(&T)

Gui, 27:Add, Edit,      x+10 yp-3  w%tmpW70%  vUpDown27_2  Limit5  Number
Gui, 27:Add, UpDown, Range0-99999 128, 120
Gui, 27:Add, Text,      x+5  yp+3  , 秒

tmpNumGroupW := cetimer_timerNumFromDpiAndFontSize(11, 16, 420, 390, 360)
tmpNumGroupH := cetimer_timerNumFromDpiAndFontSize(8, 8, 150, 130, 110)
Gui, 27:Add, GroupBox, X10 y+10  w%tmpNumGroupW% h%tmpNumGroupH%

tmpW := cetimer_timerNumFromDpiAndFontSize(16, 17, 330, 310, 290)
Gui, 27:Add, Text,    X30 yp+20 , アラームに使うファイル(&A)
Gui, 27:Add, Edit,    X30 y+5  w%tmpW%  vEdit27_3

guf_guiFontFromSizeAndName(fontNum9, "", 27)
Gui, 27:Add, Button,  X100  y+5  w%tmpW80% gSubButton27_4 , File(&F)
Gui, 27:Add, Button,    x+20  yp+0  w%tmpW100%  gSubButton27_3 , デフォルト(&D)

guf_guiFontFromSizeAndName(fontNum12, "", 27)
Gui, 27:Add, Text,    X50 y+5 , このファイルの音楽を繰り返して`n再生するまでの時間(&R)
Gui, 27:Add, Edit,      x+15 yp+0  w%tmpW70%  vUpDown27_4  Limit5  Number
Gui, 27:Add, UpDown, Range0-99999 128, 16
Gui, 27:Add, Text,      x+5  yp+3  , 秒
;Gui, 27:Font, S%fontNum12%
Gui, 27:Add, Button,    X50  y+45 gSubButton27_5, 試しに聴く(&S)

guf_guiFontFromSizeAndName(fontNum10, "", 27)
Gui, 27:Add, Button,  X30  y+40  w%tmpW80%  Default gSubButton27_1, OK(&O)
Gui, 27:Add, Button,    x+20  yp+0  w%tmpW80%   gSubButton27_2, Cancel(&C)

Gui, 27:Add, Edit,   X0 Y0  Hidden  Disabled  vHiddenEdit27_1		; パターンのナンバー

Gui, 27:+Resize
Gui, 27:-MaximizeBox




guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 28)
outstime_bgPictureAddEnyExtFileTimer(glotimer_docDir . glotimer_notifiBGName, "X0 Y0", 28)
Gui, 28:Add, Picture, X30 Y5  w32 h32  , %glotimer_iconTimer%
Gui, 28:Add, Text,      x+20 yp+10 w%tmpW230% vText28_1, 時間です
Gui, 28:Font, S%fontNum10%
Gui, 28:Add, Button,  X10 y+10  w%tmpW100%  Default  gSubButton28_1, 音を消す(&O)
Gui, 28:Add, Button,    x+20 yp+0  w%tmpW130%  gSubButton28_2, 音の一時停止(&S)

Gui, 28:+Resize
Gui, 28:-MaximizeBox




guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 29)
Gui, 29:Add, Text,  X60 Y5, 音楽ファイルの試聴

tmpW := cetimer_timerNumFromDpiAndFontSize(5, 8, 40, 40, 40)
Gui, 29:Add, Text,  X10 y+5, 音を鳴らす時間
Gui, 29:Add, Text,  X10 y+5, あと
Gui, 29:Add, Text,   x+5 yp+0 w%tmpW% vText29_1
Gui, 29:Add, Text,   x+2 yp+0, 秒

Gui, 29:Add, Text,  X10 y+25, 繰り返し音を最初から流す時間
Gui, 29:Add, Text,  X10 y+5, あと
Gui, 29:Add, Text,   x+5 yp+0 w%tmpW% vText29_2
Gui, 29:Add, Text,   x+2 yp+0, 秒

guf_guiFontFromSizeAndName(fontNum10, "", 29)
Gui, 29:Add, Button,  X10 y+10  w%tmpW100%  Default  gSubButton29_1, 終了する(&O)
Gui, 29:Add, Button,    x+20 yp+0  w%tmpW130%  gSubButton29_2, 音の一時停止(&S)

Gui, 29:+Resize
Gui, 29:-MaximizeBox




guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 31)
outstime_bgPictureAddEnyExtFileTimer(glotimer_docDir . glotimer_timeSaveBGName, "X0 Y0", 31)
Gui, 31:Add, Text, X10 Y10, 時刻の保存リスト(&I)
Gui, 31:Add, ListBox, X10 y+5 w%tmpW180%  R10  VScroll AltSubmit vList31_1, set1||set2|set3|set4|set5|set6|set7|set8|set9|set10|set11|set12|set13|set14|set15|set16|set17|set18|set19|set20
Gui, 31:Font, S%fontNum10%
Gui, 31:Add, Text,  X10 y+13,  リスト名(&T)
Gui, 31:Add, Edit,    x+5 yp-3  w%tmpW130%  vEdit31_1
Gui, 31:Add, Button, X10 y+15 w%tmpW100%  gSubButton31_1 , 読み出し(&L)
Gui, 31:Add, Button,    x+15 yp+0  w%tmpW100%  gSubButton31_2, 保存(&S)
Gui, 31:Add, Button, X25  y+15  w%tmpW100% Default gSubButton31_3, 閉じる(&O)

Gui, 31:+Resize
Gui, 31:-MaximizeBox



guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 32)
outstime_bgPictureAddEnyExtFileTimer(glotimer_docDir . glotimer_numeralSaveBGName, "X0 Y0", 32)
Gui, 32:Add, Text, X10 Y10, 数字指定の保存リスト(&I)
Gui, 32:Add, ListBox, X10 y+5 w%tmpW180%  R10  VScroll AltSubmit vList32_1, set1||set2|set3|set4|set5|set6|set7|set8|set9|set10|set11|set12|set13|set14|set15|set16|set17|set18|set19|set20
Gui, 32:Font, S%fontNum10%
Gui, 32:Add, Text,  X10 y+13,  リスト名(&T)
Gui, 32:Add, Edit,    x+5 yp-3  w%tmpW130%  vEdit32_1
Gui, 32:Add, Button, X10 y+15 w%tmpW100%  gSubButton32_1 , 読み出し(&L)
Gui, 32:Add, Button,    x+15 yp+0  w%tmpW100%  gSubButton32_2, 保存(&S)
Gui, 32:Add, Button, X25  y+15  w%tmpW100% Default gSubButton32_3, 閉じる(&O)

Gui, 32:+Resize
Gui, 32:-MaximizeBox



;  出力に使うBOX
guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 33)
tmpW := cetimer_timerNumFromDpiAndFontSize(24, 26, 300, 300, 300)
Gui, 33:Add, Edit, X10 Y5  w%tmpW%  vEditBox33_1 Multi R8 VScroll  HwndhwndEditBox33_1
guf_guiFontFromSizeAndName(fontNum10, "", 33)
Gui, 33:Add, Button, X10 y+15 w%tmpW80%  vButton33_1  gSubButton33_1, 閉じる(&C)

Gui, 33:+Resize



; バージョン情報
guf_guiFontFromSizeAndName(fontNum12, tglo_iniSetTimerAllFontName, 34)
gutiin_cleatedDateTimer()

Gui, 34:+Resize



Menu, Tray, Add, 表示する(&H), SubVisibleMainTimer
Menu, Tray, Add, エラーの情報を表示(&E), SubConseTimer
Menu, Tray, Add, 標準の位置に全て戻す(&D), SubPosDefaultTimer
Menu, Tray, Add, 音を停止する(&S), SubSoundCloseOnlyTimer
Menu, Tray, Add, タイマーのバージョン(&A), SubVersionGuiTimer
Menu, Tray, Add
;Menu, Tray, Add, キャンセル(&C), SubCancelTimer
Menu, Tray, Add, 終了する(&X), SubExitAppTimer
Menu, Tray, NoStandard
Menu, Tray, Default, 表示する(&H)
Menu, Tray, Click, 1
Menu, Tray, Tip, ListEasyTimer


gutiin_initGuiAll()


glotimer_hwndEditBox33_1 := hwndEditBox33_1

cont_iniOptionSet()

itet_iniSetCombBox()

tsl_changeTimerListTitle()
tsl_changeStopWaListTitle()

cetimer_windowSizePosLoadAll()

hotttif_entrySoundCloseKey()

; 起動時に、時刻の指定と、数字指定のどちらを使うか
IniRead, tglo_iniSetStartWindow, %glotimer_windowSizePosIni%, __windowUse__, whichStart , 0

; 使用中の方を表す変数にも代入
tglo_mainIsNumeralWindowFlag = %tglo_iniSetStartWindow%
