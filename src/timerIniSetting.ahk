
global glotimer_docDir := A_ScriptDir . "\doc"

global glotimer_trayIcon := glotimer_docDir . "\iconTimer.ico"

global glotimer_iconTimerDefault := "\time"

global glotimer_iconTimer =

global glotimer_iconStopWatchDefault := "\numeral"

global glotimer_iconStopWatch =

global glotimer_bellNotePlaying := "doc\Alarm1.mp3"

global glotimer_bellNote1 := "doc\Alarm1.mp3"
global glotimer_bellNote2 := "doc\Alarm1.mp3"
global glotimer_bellNote3 := "doc\Alarm1.mp3"
global glotimer_bellNote4 := "doc\Alarm1.mp3"

global glotimer_bellNoteDefault1 := "doc\Alarm1.mp3"
global glotimer_bellNoteDefault2 := "doc\Alarm2.mp3"
global glotimer_bellNoteDefault3 := "doc\Alarm3.mp3"
global glotimer_bellNoteDefault4 := "doc\Alarm4.mp3"

global glotimer_Gui20Title := "時刻で指定"
global glotimer_Gui21Title := "今からの時間で指定"
global glotimer_Gui22Title := "時刻の指定の設定"
global glotimer_Gui23Title := "ソフトの設定（時刻の指定で起動する）"
global glotimer_Gui24Title := "設定全般"
global glotimer_Gui25Title := "数字指定の設定"
global glotimer_Gui26Title := "ソフトの設定（数字指定で起動する）"

global glotimer_Gui27Title =

global glotimer_Gui28Title := "タイマー終了"
global glotimer_Gui29Title := "音楽ファイルの試聴"

global glotimer_Gui31Title := "時刻の保存・読み出し"
global glotimer_Gui32Title := "数字指定の保存・読み出し"
global glotimer_Gui33Title := "ListEasyTimerの警告"
global glotimer_Gui34Title := "タイマーのバージョン情報"

global glotimer_userDir := A_ScriptDir  . "\user"

global glotimer_entrySoftDir :=  glotimer_userDir  . "\entrySoft"

global glotimer_softIniFile :=  glotimer_userDir  . "\entrySoft\softSetting.ini"

global glotimer_softNamessFile :=  glotimer_userDir  . "\entrySoft\softNamess.txt"

; バックグラウンド
global glotimer_backGroundDirName := "\backGround"

global glotimer_timeBGName :=  glotimer_backGroundDirName  . "\time"
global glotimer_numeralBGName :=  glotimer_backGroundDirName  . "\numeral"

global glotimer_timeSubBGName :=  glotimer_backGroundDirName  . "\timeSub"
global glotimer_numeralSubBGName :=  glotimer_backGroundDirName  . "\numeralSub"

global glotimer_timeSoftBGName :=  glotimer_backGroundDirName  . "\timeSoft"
global glotimer_numeralSoftBGName :=  glotimer_backGroundDirName  . "\numeralSoft"

global glotimer_timeSaveBGName :=  glotimer_backGroundDirName  . "\timeSave"
global glotimer_numeralSaveBGName :=  glotimer_backGroundDirName  . "\numeralSave"

global glotimer_notifiBGName :=  glotimer_backGroundDirName  . "\notifi"

global glotimer_timer1 =
global glotimer_timer2 =
global glotimer_timer3 =
global glotimer_timer4 =
global glotimer_timer5 =

global glotimer_alarmFlag = True

global glotimer_settingIni := glotimer_userDir  . "\setting.ini"

global glotimer_windowSizePosIni := glotimer_userDir  . "\windowSizePos.ini"

global glotimer_stopWatchIniFile := glotimer_userDir  . "\numeralList.ini"

global glotimer_timerListIniFile :=  glotimer_userDir  . "\timeList.ini"

global glotimer_SHELL32DLL := SystemRoot . "\system32\SHELL32.dll"

global glotimer_shimgvwDLL := SystemRoot . "\system32\shimgvw.dll"

global glotimer_softObj := Object()

global glotimer_hwndEditBox33_1 =

; あえてグローバルにしない
;global null =
null =

global MyDocuments := A_MyDocuments

global Desktop := A_Desktop

global ThisSoftDir := A_ScriptDir

SplitPath, A_ScriptDir, , , , , OutDrive
global DriveName := OutDrive


global Timer_Text_B_GuiNumTime = 20
global Timer_Text_B_GuiNumNumeral = 21

global Timer_Text_B_conTime_dateTime := "DateTime20_1"
global Timer_Text_B_conNumeral_hour := "UpDown21_1"
global Timer_Text_B_conNumeral_minute := "UpDown21_2"
global Timer_Text_B_conNumeral_second := "UpDown21_3"


if(A_IsCompiled == 1){
	glotimer_trayIcon := A_ScriptFullPath
} Else {
	IfNotExist, %glotimer_trayIcon%
	{
		glotimer_trayIcon := A_AhkPath
	}
	Menu, Tray, Icon, %glotimer_trayIcon%
}

