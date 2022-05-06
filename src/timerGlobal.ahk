
global tglo_timerSelect = 1

global tglo_stopWaSelect = 1

global tglo_timePeriod_sec = 1	; tglo_timePeriod  // 1000  と同じ
global tglo_timePeriod = 1000

; あと何秒を表示する感覚
global tglo_iniSetTextPeriod_sec = 5

; アラームのウインドウを自動で閉じないようにする
global tglo_iniSetNoticeCloseNotFlag = 0

; ウインドウを閉じても、終了しない
global tglo_iniSetExitIfWinCloseNotFlag = 0

; このソフトのフォントサイズを変更した種類
global tglo_iniSetTimerAllFontSize = 4

; このソフトのフォント名を指定
global tglo_iniSetTimerAllFontName =

; アラームを停止するホットキー
global tglo_iniSetNoticeCloseKeyName =

; アラームのウインドウを表示しないようにする
global tglo_iniSetNoticeGuiShowNotFlag = 0

; タイマーを実行した後にソフトを終了する
global tglo_iniSetNoticeAppEndFlag = 0

; 起動時に表示するのは時刻の指定か、数字指定か
global tglo_iniSetStartWindow = 0

; 使用しているのは時刻の指定か、数字指定か
global tglo_mainIsNumeralWindowFlag = 0

; 時間の通知を知らせる時間
global tglo_alarmTimer =
global tglo_alarmLengthPlaying = 120
global tglo_iniAlarmLength1 = 120
global tglo_iniAlarmLength2 = 120
global tglo_iniAlarmLength3 = 120
global tglo_iniAlarmLength4 = 120


; アラームを繰り返し再生し続けるために使う
global tglo_reAlarmTimer =
global tglo_reAlarmPeriodPlaying = 16
global tglo_iniReAlarmPeriod1 = 16
global tglo_iniReAlarmPeriod2 = 16
global tglo_iniReAlarmPeriod3 = 16
global tglo_iniReAlarmPeriod4 = 16

; 一時停止の時にTrueにする
global tglo_alarmOnTimeStopFlag = False


; 試し運転用  時間の通知を知らせる時間
global tglo_alarmTestPlay =
global tglo_alarmLengthTestPlay = 120

; 試し運転用  アラームを繰り返し再生し続けるために使う
global tglo_reAlarmTestPlay =
global tglo_reAlarmPeriodTestPlay = 16

; 試し運転用  一時停止の時にTrueにする
global tglo_alarmOnTestPlayStopFlag = False

; 試し運転用  音楽ファイル
global tglo_bellNoteTestPlay =

; 試し運転用  残りの秒数を表示させるのに使用
global tglo_setTextTestPlay_sec = 0
global tglo_alarmTestPlayToSec = 0
global tglo_reAlarmTestPlayToSec = 0


global tglo_timerToSec1 = 0
global tglo_timerToSec2 = 0
global tglo_timerToSec3 = 0
global tglo_timerToSec4 = 0
global tglo_timerToSec5 = 0

global tglo_stopWaToSec1 = 0
global tglo_stopWaToSec2 = 0
global tglo_stopWaToSec3 = 0
global tglo_stopWaToSec4 = 0
global tglo_stopWaToSec5 = 0

global tglo_startTimerToSec1 = 0
global tglo_startTimerToSec2 = 0
global tglo_startTimerToSec3 = 0
global tglo_startTimerToSec4 = 0
global tglo_startTimerToSec5 = 0

global tglo_startStopWaToSec1 = 0
global tglo_startStopWaToSec2 = 0
global tglo_startStopWaToSec3 = 0
global tglo_startStopWaToSec4 = 0
global tglo_startStopWaToSec5 = 0

global tglo_tmpHour1 = 0
global tglo_tmpHour2 = 0
global tglo_tmpHour3 = 0
global tglo_tmpHour4 = 0
global tglo_tmpHour5 = 0

global tglo_tmpMin1 = 0
global tglo_tmpMin2 = 0
global tglo_tmpMin3 = 0
global tglo_tmpMin4 = 0
global tglo_tmpMin5 = 0

global tglo_tmpSec1 = 0
global tglo_tmpSec2 = 0
global tglo_tmpSec3 = 0
global tglo_tmpSec4 = 0
global tglo_tmpSec5 = 0

global tglo_setTextTime1 = 0
global tglo_setTextTime2 = 0
global tglo_setTextTime3 = 0
global tglo_setTextTime4 = 0
global tglo_setTextTime5 = 0
global tglo_setTextStopWa1 = 0
global tglo_setTextStopWa2 = 0
global tglo_setTextStopWa3 = 0
global tglo_setTextStopWa4 = 0
global tglo_setTextStopWa5 = 0

; 一時停止と再起動の時に必要になった
global tglo_onFlagStopWa1 = True
global tglo_onFlagStopWa2 = True
global tglo_onFlagStopWa3 = True
global tglo_onFlagStopWa4 = True
global tglo_onFlagStopWa5 = True


global tglo_appFlag1 := 0
global tglo_appFlag2 := 0
global tglo_appFlag3 := 0
global tglo_appFlag4 := 0
global tglo_appFlag5 := 0

global tglo_appName1 =
global tglo_appName2 =
global tglo_appName3 =
global tglo_appName4 =
global tglo_appName5 =

global tglo_appArgs1 =
global tglo_appArgs2 =
global tglo_appArgs3 =
global tglo_appArgs4 =
global tglo_appArgs5 =

global tglo_appWorkDir1 =
global tglo_appWorkDir2 =
global tglo_appWorkDir3 =
global tglo_appWorkDir4 =
global tglo_appWorkDir5 = 

global tglo_appFlagStipWa1 := 0
global tglo_appFlagStipWa2 := 0
global tglo_appFlagStipWa3 := 0
global tglo_appFlagStipWa4 := 0
global tglo_appFlagStipWa5 := 0

global tglo_appNameStipWa1 =
global tglo_appNameStipWa2 =
global tglo_appNameStipWa3 =
global tglo_appNameStipWa4 =
global tglo_appNameStipWa5 =

global tglo_appArgsStipWa1 =
global tglo_appArgsStipWa2 =
global tglo_appArgsStipWa3 =
global tglo_appArgsStipWa4 =
global tglo_appArgsStipWa5 =

global tglo_appWorkDirStipWa1 =
global tglo_appWorkDirStipWa2 =
global tglo_appWorkDirStipWa3 =
global tglo_appWorkDirStipWa4 =
global tglo_appWorkDirStipWa5 = 

global tglo_timerAlarm1 = 1
global tglo_timerAlarm2 = 1
global tglo_timerAlarm3 = 1
global tglo_timerAlarm4 = 1
global tglo_timerAlarm5 = 1

global tglo_stopWaAlarm1 = 1
global tglo_stopWaAlarm2 = 1
global tglo_stopWaAlarm3 = 1
global tglo_stopWaAlarm4 = 1
global tglo_stopWaAlarm5 = 1

global tglo_timerExpression1 =
global tglo_timerExpression2 =
global tglo_timerExpression3 =
global tglo_timerExpression4 =
global tglo_timerExpression5 =

global tglo_stopWaExpression1 =
global tglo_stopWaExpression2 =
global tglo_stopWaExpression3 =
global tglo_stopWaExpression4 =
global tglo_stopWaExpression5 =

global tglo_dpiNum := othli_GetDPI()
