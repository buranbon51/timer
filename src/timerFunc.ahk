



time_initCheckFileAndFolderMakeFile(){
	time_easyFolderCheckMakeFolder(glotimer_userDir)
	time_easyFolderCheckMakeFolder(glotimer_docDir)
	time_easyFolderCheckMakeFolder(glotimer_docDir . glotimer_backGroundDirName)
	glotimer_SHELL32DLL := time_fileNotExistReturnNull(glotimer_SHELL32DLL)
	glotimer_shimgvwDLL := time_fileNotExistReturnNull(glotimer_shimgvwDLL)
	glotimer_trayIcon := time_fileNotExistReturnNull(glotimer_trayIcon)
	glotimer_iconTimer := time_fileNotExistReturnNull(glotimer_iconTimer)
	glotimer_iconStopWatch := time_fileNotExistReturnNull(glotimer_iconStopWatch)
}

time_fileNotExistReturnNull(file){
	IfNotExist,  %file%
	{
		returnValue := ""
		Return  returnValue
	}
	Return  file
}

time_easyFolderCheckMakeFolder(folder){
	type := FileExist(folder)
	if(type == ""){
		FileCreateDir, %folder%
	} else {
		IfNotInString, type, D
		{
			ToolTip , %folder%はフォルダ名ではない, A_CaretX, A_CaretY, 2
		}
	}
}


; 基本使わない予定
time_setTextTimer(typeNum){
	tglo_startTimerToSec%typeNum% := tglo_startTimerToSec%typeNum% + tglo_timePeriod_sec
	tglo_setTextTime%typeNum% := tglo_setTextTime%typeNum% + tglo_timePeriod_sec
	if(tglo_setTextTime%typeNum% >= tglo_iniSetTextPeriod_sec){
		time_setTextTimer_2(typeNum)
	}
}

; いろんなとこで使うので分けた
time_setTextTimer_2(typeNum){
	tglo_setTextTime%typeNum% = 0
	if(tglo_timerSelect == typeNum){
		nowSec := time_dateTimeToSec( A_Now )
		num := tglo_timerToSec%typeNum% - nowSec

		; 時刻で指定する場合のみ、１日以上先の指定は不可能なため、
		; 秒数が多すぎるときは、day1Plusの変数が代入されていたと判別する
		if(num >= 86400){
			num -= 86400
		}

		if(num < 1){
			num = 0
		}
		guf_setControl("あと " . num  . " 秒", "Text20_1", 20 )
	}
}

; 基本使わない予定
time_setTextStopWa(typeNum){
	tglo_startStopWaToSec%typeNum% := tglo_startStopWaToSec%typeNum% + tglo_timePeriod_sec
	tglo_setTextStopWa%typeNum%    := tglo_setTextStopWa%typeNum% + tglo_timePeriod_sec
	if(tglo_setTextStopWa%typeNum% >= tglo_iniSetTextPeriod_sec){
		time_setTextStopWa_2(typeNum)
	}
}

; いろんなとこで使うので分けた
time_setTextStopWa_2(typeNum){
	tglo_setTextStopWa%typeNum% := 0
	if(tglo_stopWaSelect == typeNum){
		num := tglo_stopWaToSec%typeNum% - tglo_startStopWaToSec%typeNum%
		if(num < 1){
			num = 0
		}
		guf_setControl("あと " . num  . " 秒", "Text21_2", 21 )
	}
}

time_changeListTimer(){
	List20_1 := guf_getControl( "List20_1", 20 )
	tglo_timerSelect = %List20_1%
	dateTime := glotimer_timer%List20_1%
	if(dateTime == "") {
		guf_setControl( A_Now, "DateTime20_1", 20 )
	} else {
		guf_setControl( dateTime, "DateTime20_1", 20 )
	}
	if(tglo_timerToSec%List20_1% == 0){
		guf_setControl("時刻で設定", "Text20_1", 20 )
		;guf_setControl( 1, "Radio22_1", 22 )
		;guf_setControl( "", "Edit22_1", 22 )
		outstime_setRadioControl(tglo_timerAlarm%List20_1%, "Radio22_1", "Radio22_2", "Radio22_3", "Radio22_4", 22)
		guf_setControl( tglo_timerExpression%List20_1%, "Edit22_1", 22 )
	} else {
		time_setTextTimer_2(List20_1)
		outstime_setRadioControl(tglo_timerAlarm%List20_1%, "Radio22_1", "Radio22_2", "Radio22_3", "Radio22_4", 22)
		guf_setControl( tglo_timerExpression%List20_1%, "Edit22_1", 22 )
	}
	appFlag := tglo_appFlag%List20_1%
	appName := tglo_appName%List20_1%
	appArgs := tglo_appArgs%List20_1%
	appWorkDir := tglo_appWorkDir%List20_1%
	guf_setControl( appFlag, "Checkbox23_1", 23 )
	guf_setControl( appName, "Edit23_1", 23 )
	guf_setControl( appArgs, "Edit23_2", 23 )
	guf_setControl( appWorkDir, "Edit23_3", 23 )

	; ユーザーが追加できる関数を使用
	runningFlag := True
	if(tglo_timerToSec%List20_1% == 0){
		runningFlag := False
	}
	useracl_actionOfChangeListBoxTime(runningFlag, List20_1)
}

time_changeListStopWatch(){
	List21_2 := guf_getControl( "List21_2", 21 )
	tglo_stopWaSelect = %List21_2%
	guf_setControl( tglo_tmpHour%List21_2%, "UpDown21_1", 21 )
	guf_setControl( tglo_tmpMin%List21_2%,  "UpDown21_2", 21 )
	guf_setControl( tglo_tmpSec%List21_2%,  "UpDown21_3", 21 )
	if(tglo_stopWaToSec%List21_2% == 0){
		guf_setControl("今からの時間で指定", "Text21_2", 21 )
		;guf_setControl( 1, "Radio25_1", 25 )
		;guf_setControl( "", "Edit25_1", 25 )
		outstime_setRadioControl(tglo_stopWaAlarm%List21_2%, "Radio25_1", "Radio25_2", "Radio25_3", "Radio25_4", 25)
		guf_setControl( tglo_stopWaExpression%List21_2%, "Edit25_1", 25 )
	} else {
		time_setTextStopWa_2(List21_2)
		outstime_setRadioControl(tglo_stopWaAlarm%List21_2%, "Radio25_1", "Radio25_2", "Radio25_3", "Radio25_4", 25)
		guf_setControl( tglo_stopWaExpression%List21_2%, "Edit25_1", 25 )
	}
	appFlagStipWa := tglo_appFlagStipWa%List21_2%
	appName := tglo_appNameStipWa%List21_2%
	appArgs := tglo_appArgsStipWa%List21_2%
	appWorkDir := tglo_appWorkDirStipWa%List21_2%
	guf_setControl( appFlagStipWa, "Checkbox26_1", 26 )
	guf_setControl( appName, "Edit26_1", 26 )
	guf_setControl( appArgs, "Edit26_2", 26 )
	guf_setControl( appWorkDir, "Edit26_3", 26 )
	if(tglo_onFlagStopWa%List21_2%){	; 一時停止のオンオフ
		time_offTextFlagStopWaLogic()
	} else {
		time_onTextFlagStopWaLogic()
	}

	; ユーザーが追加できる関数を使用
	runningFlag := True
	if(tglo_stopWaToSec%List21_2% == 0){
		runningFlag := False
	}
	useracl_actionOfChangeListBoxNumeral(runningFlag, List21_2)
}

time_offTextFlagStopWaLogic(){
	GuiControl, 21:-g, Button21_2_2
	GuiControl, 21:+gSubButton21_2_2, Button21_2_2
	guf_setControl( "一時停止(&O)", "Button21_2_2", 21 )
	guf_setControl( "", "Text21_2_3", 21 )
}

time_onTextFlagStopWaLogic(){
	GuiControl, 21:-g, Button21_2_2
	GuiControl, 21:+gSubButton21_2_6, Button21_2_2
	guf_setControl( "再始動(&O)", "Button21_2_2", 21 )
	guf_setControl( "(停止中)", "Text21_2_3", 21 )
}

; リストの数字をチェック。不自然な場合は True
time_checkErrorListNumberUseText(listNumber){
	If listNumber is not integer
	{
		return True
	}

	if(listNumber <= 0){
		return True
	}
	if(listNumber >= 6){
		return True
	}
	return False
}

; 入力値を簡単にチェック。不自然な場合は True
time_checkErrorFormatDateTimeUseText(str){
	If str is not integer
	{
		return True
	}

	StringLen, length, str
	if(length == 2){
		if( str >= 24 ){
			return True
		}
	} else if(length == 4){
		StringLeft, leftStr, str, 2
		if( leftStr >= 24 ){
			return True
		}
		StringTrimLeft, rightStr, str, 2
		if( rightStr >= 60 ){
			return True
		}
	} else if(length == 6){
		StringLeft, leftStr, str, 2
		if( leftStr >= 24 ){
			return True
		}
		StringTrimLeft, rightStr, str, 2
		StringLeft, leftStr2, rightStr, 2
		StringTrimLeft, rightStr2, rightStr, 2
		if( leftStr2 >= 60 ){
			return True
		}
		if( rightStr2 >= 60 ){
			return True
		}
	} else {
		return True
	}
	return False
}

; 返り値はリストの番号。ミスがあったら、0 を返すようにしている
time_timerExecute(dateTime, list){
	If dateTime is not time
	{
		if( time_checkErrorFormatDateTimeUseText(dateTime) ){
			gutimf_appendErrorExplain("時刻の指定の値が認識できない。`n値  " . dateTime)
			return "0"
		}
	}

	dateTime := func_changeTodayDateTime(dateTime)

	If dateTime is not time
	{
		gutimf_appendErrorExplain("時刻の指定の書式になっていない。`n値  " . dateTime)
		return "0"
	}

	if( time_checkErrorListNumberUseText(list) ){
		gutimf_appendErrorExplain("リストの番号が正しくない。`nリスト番号  " . list . "`n時刻の指定  " . dateTime)
		return "0"
	}

	if(dateTime < A_Now) {		; 時間が今より早い場合、次の日の時間にする
		day1Sec := time_minHourToSec(24, 0, 0)
		sec := time_dateTimeToSec(dateTime)
		tglo_timerToSec%list% := day1Sec + sec
		EnvAdd, dateTime, 1 , Days
	} else {
		tglo_timerToSec%list% := time_dateTimeToSec(dateTime)
	}
	
	tglo_startTimerToSec%list% := time_dateTimeToSec(A_Now)

	Radio22_1 := guf_getControl( "Radio22_1", 22 )
	Radio22_2 := guf_getControl( "Radio22_2", 22 )
	Radio22_3 := guf_getControl( "Radio22_3", 22 )
	Radio22_4 := guf_getControl( "Radio22_4", 22 )
	tglo_timerAlarm%list% := outstime_guiRadioNum(Radio22_1, Radio22_2, Radio22_3, Radio22_4)
	Edit22_1 := guf_getControl( "Edit22_1", 22 )
	tglo_timerExpression%list% := Trim(Edit22_1)

	Checkbox23_1 := guf_getControl( "Checkbox23_1", 23 )
	tglo_appFlag%list% := Checkbox23_1
	if(Checkbox23_1 == 1){
		Edit23_1 := guf_getControl( "Edit23_1", 23 )
		Edit23_1 := Trim(Edit23_1)
		if(Edit23_1 != ""){
			tglo_appName%list% := Edit23_1
			tglo_appArgs%list% := guf_getControl( "Edit23_2", 23 )
			tglo_appWorkDir%list% := guf_getControl( "Edit23_3", 23 )
		} else {
			tglo_appFlag%list% = 0		; ソフト名がからだったらアラームのほうにする
		}
	}

	; ユーザーが追加できる関数
	usersbs_startButtonSettingTime(list, dateTime)

	if(list == "1"){
		glotimer_timer1 := dateTime
		SetTimer, SubTimerTimerType1, %tglo_timePeriod%
	} else if(list == "2") {
		glotimer_timer2 := dateTime
		SetTimer, SubTimerTimerType2, %tglo_timePeriod%
	} else if(list == "3") {
		glotimer_timer3 := dateTime
		SetTimer, SubTimerTimerType3, %tglo_timePeriod%
	} else if(list == "4") {
		glotimer_timer4 := dateTime
		SetTimer, SubTimerTimerType4, %tglo_timePeriod%
	} else if(list == "5") {
		glotimer_timer5 := dateTime
		SetTimer, SubTimerTimerType5, %tglo_timePeriod%
	}
	time_setTextTimer_2(list)
	return list
}

time_stopLogic(list){
	if( time_checkErrorListNumberUseText(list) ){
		gutimf_appendErrorExplain("リストの番号が正しくない。`nリスト番号  " . list . "`n時刻の停止の指定で")
		return False
	}

	if(tglo_timerToSec%list% == 0){
		return False
	}

	if(list == "1"){
		SetTimer, SubTimerTimerType1 ,Off
	} else if(list == "2") {
		SetTimer, SubTimerTimerType2 ,Off
	} else if(list == "3") {
		SetTimer, SubTimerTimerType3 ,Off
	} else if(list == "4") {
		SetTimer, SubTimerTimerType4 ,Off
	} else if(list == "5") {
		SetTimer, SubTimerTimerType5 ,Off
	}
	tglo_timerToSec%list% = 0
	guf_setControl("時刻で設定", "Text20_1", 20 )
	return True
}

time_timeOutLogic(typeNum){
	; ユーザーが追加できる関数
	file := tglo_appName%typeNum%
	args := tglo_appArgs%typeNum%
	workFolder := tglo_appWorkDir%typeNum%
	expression := tglo_timerExpression%typeNum%
	ans := userase_anyScriptExecuteTime(typeNum, expression, file, args, workFolder)

	glotimer_timer%typeNum% =
	tglo_timerToSec%typeNum% = 0
	; アラームは元に戻さない
	;tglo_timerAlarm%typeNum% = 1

	if(ans == False){
		if(tglo_appFlag%typeNum% == 1){
			time_appExeLogic(typeNum)
			; タイマーを実行した後に終了する設定の場合
			cetimer_exitAppsIfNotHaveExecution()
		} else {
			alarmPattern := tglo_timerAlarm%typeNum%
			expression := tglo_timerExpression%typeNum%
			time_alarmNose(alarmPattern, expression)
		}
	}

	guf_setControl("時刻で設定", "Text20_1", 20 )
}

time_timeOutStopWaLogic(typeNum){
	; ユーザーが追加できる関数
	file := tglo_appNameStipWa%typeNum%
	args := tglo_appArgsStipWa%typeNum%
	workFolder := tglo_appWorkDirStipWa%typeNum%
	expression := tglo_stopWaExpression%typeNum%
	ans := userase_anyScriptExecuteNumeral(typeNum, expression, file, args, workFolder)

	tglo_stopWaToSec%typeNum% = 0
	tglo_tmpHour%typeNum% = 0
	tglo_tmpMin%typeNum% = 0
	tglo_tmpSec%typeNum% = 0
	; アラームは元に戻さない
	;tglo_stopWaAlarm%typeNum% = 1

	if(ans == False){
		if(tglo_appFlagStipWa%typeNum% == 1){
			time_appExeStopWaLogic(typeNum)
			; タイマーを実行した後に終了する設定の場合
			cetimer_exitAppsIfNotHaveExecution()
		} else {
			alarmPattern := tglo_stopWaAlarm%typeNum%
			expression := tglo_stopWaExpression%typeNum%
			time_alarmNose(alarmPattern, expression)
		}
	}

	guf_setControl("今からの時間で指定", "Text21_2", 21 )
}

; 両端の " " を取る
time_dbQuouteEdgeTrim(str_local){
	dbQuouteChar := """"
	StringLeft, LChar, str_local, 1
	if(LChar == dbQuouteChar){
		StringTrimLeft, strTmp, str_local, 1
		StringRight, rChar, strTmp, 1
		if(rChar == dbQuouteChar){
			StringTrimRight, str_local, strTmp, 1
		}
	}
	return str_local
}

time_appExeLogic(typeNum){
	app := tglo_appName%typeNum%
	args := tglo_appArgs%typeNum%
	workDir := tglo_appWorkDir%typeNum%
	; %%で囲んだ文字を展開する
	app := outstime_textOutTrimssParsent(app)
	args := outstime_textOutTrimssParsent(args)
	workDir := outstime_textOutTrimssParsent(workDir)

	dbQuouteChar := """"
	app := time_dbQuouteEdgeTrim(app)
	appArgs := dbQuouteChar . app . dbQuouteChar . " " . args
	appArgs := Trim(appArgs)
	workDir := time_dbQuouteEdgeTrim(workDir)
	Run, %appArgs% , %workDir%,  UseErrorLevel
	gutimf_checkErrorLevelExplain("ファイルが起動出きていません")
}

time_appExeStopWaLogic(typeNum){
	app := tglo_appNameStipWa%typeNum%
	args := tglo_appArgsStipWa%typeNum%
	workDir := tglo_appWorkDirStipWa%typeNum%
	; %%で囲んだ文字を展開する
	app := outstime_textOutTrimssParsent(app)
	args := outstime_textOutTrimssParsent(args)
	workDir := outstime_textOutTrimssParsent(workDir)

	dbQuouteChar := """"
	app := time_dbQuouteEdgeTrim(app)
	appArgs := dbQuouteChar . app . dbQuouteChar . " " . args
	appArgs := Trim(appArgs)
	workDir := time_dbQuouteEdgeTrim(workDir)
	Run, %appArgs% , %workDir%,  UseErrorLevel
	gutimf_checkErrorLevelExplain("ファイルが起動出きていません")
}

time_alarmNose(alarmPattern, expression){
	glotimer_bellNotePlaying := glotimer_bellNote%alarmPattern%
	SoundPlay, %glotimer_bellNotePlaying%
	time_alarmLenthSet(alarmPattern)
	tglo_alarmOnTimeStopFlag := False
	Sleep, 100
	time_showOnTimeGui(expression)
}

time_showOnTimeGui(expression){
	str =
	if( expression == "" ){
		str := "時間です"
	} else {
		str := expression . "  の時間です"
	}
	guf_setControl( str, "Text28_1", 28 )
	; アラームの通知ウインドウを表示させない設定
	if( tglo_iniSetNoticeGuiShowNotFlag ){
		return
	}
	Gui, 28:Show
}

; アラームを繰り返し再生するまでの待機時間をセット
time_reAlarmTimeSet(alarmPattern){
	tglo_reAlarmTimer = %A_Now%
	tglo_reAlarmPeriodPlaying := tglo_iniReAlarmPeriod%alarmPattern%
	; 0 秒を指定していた場合、繰り返さないようにする
	if( tglo_reAlarmPeriodPlaying == 0 ){
		; 音を流し終わる時間の方を設定する
		tglo_reAlarmPeriodPlaying := tglo_alarmLengthPlaying + 10
	}
	EnvAdd, tglo_reAlarmTimer, %tglo_reAlarmPeriodPlaying% , Seconds
}

; time_reAlarmTimeSet と同じ。タイマー用のサブルーチンから使用する。
time_reAlarmTimeSetForPlaying(){
	tglo_reAlarmTimer = %A_Now%
	EnvAdd, tglo_reAlarmTimer, %tglo_reAlarmPeriodPlaying% , Seconds
}

; アラームを鳴らす長さを指定
time_alarmLenthSet(alarmPattern){
	time_reAlarmTimeSet(alarmPattern)

	tglo_alarmTimer = %A_Now%
	tglo_alarmLengthPlaying := tglo_iniAlarmLength%alarmPattern%

	; アラームを流す時間が 0 に設定されてるなら、タイマー自体を使用しない。（ウインドウを閉じない）
	if( tglo_alarmLengthPlaying == 0 ){
		return
	}

	EnvAdd, tglo_alarmTimer, %tglo_alarmLengthPlaying% , Seconds
	SetTimer, SubAlarmTimer , %tglo_timePeriod%
}

time_soundClose(){
	SetTimer, SubAlarmTimer , Off
	SoundPlay, _null_	; 音を止める
	tglo_alarmOnTimeStopFlag := False
}

time_soundCloseAndGuiHide(){
	time_soundClose()
	; 自動で閉じない
	if( tglo_iniSetNoticeCloseNotFlag ){
		return
	}
	Gui, 28:Hide
	; タイマーを実行した後に終了する設定の場合
	cetimer_exitAppsIfNotHaveExecution()
}

time_soundStop(){
	if(tglo_alarmOnTimeStopFlag){
		SoundPlay, %glotimer_bellNotePlaying%
		tglo_alarmOnTimeStopFlag := False
		time_reAlarmTimeSetForPlaying()
	} else {
		SoundPlay, _null_ 	; 音を止める
		tglo_alarmOnTimeStopFlag := True
		; 音を流し終わる時間まで アラームが 鳴らないようにする
		tglo_reAlarmTimer = %A_Now%
		EnvAdd, tglo_reAlarmTimer, %tglo_alarmLengthPlaying% , Seconds
	}
}

; 試し運転用 
time_soundTestPlayClose(){
	SetTimer, SubTestPlayAlarm, Off
	SoundPlay, _null_	; 音を止める
	tglo_alarmOnTestPlayStopFlag := False
	; 自動で閉じない
	if( tglo_iniSetNoticeCloseNotFlag ){
		;guf_setControl(0, "Text29_1", 29 )
		;guf_setControl(0, "Text29_2", 29 )
		return
	}
	Gui, 29:Hide
}

; 試し運転用 
time_soundTestPlayStop(){
	if(tglo_alarmOnTestPlayStopFlag){
		SoundPlay, %tglo_bellNoteTestPlay%
		tglo_alarmOnTestPlayStopFlag := False
		time_reAlarmTestPlayPlaying()
	} else {
		SoundPlay, _null_ 	; 音を止める
		tglo_alarmOnTestPlayStopFlag := True

		; 残りの秒数を 0 にする
		guf_setControl(0, "Text29_2", 29 )
		; 音を流し終わる時間まで アラームが 鳴らないようにする
		tglo_reAlarmTestPlay = %A_Now%
		EnvAdd, tglo_reAlarmTestPlay, %tglo_alarmLengthTestPlay% , Seconds
	}
}

; アラームの試し運転
time_alarmTestPlay(alarmLength, alarmStr, repetTime, alarmNum){
	tglo_bellNoteTestPlay = %alarmStr%
	SoundPlay, %alarmStr%
	time_alarmLenthTestPlay(alarmNum, alarmLength, repetTime)
	tglo_alarmOnTestPlayStopFlag := False

	Sleep, 100
	Gui, 29:Show
}

; 試し運転用 アラームを鳴らす長さを指定
time_alarmLenthTestPlay(alarmNum, alarmLength, repetTime){
	time_reAlarmTestPlay(alarmNum, repetTime)


	tglo_alarmTestPlay = %A_Now%
	tglo_alarmLengthTestPlay := alarmLength

	; アラームを流す時間が 0 に設定されてるなら、タイマー自体を使用しない。（ウインドウを閉じない）
	if( tglo_alarmLengthTestPlay == 0 ){
		; 更新しないので、表示を 0 に設定しておく
		guf_setControl(0, "Text29_1", 29 )
		guf_setControl(0, "Text29_2", 29 )
		return
	}

	; 初期値を表示
	guf_setControl(alarmLength, "Text29_1", 29 )
	guf_setControl(repetTime, "Text29_2", 29 )

	; 残り時間を表示させるのに使う
	tmpSec := time_dateTimeToSec( tglo_alarmTestPlay )
	tglo_alarmTestPlayToSec := tmpSec + alarmLength

	EnvAdd, tglo_alarmTestPlay, %tglo_alarmLengthTestPlay% , Seconds
	SetTimer, SubTestPlayAlarm , %tglo_timePeriod%
}

; 試し運転用 アラームを繰り返し再生するまでの待機時間をセット
time_reAlarmTestPlay(alarmNum, repetTime){
	tglo_reAlarmTestPlay = %A_Now%
	tglo_reAlarmPeriodTestPlay := repetTime

	; 0 秒を指定していた場合、繰り返さないようにする
	if( tglo_reAlarmPeriodTestPlay == 0 ){
		; 音を流し終わる時間の方を設定する
		tglo_reAlarmPeriodTestPlay := tglo_alarmLengthTestPlay + 10
	}

	; 残り時間を表示させるのに使う
	tmpSec := time_dateTimeToSec( tglo_reAlarmTestPlay )
	tglo_reAlarmTestPlayToSec := tmpSec + tglo_reAlarmPeriodTestPlay

	EnvAdd, tglo_reAlarmTestPlay, %tglo_reAlarmPeriodTestPlay% , Seconds
}

; 試し運転用 time_reAlarmTestPlay と同じ。タイマー用のサブルーチンから使用する。
time_reAlarmTestPlayPlaying(){
	tglo_reAlarmTestPlay = %A_Now%

	; 残り時間を表示させるのに使う
	tmpSec := time_dateTimeToSec( tglo_reAlarmTestPlay )
	tglo_reAlarmTestPlayToSec := tmpSec + tglo_reAlarmPeriodTestPlay

	EnvAdd, tglo_reAlarmTestPlay, %tglo_reAlarmPeriodTestPlay% , Seconds
}

; 試し運転用  残りの秒数を表示させる
time_setTextTestPlay(){
	tglo_setTextTestPlay_sec = 0
	nowSec := time_dateTimeToSec( A_Now )
	sec1 := tglo_alarmTestPlayToSec - nowSec
	if(sec1 < 1){
		sec1 = 0
	}
	guf_setControl(sec1, "Text29_1", 29 )

	; 一時停止中なら表示を更新しない
	if( tglo_alarmOnTestPlayStopFlag ){
		return
	}
	sec2 := tglo_reAlarmTestPlayToSec - nowSec
	if(sec2 < 1){
		sec2 = 0
	}
	guf_setControl(sec2, "Text29_2", 29 )
}

; 今の時間が後の場合、86400 秒を追加する
time_dateTimeToSecPlusOneDayIfLessNow(dateTime){
	sec := time_dateTimeToSec(dateTime)
	if(dateTime < A_Now) {
		day1Sec := time_minHourToSec(24, 0, 0)
		sec := day1Sec + sec
	}
	return sec
}

; 秒数が「今の時間を秒数に変えたもの」より小さい場合、86400 秒を追加する
time_plusOneDaySecIfLessNowToSec(sec){
	nowSec := time_dateTimeToSec(A_Now)
	if(sec < nowSec) {
		day1Sec := time_minHourToSec(24, 0, 0)
		sec := day1Sec + sec
	}
	return sec
}

; 数字が正しい範囲内か確認。間違いがあれば True
time_validatIsFalseAssignBySec(hour, min, sec){
	if( hour == "" ){
		gutimf_appendErrorExplain("時間の指定のエラー`n数字がカラなので動作できない")
		return True
	}
	if( min == "" ){
		gutimf_appendErrorExplain("分の指定のエラー`n数字がカラなので動作できない")
		return True
	}
	if( sec == "" ){
		gutimf_appendErrorExplain("秒の指定のエラー`n数字がカラなので動作できない")
		return True
	}

	if( hour >= 24 ){
		gutimf_appendErrorExplain("時間の指定のエラー`n24 以上の数値は指定できないようにしている")
		return True
	}
	if( min >= 1440 ){
		gutimf_appendErrorExplain("分の指定のエラー`n1440 以上の数値は指定できないようにしている")
		return True
	}
	if( sec >= 86400 ){
		gutimf_appendErrorExplain("秒の指定のエラー`n86400 以上の数値は指定できないようにしている")
		return True
	}
	return False
}

; 返り値はリストの番号。ミスがあったら、0 を返すようにしている
time_stopWatch(hour, min, sec, list){
	if( time_validatIsFalseAssignBySec(hour, min, sec) ){
		return "0"
	}

	if( time_checkErrorListNumberUseText(list) ){
		gutimf_appendErrorExplain("リストの番号が正しくない。`nリスト番号  " . list . "`n今からの時間で指定  " . hour . "時間  " . min . "分  "  . sec . "秒後")
		return "0"
	}

	tglo_onFlagStopWa%list% := True		; 一時停止でなくすための処理
	time_offTextFlagStopWaLogic()		; 
	tglo_startStopWaToSec%list% := 0
	tglo_stopWaToSec%list% := time_minHourToSec(hour, min, sec)
	hour := time_editValueToDecimal(hour)
	min := time_editValueToDecimal(min)
	sec := time_editValueToDecimal(sec)

	Radio25_1 := guf_getControl( "Radio25_1", 25 )
	Radio25_2 := guf_getControl( "Radio25_2", 25 )
	Radio25_3 := guf_getControl( "Radio25_3", 25 )
	Radio25_4 := guf_getControl( "Radio25_4", 25 )
	tglo_stopWaAlarm%list% := outstime_guiRadioNum(Radio25_1, Radio25_2, Radio25_3, Radio25_4)
	Edit25_1 := guf_getControl( "Edit25_1", 25 )
	tglo_stopWaExpression%list% := Trim(Edit25_1)

	Checkbox26_1 := guf_getControl( "Checkbox26_1", 26 )
	tglo_appFlagStipWa%list% := Checkbox26_1
	if(Checkbox26_1 == 1){
		Edit26_1 := guf_getControl( "Edit26_1", 26 )
		Edit26_1 := Trim(Edit26_1)
		if(Edit26_1 != ""){
			tglo_appNameStipWa%list% := Edit26_1
			tglo_appArgsStipWa%list% := guf_getControl( "Edit26_2", 26 )
			tglo_appWorkDirStipWa%list% := guf_getControl( "Edit26_3", 26 )
		} else {
			tglo_appFlagStipWa%list% = 0	; ソフト名がからだったらアラームのほうにする
		}
	}

	; ユーザーが追加できる関数
	usersbs_startButtonSettingNumeral(list, hour, min, sec)

	tglo_tmpHour%list% := hour
	tglo_tmpMin%list% := min
	tglo_tmpSec%list% := sec
	time_stopWatchExecute(list)
	return list
}

time_stopWatchExecute(list){
	if(list == "1"){
		SetTimer, SubStopWatchType1, %tglo_timePeriod%
	} else if(list == "2") {
		SetTimer, SubStopWatchType2, %tglo_timePeriod%
	} else if(list == "3") {
		SetTimer, SubStopWatchType3, %tglo_timePeriod%
	} else if(list == "4") {
		SetTimer, SubStopWatchType4, %tglo_timePeriod%
	} else if(list == "5") {
		SetTimer, SubStopWatchType5, %tglo_timePeriod%
	}
	time_setTextStopWa_2(list)
}

time_stopStopWatchLogic(list){
	if( time_checkErrorListNumberUseText(list) ){
		gutimf_appendErrorExplain("リストの番号が正しくない。`nリスト番号  " . list . "`n一時停止の指定で")
		return False
	}

	if(tglo_stopWaToSec%list% == 0){
		return False
	}

	if(list == "1"){
		SetTimer, SubStopWatchType1 ,Off
	} else if(list == "2") {
		SetTimer, SubStopWatchType2 ,Off
	} else if(list == "3") {
		SetTimer, SubStopWatchType3 ,Off
	} else if(list == "4") {
		SetTimer, SubStopWatchType4 ,Off
	} else if(list == "5") {
		SetTimer, SubStopWatchType5 ,Off
	}
	GuiControl, 21:-g, Button21_2_2
	GuiControl, 21:+gSubButton21_2_6, Button21_2_2
	guf_setControl( "再始動(&O)", "Button21_2_2", 21 )
	guf_setControl( "(停止中)", "Text21_2_3", 21 )
	tglo_onFlagStopWa%list% := False
	return True
}

time_reStartStopWa(listNumber){
	if( time_checkErrorListNumberUseText(listNumber) ){
		gutimf_appendErrorExplain("リストの番号が正しくない。`nリスト番号  " . listNumber . "`n再始動の指定で")
		return False
	}

	if(tglo_stopWaToSec%listNumber% == 0){
		return False
	}

	SetTimer, SubStopWatchType%listNumber% ,On
	GuiControl, 21:-g, Button21_2_2
	GuiControl, 21:+gSubButton21_2_2, Button21_2_2
	guf_setControl( "一時停止(&O)", "Button21_2_2", 21 )
	guf_setControl( "", "Text21_2_3", 21 )
	tglo_onFlagStopWa%listNumber% := True
	return True
}


time_setNowTime(pControl, GuiNum){
	guf_setControl( A_Now, pControl, GuiNum )
}

time_dateTimeToSec(dateTime) {
	StringRight, sec, dateTime, 2
	StringRight, outvar, dateTime, 4
	StringLeft,  min, outvar, 2
	StringRight, outvar, dateTime, 6
	StringLeft,  hour, outvar, 2
	allSec := time_minHourToSec(hour, min, sec)
	return  allSec
}

time_minHourToSec(hour, min, sec){
	minToSec := min * 60
	hourToSec := hour * 3600
	allSec := hourToSec + minToSec + sec
	return  allSec
}

time_editValueToDecimal(num){
	num := Trim(num)
	if(num == ""){
		return  "00"
	}
	If num is integer
	{
		StringLen, length, num
		if(length == 1){
			num := "0" . num
		}
	} else {
		return  "00"
	}
	return  num
}

time_toDateTime(hour, min, sec){
	toDay := A_YYYY  . A_MM  . A_DD
	hour := time_editValueToDecimal(hour)
	min := time_editValueToDecimal(min)
	sec := time_editValueToDecimal(sec)
	nowDateTime := toDay  . hour  . min  . sec
	return  nowDateTime
}

time_toDayDateTime(){
	toDay := A_YYYY  . A_MM  . A_DD
	return  toDay
}

time_autoSetEdit23_1(){
	Edit23_1 := guf_getControl( "Edit23_1", 23 )
	textOutEdit23_1 := outstime_textOutTrimssParsent(Edit23_1)
	Edit23_1 := time_checkDangerStr(Edit23_1)
	textOutEdit23_1 := time_checkDangerStr(textOutEdit23_1)
	;time_setWorkDir(Edit23_1, textOutEdit23_1, "Edit23_3", 23)
	time_autoSetPicture(Edit23_1, textOutEdit23_1, "Picture23_1", 23 )
}

time_autoSetEdit26_1(){
	Edit26_1 := guf_getControl( "Edit26_1", 26 )
	textOutEdit26_1 := outstime_textOutTrimssParsent(Edit26_1)
	Edit26_1 := time_checkDangerStr(Edit26_1)
	textOutEdit26_1 := time_checkDangerStr(textOutEdit26_1)
	;time_setWorkDir(Edit26_1, textOutEdit26_1, "Edit26_3", 26)
	time_autoSetPicture(Edit26_1, textOutEdit26_1, "Picture26_1", 26 )
}


time_setWorkDir(str, textOutStr, pOutControl, GuiNum){
	type := FileExist(textOutStr)
	if(type != "") {
		IfNotInString, type, D
		{
			StringGetPos, num, str, \, R1
			num++
			StringLeft, str, str, num
		}
		guf_setControl( str, pOutControl, GuiNum )
	}
}

time_autoSetPicture( str, textOutStr, pOutControl, GuiNum ){
	type := FileExist(textOutStr)
	if(type != "") {
		IfInString, type, D
		{
			str2 := "*icon4 *w32 *h32 " . glotimer_SHELL32DLL
			guf_setControl( str2 , pOutControl, GuiNum )
		} else {
			StringRight, suffix, textOutStr, 4
			if(suffix == ".exe") {
				str2 := "*w32 *h32 " . textOutStr
				guf_setControl( str2, pOutControl, GuiNum )
			} else if(suffix == ".txt"){
				str2 := "*icon71 *w32 *h32 " . glotimer_SHELL32DLL
				guf_setControl( str2, pOutControl, GuiNum )
			} else if(suffix == ".jpg" || suffix == ".jpeg"  || suffix == ".gif"){
				guf_setControl( "*icon5 *w32 *h32 " . glotimer_shimgvwDLL , pOutControl, GuiNum )
			} else {
				guf_setControl( "*icon44 *w32 *h32 " . glotimer_SHELL32DLL , pOutControl, GuiNum )
			}
		}
	} else {
		guf_setControl( "", pOutControl, GuiNum )
	}
}

; 入力補完の時に使うと危険な文字をチェックする
; 戻り値あり
time_checkDangerStr(str) {
	checkStr := "A:"
	IfInString, str, A:
	{
		return  "@@@@@"
	}
	IfInString, str, a:
	{
		return  "@@@@@"
	}
	return  str
}

