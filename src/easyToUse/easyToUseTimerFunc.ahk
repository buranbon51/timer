



; スタートボタン
; listNumber は、指定しないか、 _ （アンダーバー）なら、選択中のリストを使用する。
; any の文字列なら、空いてるリストを使用する。
; 返り値は実行するリストの番号になる。ミスがあったら、0 を返すようにしている

; 時刻で
Timer_Text_startTimeFromDateTime(dateTime=235959, listNumber="_", reloadNotFlag=False){
	if(listNumber == "_"){
		listNumber := guf_getControl( "List20_1", 20 )
	} else if(listNumber == "any"){
		listNumber := Timer_Text_getNoInUseListNumberForTime()
		if( listNumber == "error" ){
			gutimf_appendErrorExplain("Timer_Text_startTimeFromDateTime()のエラー。`n空いているリストがない。`n時刻の指定  " . dateTime)
			return "0"
		}
	}
	dateTime := sufltif_colonFormatDateTime6Char(dateTime)
	if( time_checkErrorFormatDateTimeUseText(dateTime) ){
		gutimf_appendErrorExplain("Timer_Text_startTimeFromDateTime()のエラー。`n時刻の書式のエラー。`n時刻の指定  " . dateTime)
		return "0"
	}
	dateTime := sufltif_formatDateTimeUseText(dateTime)
	returnValue := time_timerExecute(dateTime, listNumber)
	if( reloadNotFlag == False ){
		Timer_Text_listReloadForTime()
	}
	return returnValue
}

; 今からの時間で
Timer_Text_startNumeralFromHourMinSec(hour=0, min=0, sec=0, listNumber="_", reloadNotFlag=False){
	if(listNumber == "_"){
		listNumber := guf_getControl( "List21_2", 21 )
	} else if(listNumber == "any"){
		listNumber := Timer_Text_getNoInUseListNumberForNumeral()
		if( listNumber == "error" ){
			gutimf_appendErrorExplain("Timer_Text_startNumeralFromHourMinSec()のエラー。`n空いているリストがない。`n今からの時間で指定  " . hour . "時間  " . min . "分  " . sec . "秒")
			return "0"
		}
	}
	returnValue := time_stopWatch(hour, min, sec, listNumber)
	if( reloadNotFlag == False ){
		Timer_Text_listReloadForNumeral()
	}
	return returnValue
}


; 停止ボタン
Timer_Text_stopTime(listNumber="_"){
	if(listNumber == "_"){
		listNumber := guf_getControl( "List20_1", 20 )
	}
	returnValue := time_stopLogic(listNumber)
	return returnValue
}


Timer_Text_stopNumeralSuspension(listNumber="_"){
	if(listNumber == "_"){
		listNumber := guf_getControl( "List21_2", 21 )
		returnValue := time_stopStopWatchLogic(listNumber)
		return returnValue
	}

	returnValue := time_stopStopWatchLogic(listNumber)
	if( returnValue ){
		; 今のリストのボタン（一時停止中）と、テキスト（停止中）の状態を更新
		time_changeListStopWatch()
	}
	return returnValue
}

; 再始動ボタン
Timer_Text_reStartNumeral(listNumber="_"){
	if(listNumber == "_"){
		listNumber := guf_getControl( "List21_2", 21 )
		returnValue := time_reStartStopWa(listNumber)
		return returnValue
	}

	returnValue := time_reStartStopWa(listNumber)
	if( returnValue ){
		; 今のリストのボタン（一時停止中）と、テキスト（停止中）の状態を更新
		time_changeListStopWatch()
	}
	return returnValue
}

; 今からの時間で指定の、
; 一時停止の状態なら 0 を返す
; それ以外の状態なら 1 を返す
Timer_Text_getFlagNotSuspension(listNumber="_"){
	if(listNumber == "_"){
		listNumber := guf_getControl( "List21_2", 21 )
	}
	return  tglo_onFlagStopWa%listNumber%
}


; リストの変更
Timer_Text_timeListChange(listNumber=1){
	if( time_checkErrorListNumberUseText(listNumber) ){
		gutimf_appendErrorExplain("Timer_Text_timeListChange()のエラー。`nリストの番号が正しくない。`nリスト番号  " . listNumber)
		return
	}

	guf_GuiControl("List20_1", 20, "Choose", listNumber)
	time_changeListTimer()
}

Timer_Text_numeralListChange(listNumber=1){
	if( time_checkErrorListNumberUseText(listNumber) ){
		gutimf_appendErrorExplain("Timer_Text_numeralListChange()のエラー。`nリストの番号が正しくない。`nリスト番号  " . listNumber)
		return
	}

	guf_GuiControl("List21_2", 21, "Choose", listNumber)
	time_changeListStopWatch()
}

; 今選択中のリストを更新
Timer_Text_listReloadForTime(){
	time_changeListTimer()
}

Timer_Text_listReloadForNumeral(){
	time_changeListStopWatch()
}

; 今選択中のリスト番号を返す
Timer_Text_getCurrentListNumberForTime(){
	listNumber := guf_getControl( "List20_1", 20 )
	return listNumber
}

Timer_Text_getCurrentListNumberForNumeral(){
	listNumber := guf_getControl( "List21_2", 21 )
	return listNumber
}

; そのリストが実行中かどうかを調べる。
; 時刻で
Timer_Text_checkInUseListNumberForTime(listNumber){
	if( time_checkErrorListNumberUseText(listNumber) ){
		gutimf_appendErrorExplain("Timer_Text_checkInUseListNumberForTime()のエラー。`nリストの番号が正しくない。`nリスト番号  " . listNumber)
		return False
	}

	if( tglo_timerToSec%listNumber% == 0 ){
		return False
	}
	return True
}

; 今からの時間で
Timer_Text_checkInUseListNumberForNumeral(listNumber){
	if( time_checkErrorListNumberUseText(listNumber) ){
		gutimf_appendErrorExplain("Timer_Text_checkInUseListNumberForNumeral()のエラー。`nリストの番号が正しくない。`nリスト番号  " . listNumber)
		return False
	}

	if( tglo_stopWaToSec%listNumber% == 0 ){
		return False
	}
	return True
}

; 空いてるリストを探して、返す
; 時刻で
Timer_Text_getNoInUseListNumberForTime(){
	if( tglo_timerToSec1 == 0 ){
		return "1"
	}
	if( tglo_timerToSec2 == 0 ){
		return "2"
	}
	if( tglo_timerToSec3 == 0 ){
		return "3"
	}
	if( tglo_timerToSec4 == 0 ){
		return "4"
	}
	if( tglo_timerToSec5 == 0 ){
		return "5"
	}
	return "error"
}

; 今からの時間で
Timer_Text_getNoInUseListNumberForNumeral(){
	if( tglo_stopWaToSec1 == 0 ){
		return "1"
	}
	if( tglo_stopWaToSec2 == 0 ){
		return "2"
	}
	if( tglo_stopWaToSec3 == 0 ){
		return "3"
	}
	if( tglo_stopWaToSec4 == 0 ){
		return "4"
	}
	if( tglo_stopWaToSec5 == 0 ){
		return "5"
	}
	return "error"
}

; 今からの時間で指定の場合で、
; 1h 1m 1s などの指定の仕方で実行する
Timer_Text_startNumeralFromWord(hour_min_sec_word="1m 1s", listNumber="_", reloadNotFlag=False){
	tmpStr := sufltif_colonFormatHMSSentence(hour_min_sec_word)
	allSec := outstime_confirmAndGetAllSecFromWord(tmpStr)
	if(allSec == "error"){
		gutimf_appendErrorExplain("Timer_Text_startNumeralFromWord の関数のエラー。`n1h  1m  1s  といった文字列を指定してください。")
		return "0"
	}
	hour := outstime_confirmTimerArgssHourOnly(tmpStr, A_ThisFunc)
	min := outstime_confirmTimerArgssMinuteOnly(tmpStr, A_ThisFunc)
	sec := outstime_confirmTimerArgssSecondOnly(tmpStr, A_ThisFunc)

	if(listNumber == "_"){
		listNumber := guf_getControl( "List21_2", 21 )
	} else if(listNumber == "any"){
		listNumber := Timer_Text_getNoInUseListNumberForNumeral()
		if( listNumber == "error" ){
			gutimf_appendErrorExplain("Timer_Text_startNumeralFromWord()のエラー。`n空いているリストがない。`n今からの時間で指定  " . hour_min_sec_word)
			return "0"
		}
	}
	returnValue := time_stopWatch(hour, min, sec, listNumber)
	if( reloadNotFlag == False ){
		Timer_Text_listReloadForNumeral()
	}
	return returnValue
}


; アラームの番号を指定
Timer_Text_setAlarmNumberForTime(number=1){
	outstime_setRadioControl(number, "Radio22_1", "Radio22_2", "Radio22_3", "Radio22_4", 22)
}

Timer_Text_setAlarmNumberForNumeral(number=1){
	outstime_setRadioControl(number, "Radio25_1", "Radio25_2", "Radio25_3", "Radio25_4", 25)
}

; 表示する文字を指定
Timer_Text_setMemorandumForTime(memo=""){
	guf_setControl( memo, "Edit22_1", 22 )
}

Timer_Text_setMemorandumForNumeral(memo=""){
	guf_setControl( memo, "Edit25_1", 25 )
}

; 代わりにソフトを実行する場合の指定
; 引数に _ （アンダーバー）を指定すると、何もしない
Timer_Text_setSoftForTime(filePath="_", args="_", workDir="_", softExeFlag=True){
	guf_setControl( softExeFlag, "Checkbox23_1", 23 )
	if(filePath != "_"){
		guf_setControl( filePath, "Edit23_1", 23 )
	}
	if(args != "_"){
		guf_setControl( args, "Edit23_2", 23 )
	}
	if(workDir != "_"){
		guf_setControl( workDir, "Edit23_3", 23 )
	}

	;guf_switchEnableByFlag(softExeFlag, "Edit23_1", 23)
	;guf_switchEnableByFlag(softExeFlag, "Edit23_2", 23)
	;guf_switchEnableByFlag(softExeFlag, "Edit23_3", 23)
	;time_autoSetEdit23_1()
}

Timer_Text_setSoftForNumeral(filePath="_", args="_", workDir="_", softExeFlag=True){
	guf_setControl( softExeFlag, "Checkbox26_1", 26 )
	if(filePath != "_"){
		guf_setControl( filePath, "Edit26_1", 26 )
	}
	if(args != "_"){
		guf_setControl( args, "Edit26_2", 26 )
	}
	if(workDir != "_"){
		guf_setControl( workDir, "Edit26_3", 26 )
	}
}

; 多くの関数で使用するので、分けた
Timer_Text_setTimerItemLogicForTime(itemName, functionName){
	res := sufltif_setItemLogicTime(itemName)
	if( res ){
		return True
	}
	gutimf_appendErrorExplain(functionName . " のエラー。`nアイテムが見つからない`n" . itemName)
	return False
}

Timer_Text_setTimerItemLogicForNumeral(itemName, functionName){
	res := sufltif_setItemLogicNumeral(itemName)
	if( res ){
		return True
	}
	gutimf_appendErrorExplain(functionName . " のエラー。`nアイテムが見つからない`n" . itemName)
	return False
}

; アイテム名から、ファイルパスなどをセットする。
; チェックボックスもオンにする
Timer_Text_setTimerItemForTime(itemName){
	returnValue := Timer_Text_setTimerItemLogicForTime(itemName, "Timer_Text_setTimerItemForTime()")
	return returnValue
}

Timer_Text_setTimerItemForNumeral(itemName){
	returnValue := Timer_Text_setTimerItemLogicForNumeral(itemName, "Timer_Text_setTimerItemForNumeral()")
	return returnValue
}

; アイテム名を指定して、スタートボタン
; 時刻で
Timer_Text_startTimeFromDateTimeAndTimerItemName(itemName, dateTime=235959, listNumber="_", reloadNotFlag=False){
	returnValue := Timer_Text_setTimerItemLogicForTime(itemName, "Timer_Text_startTimeFromDateTimeAndTimerItemName()")
	if( returnValue ){
		if(listNumber == "_"){
			listNumber := guf_getControl( "List20_1", 20 )
		} else if(listNumber == "any"){
			listNumber := Timer_Text_getNoInUseListNumberForTime()
			if( listNumber == "error" ){
				gutimf_appendErrorExplain("Timer_Text_startTimeFromDateTimeAndTimerItemName()のエラー。`n空いているリストがない。`n時刻の指定  " . dateTime)
				return "0"
			}
		}
		dateTime := sufltif_colonFormatDateTime6Char(dateTime)
		if( time_checkErrorFormatDateTimeUseText(dateTime) ){
			gutimf_appendErrorExplain("Timer_Text_startTimeFromDateTimeAndTimerItemName()のエラー。`n時刻の書式のエラー。`n時刻の指定  " . dateTime)
			return "0"
		}
		dateTime := sufltif_formatDateTimeUseText(dateTime)
		returnValue := time_timerExecute(dateTime, listNumber)
		if( returnValue ){
			if( reloadNotFlag == False ){
				Timer_Text_listReloadForTime()
			}
		}
	}
	return returnValue
}

; 今からの時間で
Timer_Text_startNumeralFromHourMinSecAndTimerItemName(itemName, hour=0, min=0, sec=0, listNumber="_", reloadNotFlag=False){
	returnValue := Timer_Text_setTimerItemLogicForNumeral(itemName, "Timer_Text_startNumeralFromHourMinSecAndTimerItemName()")
	if( returnValue ){
		if(listNumber == "_"){
			listNumber := guf_getControl( "List21_2", 21 )
		} else if(listNumber == "any"){
			listNumber := Timer_Text_getNoInUseListNumberForNumeral()
			if( listNumber == "error" ){
				gutimf_appendErrorExplain("Timer_Text_startNumeralFromHourMinSecAndTimerItemName()のエラー。`n空いているリストがない。`n今からの時間で指定  " . hour . "時間  " . min . "分  " . sec . "秒")
				return "0"
			}
		}
		returnValue := time_stopWatch(hour, min, sec, listNumber)
		if( returnValue ){
			if( reloadNotFlag == False ){
				Timer_Text_listReloadForNumeral()
			}
		}
	}
	return returnValue
}


; 今使用しているのが、時刻で指定するウインドウなら、False を
; 今からの時間で指定するウインドウなら、True を返す
Timer_Text_getInUseWindowIsNumeralFlag(){
	return tglo_mainIsNumeralWindowFlag
}

; メインのウインドウを表示
Timer_Text_showTimeOrNumeral(order="_"){
	if( tglo_mainIsNumeralWindowFlag ){
		guf_showGuiAssign(21, order)
	} else {
		guf_showGuiAssign(20, order)
	}
}

; メインのウインドウを表示か非表示
Timer_Text_showTimeOrNumeralToggle(minimizeFlag=True, order="_"){
	GuiNum = 20
	if( tglo_mainIsNumeralWindowFlag ){
		GuiNum = 21
	}
	winTitle := glotimer_Gui%GuiNum%Title
	if( minimizeFlag ){
		WinGet,OutputVar, MinMax, %winTitle%
		; 最小化してるかどうか
		if( OutputVar == -1 ){
			guf_showGuiAssign(GuiNum, order)
		} else {
			IfWinExist, %winTitle%
			{
				Gui, %GuiNum%:Minimize
			} else {
				guf_showGuiAssign(GuiNum, order)
			}
		}
		return
	}
	guf_showHideGuiToggle(winTitle, GuiNum, order)
}

; 複数の場所で使うので分けた。今からの時間の方を使用中なら、位置を取得して時刻の方を表示
Timer_Text_showExchangeTimeLogic(){
	tglo_mainIsNumeralWindowFlag := False
	IfWinExist , %glotimer_Gui21Title%
	{
		GUI, 21:Restore
		WinWaitActive , A, , 1
		WinGetPos, posX, posY, width, height, %glotimer_Gui21Title%
		Gui, 21:Hide
		WinWaitActive , A, , 1
		Gui, 20:Show, x%posX% y%posY%
		return
	}
	Gui, 20:Show
}

Timer_Text_showTimeWindow(){
	if( tglo_mainIsNumeralWindowFlag ){
		Timer_Text_showExchangeTimeLogic()
		return
	}
	Gui, 20:Show
}

; 複数の場所で使うので分けた。時刻の方を使用中なら、位置を取得して今からの時間の方表示
Timer_Text_showExchangeNumeralLogic(){
	tglo_mainIsNumeralWindowFlag := True
	IfWinExist , %glotimer_Gui20Title%
	{
		GUI, 20:Restore
		WinWaitActive , A, , 1
		WinGetPos, posX, posY, width, height, %glotimer_Gui20Title%
		Gui, 20:Hide
		WinWaitActive , A, , 1
		Gui, 21:Show, x%posX% y%posY%
		return
	}
	Gui, 21:Show
}

Timer_Text_showNumeralWindow(){
	if( tglo_mainIsNumeralWindowFlag ){
		Gui, 21:Show
		return
	}
	Timer_Text_showExchangeNumeralLogic()
}

; 今使用しているのと逆のウインドウを表示
Timer_Text_showExchangeTimeOrNumeral(){
	if( tglo_mainIsNumeralWindowFlag ){
		Timer_Text_showExchangeTimeLogic()
	} else {
		Timer_Text_showExchangeNumeralLogic()
	}
}

; 設定のウインドウ表示
Timer_Text_showAssignWindowForTimeToggle(order="_"){
	guf_showHideGuiToggle(glotimer_Gui22Title, 22, order)
}

Timer_Text_showAssignWindowForNumeralToggle(order="_"){
	guf_showHideGuiToggle(glotimer_Gui25Title, 25, order)
}

; ソフトのウインドウ表示
Timer_Text_showSoftWindowForTimeToggle(order="_"){
	IfWinExist, %glotimer_Gui23Title%
	{
		Gui, 23:Hide
	} else {
		gutimf_showSoftWindowTimer(order)
	}
}

Timer_Text_showSoftWindowForNumeralToggle(order="_"){
	IfWinExist, %glotimer_Gui26Title%
	{
		Gui, 26:Hide
	} else {
		gutimf_showSoftWindowAssignBySec(order)
	}
}

; ソフト自体の設定用のウインドウ表示
Timer_Text_showOptionAllWindowToggle(order="_"){
	IfWinExist, %glotimer_Gui24Title%
	{
		Gui, 24:Hide
	} else {
		cont_optionGuiShow(order)
	}
}

Timer_Text_showErrorWindowToggle(order="_"){
	guf_showHideGuiToggle(glotimer_Gui33Title, 33, order)
}

; エラーメッセージを表示
Timer_Text_errorOutput(append){
	gutimf_appendErrorExplain(append)
}

; 追加ではなくて、上書き表示
Timer_Text_errorOutputSingle(single){
	gutimf_explainSingleOutput(single)
}

; 実行中のタイマーがあるか確認して警告をだして、終了する
Timer_Text_exitTimer(){
	cetimer_exitAppsConfirmEnyExecution()
}

; 警告を出さずに、終了する
Timer_Text_exitTimerWithoutAdvice(){
	cetimer_exitAppsLogic()
}

; 実行中のタイマーが無いなら終了する。警告は出さない
Timer_Text_exitTimerIfNotHave(){
	buff := cetimer_getExpressionEveryExecution()
	if( buff == "" ){
		Sleep, 1000
		cetimer_exitAppsLogic()
	}
}

; タイマーを実行した後に終了するの設定の影響を受ける
; 実行中のタイマーが無いなら終了する。警告は出さない
Timer_Text_exitTimerIfNotHaveAndOption(){
	cetimer_exitAppsIfNotHaveExecution()
}

; アラームが鳴る場合のウインドウを表示
Timer_Text_showAlarmWindow(expression="", order="_"){
	str =
	if( expression == "" ){
		str := "時間です"
	} else {
		str := expression . "  の時間です"
	}
	guf_setControl( str, "Text28_1", 28 )
	guf_showGuiAssign(28, order)
}

; アラームを鳴らす。ウインドウも表示する
Timer_Text_alarmRing(alarmNumber=1, expression=""){
	If alarmNumber not between 1 and 4
	{
		gutimf_appendErrorExplain(A_ThisFunc . "() のエラー。`nalarmNumber の数が正しくない。")
		return
	}
	glotimer_bellNotePlaying := glotimer_bellNote%alarmNumber%
	SoundPlay, %glotimer_bellNotePlaying%
	time_alarmLenthSet(alarmNumber)
	tglo_alarmOnTimeStopFlag := False
	Sleep, 100
	Timer_Text_showAlarmWindow(expression, "_")
}

; アラームを鳴らすが、ウインドウは表示しない
Timer_Text_alarmRingNotShow(alarmNumber=1){
	If alarmNumber not between 1 and 4
	{
		gutimf_appendErrorExplain(A_ThisFunc . "() のエラー。`nalarmNumber の数が正しくない。")
		return
	}
	glotimer_bellNotePlaying := glotimer_bellNote%alarmNumber%
	SoundPlay, %glotimer_bellNotePlaying%
	time_alarmLenthSet(alarmNumber)
	tglo_alarmOnTimeStopFlag := False
}

; 保存用リストにセーブする
; 時刻で
Timer_Text_saveListForTime(saveListNumber=1, title=""){
	if(saveListNumber == ""){
		gutimf_appendErrorExplain("Timer_Text_saveListForTime()のエラー。`n保存するリストが選ばれていない")
		return False
	}

	listName := "時刻" . saveListNumber
	iniFile := glotimer_timerListIniFile
	title := Trim(title)

	tsl_timerListSaveLogic(listName, title, iniFile)

	; タイトル名の保存
	IniWrite, %title%, %iniFile%, listTitleSection, titleName%saveListNumber%
	gutimf_checkErrorLevelExplain(listName  . " のリストの保存時に`n何らかのエラーがある。")

	;リストを更新
	tsl_changeTimerListTitle()
	return True
}

; 今からの時間で
Timer_Text_saveListForNumeral(saveListNumber=1, title="") {
	if(saveListNumber == ""){
		gutimf_appendErrorExplain("Timer_Text_saveListForTime()のエラー。`n保存するリストが選ばれていない")
		return False
	}
	listName := "数字指定" . saveListNumber
	iniFile := glotimer_stopWatchIniFile
	title := Trim(title)

	tsl_stopWaListSaveLogic(listName, title, iniFile)

	; タイトル名の保存
	IniWrite, %title%, %iniFile%, stopWaListTitleSection, titleName%saveListNumber%
	gutimf_checkErrorLevelExplain(listName  . " のリストの保存時に`n何らかのエラーがある。")

	;リストを更新
	tsl_changeStopWaListTitle()
	return True
}

; 保存用リストからロードする
; 時刻で
Timer_Text_loadSaveListForTime(saveListNumber=1){
	listName := "時刻" . saveListNumber
	if(saveListNumber == ""){
		gutimf_appendErrorExplain("Timer_Text_loadSaveListForTime()のエラー。`n保存するリストが選ばれていない")
		return False
	}
	tsl_timerListLoadLogic(listName, glotimer_timerListIniFile)
	return True
}

; 今からの時間で
Timer_Text_loadSaveListForNumeral(saveListNumber=1){
	listName := "数字指定" . saveListNumber
	if(saveListNumber == ""){
		gutimf_appendErrorExplain("Timer_Text_loadSaveListForNumeral()のエラー。`n保存するリストが選ばれていない")
		return False
	}
	tsl_stopWaListLoadLogic(listName, glotimer_stopWatchIniFile)
	return True
}

; アイテムを登録する。
; ただし、ファイルには保存しないので、終了するまでの間だけ。
Timer_Text_newTimerItemFromCommand(itemName, filePath, args="", workDir=""){
	itemName := Trim(itemName)
	filePath := Trim(filePath)
	workDir := Trim(workDir)
	if(itemName == ""){
		gutimf_appendErrorExplain("newTimerItemFromCommand()のエラー。`nアイテム名がカラ")
		return False
	}
	if( IsObject(glotimer_softObj[itemName]) ){
		gutimf_appendErrorExplain("newTimerItemFromCommand()のエラー。`nその名前はすでに使用されています。`n" . itemName)
		return False
	}
	res := RegExMatch(itemName, "^[0-9a-zA-Z_@-]+$")
	if(res != 1) {
		gutimf_appendErrorExplain("newTimerItemFromCommand()のエラー。`n無効な文字が入ってます。`n" . itemName)
		return False
	}
	if(filePath == ""){
		gutimf_appendErrorExplain("newTimerItemFromCommand()のエラー。`nソフトのパスがカラなので登録できない。")
		return False
	}

	itef_softObjInsert(filePath, args, workDir, itemName, glotimer_softObj)
	return True
}

; 全角文字の数字を半角の数字に変換
Timer_Text_fullNumeralReplacehalf(timeWord){
	timeWord := func_stringReplace(timeWord, "０", "0", True)
	timeWord := func_stringReplace(timeWord, "１", "1", True)
	timeWord := func_stringReplace(timeWord, "２", "2", True)
	timeWord := func_stringReplace(timeWord, "３", "3", True)
	timeWord := func_stringReplace(timeWord, "４", "4", True)
	timeWord := func_stringReplace(timeWord, "５", "5", True)
	timeWord := func_stringReplace(timeWord, "６", "6", True)
	timeWord := func_stringReplace(timeWord, "７", "7", True)
	timeWord := func_stringReplace(timeWord, "８", "8", True)
	timeWord := func_stringReplace(timeWord, "９", "9", True)
	return timeWord
}

; 漢数字を半角の数に変換する
; ここでは単純に数字のみを変換する
Timer_Text_kanjiReplaceIntegerSimplicity(timeWord){
	timeWord := func_stringReplace(timeWord, "零", "0", True)
	timeWord := func_stringReplace(timeWord, "一", "1", True)
	timeWord := func_stringReplace(timeWord, "二", "2", True)
	timeWord := func_stringReplace(timeWord, "三", "3", True)
	timeWord := func_stringReplace(timeWord, "四", "4", True)
	timeWord := func_stringReplace(timeWord, "五", "5", True)
	timeWord := func_stringReplace(timeWord, "六", "6", True)
	timeWord := func_stringReplace(timeWord, "七", "7", True)
	timeWord := func_stringReplace(timeWord, "八", "8", True)
	timeWord := func_stringReplace(timeWord, "九", "9", True)
	return timeWord
}


; 現時点では 万 までしか対応できない
; 右の文字から、下の桁の 0 の追加が必要か判断して 0 を追加して返す。
; fullChar が 万 で指定しているとしたら、underDigit は 4 にする。
Timer_Text_getUnderDigitAndRightStr(rightStr, underDigit, originWord){
	StringLen, num, rightStr
	digitTmp := underDigit + 1
	; 右の文字が 5 文字以上でテストしてみる
	if(num >= digitTmp){
		StringLeft, rightStr_left, rightStr, %digitTmp%
		; fullChar の右 5 文字が 全部数字なら解析できない。
		If rightStr_left is integer
		{
			gutimf_appendErrorExplain("漢数字を数値に変換する関数のエラー。`n以下の文字は解析できない。`n解析中の文字列  " . rightStr . "`n元の文字列  " . originWord)
			return "error"
		}
	}

	; 右の文字が 4 文字以上の場合
	if(num >= underDigit){
		StringLeft, rightStr_left, rightStr, %underDigit%
		; fullChar の右 4 文字が 全部数字なら何もしない。そのまま返す。
		If rightStr_left is integer
		{
			return rightStr
		}
	}

	underDigit -= 1
	; 十 なら underDigit は 0 なので、ここで終了する。
	if(underDigit <= 0){
		rightStr := "0" . rightStr
		return rightStr
	}
	; 右の文字が 3 文字以上の場合
	if(num >= underDigit){
		StringLeft, rightStr_left, rightStr, %underDigit%
		; fullChar の右 3 文字が 数字なら 0 を一つ足すだけ
		; 万123時間 の場合、0123時間 が下の桁
		If rightStr_left is integer
		{
			rightStr := "0" . rightStr
			return rightStr
		}
	}

	underDigit -= 1
	; 百 なら underDigit は 0 なので、ここで終了する。
	if(underDigit <= 0){
		rightStr := "00" . rightStr
		return rightStr
	}
	; 右の文字が 2 文字以上の場合
	if(num >= underDigit){
		StringLeft, rightStr_left, rightStr, %underDigit%
		; fullChar の右 2 文字が 数字なら 0 を二つ足す
		; 万23時間 の場合、0023時間 が下の桁
		If rightStr_left is integer
		{
			rightStr := "00" . rightStr
			return rightStr
		}
	}

	underDigit -= 1
	; 千 なら underDigit は 0 なので、ここで終了する。
	if(underDigit <= 0){
		rightStr := "000" . rightStr
		return rightStr
	}
	; 右の文字が 1 文字以上の場合
	if(num >= underDigit){
		StringLeft, rightStr_left, rightStr, %underDigit%
		; fullChar の右 1 文字が 数字なら 0 を三つ足す
		; 万3時間 の場合、0003時間 が下の桁
		If rightStr_left is integer
		{
			rightStr := "000" . rightStr
			return rightStr
		}
	}
	; fullChar の右 1文字が 数字でないなら 0 を四つ足す
	; 万時間 の場合、0000時間 が下の桁
	rightStr := "0000" . rightStr
	return rightStr
}

; 十 百 千 万 の文字を変換する
; この関数で一つの漢数字ずつ変換する
Timer_Text_kanjiReplaceIntegerOneSign(timeWord, fullChar, digitNum, originWord){
	IfNotInString, timeWord, %fullChar%
	{
		return timeWord
	}
	StringGetPos, index, timeWord, %fullChar%
	; fullChar の左の文字
	StringLeft, leftStr, timeWord, %index%

	indexPlus := index + 1
	; fullChar の右の文字
	StringTrimLeft, rightStr, timeWord, %indexPlus%

	; 十だったら digitNum は 2
	; underDigit は 1
	underDigit := digitNum - 1

	; 右の文字から、下の桁の 0 の追加が必要か判断して 0 を追加して返す。
	rightStr := Timer_Text_getUnderDigitAndRightStr(rightStr, underDigit, originWord)
	if(rightStr == "error"){
		return "error"
	}

	; fullChar の左 １文字が 数字なら十を消すだけ。
	; fullChar の左 １文字が 数字でないなら、十を消し、代わりに 1 に置き換える。
	StringLen, num, leftStr
	if(num >= 2){
		; もし、12百 などのように、数値が２つ右にあった場合は、解析できない数字とする。
		StringRight, leftStr_chr2, leftStr, 2
		If leftStr_chr2 is integer
		{
			gutimf_appendErrorExplain("漢数字を数値に変換する関数のエラー。`n以下の文字は解析できない。`n解析中の文字列  " . timeWord . "`n" . fullChar . " の左の文字  " . leftStr . "`n元の文字列  " . originWord)
			return "error"
		}
	}
	if(num >= 1){
		; fullChar の左 １文字が 数字でないなら、十を消し、代わりに 1 に置き換える。
		StringRight, leftStr_lChr, leftStr, 1
		If leftStr_lChr is not integer
		{
			leftStr .= "1"
		}
	}
	if(leftStr == ""){
		; fullChar の左 文字がない場合も、十を消し、代わりに 1 に置き換える。
		leftStr .= "1"
	}
	timeWord := leftStr . rightStr
	return timeWord
}

; 漢数字を半角の数字に変換する
Timer_Text_kanjiReplaceInteger(timeWord, originWord){
	timeWord := Timer_Text_kanjiReplaceIntegerSimplicity(timeWord)
	timeWord := Timer_Text_kanjiReplaceIntegerOneSign(timeWord, "十", 2, originWord)
	timeWord := Timer_Text_kanjiReplaceIntegerOneSign(timeWord, "百", 3, originWord)
	timeWord := Timer_Text_kanjiReplaceIntegerOneSign(timeWord, "千", 4, originWord)
	timeWord := Timer_Text_kanjiReplaceIntegerOneSign(timeWord, "万", 5, originWord)
	return timeWord
}

; 漢数字と全角文字の数字を半角の数字に変換する
Timer_Text_kanjiAndFullNumeralReplaceInteger(timeWord, originWord){
	; 全角文字の数字を半角の数字に変換
	timeWord := Timer_Text_fullNumeralReplacehalf(timeWord)
	; 漢数字を半角の数字に変換する
	timeWord := Timer_Text_kanjiReplaceInteger(timeWord, originWord)
	return timeWord
}


; 試しに作ってみたが、現時点では使っていない
; 時間 分 秒 の左の文字から数字を取得
Timer_Text_getOneOfHourMinSecFromKanji(timeWord, target, originWord){
	returnValue = 0
	IfNotInString, timeWord, %target%
	{
		return returnValue
	}
	StringGetPos, index, timeWord, %target%
	StringLeft, leftStr, timeWord, %index%
	if(leftStr == ""){
		gutimf_appendErrorExplain("Timer_Text_startNumeralFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n指定がカラ。`n元の文字列  " . sentence)
		return "error"
	}
	returnValue := Timer_Text_kanjiAndFullNumeralReplaceInteger(leftStr, originWord)
	if(returnValue == "error"){
		gutimf_appendErrorExplain("Timer_Text_startNumeralFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。")
		return "error"
	}

	return returnValue
}

; スタートボタン
; 漢数字や全角文字でも指定できる。
; 時  分  秒  の単語から、時間を解析して実行する。
; 時刻で
Timer_Text_startTimeFromKanji(sentence="二十三時三分三十秒", listNumber="_", reloadNotFlag=False){

	sentence := Trim(sentence)

	if(listNumber == "_"){
		listNumber := guf_getControl( "List20_1", 20 )
	} else if(listNumber == "any"){
		listNumber := Timer_Text_getNoInUseListNumberForTime()
		if( listNumber == "error" ){
			gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji()のエラー。`n空いているリストがない。`n時刻の指定  " . sentence)
			return "0"
		}
	}

	; dateTime の数字の場合、4桁の数字などは日付扱いされるのでやめる。
	;If sentence is time
	;{
	;	returnValue := time_timerExecute(sentence, listNumber)
	;	if( reloadNotFlag == False ){
	;		Timer_Text_listReloadForTime()
	;	}
	;	return returnValue
	;}

	tmpSentence := sufltif_colonFormatDateTime6Char(sentence)
	; 6桁の数字でも、実行できる。
	if( time_checkErrorFormatDateTimeUseText(tmpSentence) == False ){
		tmpSentence := sufltif_formatDateTimeUseText(tmpSentence)
		tmpSentence := func_changeTodayDateTime(tmpSentence)
		If tmpSentence is time
		{
			returnValue := time_timerExecute(tmpSentence, listNumber)
			if( reloadNotFlag == False ){
				Timer_Text_listReloadForTime()
			}
			return returnValue
		}
	}

	; sentence はとっておくので、別の変数を用意してそちらを使う
	timeWord := sentence
	; 全角スペースを半角スペースに
	timeWord := func_stringReplace(timeWord, "　", A_Space, True)

	; hour の初期値は ?? に
	hour := "??"
	min := "00"
	sec := "00"
	target := "時"
	IfInString, timeWord, %target%
	{
		StringGetPos, index, timeWord, %target%
		StringLeft, leftStr, timeWord, %index%
		leftStr := Trim(leftStr)
		; 時 の左側の文字に空白があったら、その右端のみを参考にする
		IfInString, leftStr, %A_Space%
		{
			StringGetPos, index2, leftStr, %A_Space%, R1
			StringTrimLeft, rightStr, leftStr, %index2%
			leftStr := LTrim( rightStr )
		}
		; 左端に 午後 の文字があれば、 hour に12を足す
		pmFlag := False
		StringLen, num, leftStr
		if(num >= 3){
			StringLeft, leftStr_chr2, leftStr, 2
			if(leftStr_chr2 == "午後"){
				pmFlag := True
				StringTrimLeft, leftStr, leftStr, 2
			} else if(leftStr_chr2 == "午前"){
				StringTrimLeft, leftStr, leftStr, 2
			}
		}

		if(leftStr == ""){
			gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n指定がカラ。`n元の文字列  " . sentence)
			return "0"
		}
		hour := Timer_Text_kanjiAndFullNumeralReplaceInteger(leftStr, sentence)
		if(hour == "error"){
			gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。")
			return "0"
		}
		hour := Trim(hour)
		If hour is not number
		{
			gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n時間が数字ではない。`n時間  " . hour)
			return "0"
		}

		if( pmFlag ){
			hour += 12
		}

		; 時間 の文字の右のみを timeWord に変える
		StringGetPos, index, timeWord, %target%
		indexPlus := index + 1
		StringTrimLeft, timeWord, timeWord, %indexPlus%

		; 半 の文字は ３０分 扱い
		StringLeft, lChr, timeWord, 1
		if( lChr == "半" ){
			min = 30
			; 半 の文字の右のみを timeWord に変える
			StringTrimLeft, timeWord, timeWord, 1
		}
	}

	target := "分"
	IfInString, timeWord, %target%
	{
		StringGetPos, index, timeWord, %target%
		StringLeft, leftStr, timeWord, %index%
		leftStr := Trim(leftStr)
		; 分 の左側の文字に空白があったら、その右端のみを参考にする
		IfInString, leftStr, %A_Space%
		{
			StringGetPos, index2, leftStr, %A_Space%, R1
			StringTrimLeft, rightStr, leftStr, %index2%
			leftStr := LTrim( rightStr )
		}
		if(leftStr == ""){
			gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n指定がカラ。`n元の文字列  " . sentence)
			return "0"
		}
		min := Timer_Text_kanjiAndFullNumeralReplaceInteger(leftStr, sentence)
		if(min == "error"){
			gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。")
			return "0"
		}
		min := Trim(min)
		If min is not number
		{
			gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n分が数字ではない。`n分  " . min)
			return "0"
		}

		; 分 の文字の右のみを timeWord に変える
		StringGetPos, index, timeWord, %target%
		indexPlus := index + 1
		StringTrimLeft, timeWord, timeWord, %indexPlus%

		; 半 の文字は ３０秒 扱い
		StringLeft, lChr, timeWord, 1
		if( lChr == "半" ){
			sec = 30
			; 半 の文字の右のみを timeWord に変える
			StringTrimLeft, timeWord, timeWord, 1
		}
	}

	target := "秒"
	IfInString, timeWord, %target%
	{
		StringGetPos, index, timeWord, %target%
		StringLeft, leftStr, timeWord, %index%
		leftStr := Trim(leftStr)
		; 秒 の左側の文字に空白があったら、その右端のみを参考にする
		IfInString, leftStr, %A_Space%
		{
			StringGetPos, index2, leftStr, %A_Space%, R1
			StringTrimLeft, rightStr, leftStr, %index2%
			leftStr := LTrim( rightStr )
		}
		if(leftStr == ""){
			gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n指定がカラ。`n元の文字列  " . sentence)
			return "0"
		}
		sec := Timer_Text_kanjiAndFullNumeralReplaceInteger(leftStr, sentence)
		if(sec == "error"){
			gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。")
			return "0"
		}
		sec := Trim(sec)
		If sec is not number
		{
			gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n秒が数字ではない。`n秒  " . sec)
			return "0"
		}
	}

	if(hour == "??"){
		gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji() の関数のエラー。`n時間の部分が指定されていない。`n元の文字列  " . sentence)
		return "0"
	}
	StringLen, num, hour
	if(num == 1){
		hour := "0" . hour
	} else if(num != 2){
		gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji() の関数のエラー。`n桁数が不自然。`n時間  " . hour . "`n元の文字列  " . sentence)
		return "0"
	}
	StringLen, num, min
	if(num == 1){
		min := "0" . min
	} else if(num != 2){
		gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji() の関数のエラー。`n桁数が不自然。`n分  " . min . "`n元の文字列  " . sentence)
		return "0"
	}
	StringLen, num, sec
	if(num == 1){
		sec := "0" . sec
	} else if(num != 2){
		gutimf_appendErrorExplain("Timer_Text_startTimeFromKanji() の関数のエラー。`n桁数が不自然。`n秒  " . sec . "`n元の文字列  " . sentence)
		return "0"
	}

	dateTime = %hour%%min%%sec%

	;if(listNumber == "_"){
	;	listNumber := guf_getControl( "List20_1", 20 )
	;}
	returnValue := time_timerExecute(dateTime, listNumber)
	if( reloadNotFlag == False ){
		Timer_Text_listReloadForTime()
	}
	return returnValue
}

; スタートボタン
; 漢数字や全角文字でも指定できる。
; 時間  分  秒  の単語から、時間を解析して実行する。
; 今からの時間で
Timer_Text_startNumeralFromKanji(sentence="三分三十秒", listNumber="_", reloadNotFlag=False){

	sentence := Trim(sentence)

	if(listNumber == "_"){
		listNumber := guf_getControl( "List21_2", 21 )
	} else if(listNumber == "any"){
		listNumber := Timer_Text_getNoInUseListNumberForNumeral()
		if( listNumber == "error" ){
			gutimf_appendErrorExplain("Timer_Text_startNumeralFromKanji()のエラー。`n空いているリストがない。`n今からの時間で指定  " . sentence)
			return "0"
		}
	}

	; 1h 1m 1s などの指定の仕方で実行する
	tmpSentence := sufltif_colonFormatHMSSentence(sentence)
	allSec := outstime_confirmAndGetAllSecFromWord(tmpSentence)
	if(allSec != "error"){
		hour := outstime_confirmTimerArgssHourOnly(tmpSentence, A_ThisFunc)
		min := outstime_confirmTimerArgssMinuteOnly(tmpSentence, A_ThisFunc)
		sec := outstime_confirmTimerArgssSecondOnly(tmpSentence, A_ThisFunc)

		returnValue := time_stopWatch(hour, min, sec, listNumber)
		if( reloadNotFlag == False ){
			Timer_Text_listReloadForNumeral()
		}
		return returnValue
	}

	; sentence はとっておくので、別の変数を用意してそちらを使う
	timeWord := sentence
	; 全角スペースを半角スペースに
	timeWord := func_stringReplace(timeWord, "　", A_Space, True)

	anyFlag := False
	hour = 0
	min = 0
	sec = 0
	target := "時間"
	IfInString, timeWord, %target%
	{
		StringGetPos, index, timeWord, %target%
		StringLeft, leftStr, timeWord, %index%
		leftStr := Trim(leftStr)
		; 時間 の左側の文字に空白があったら、その右端のみを参考にする
		IfInString, leftStr, %A_Space%
		{
			StringGetPos, index2, leftStr, %A_Space%, R1
			StringTrimLeft, rightStr, leftStr, %index2%
			leftStr := LTrim( rightStr )
		}
		if(leftStr == ""){
			gutimf_appendErrorExplain("Timer_Text_startNumeralFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n指定がカラ。`n元の文字列  " . sentence)
			return "0"
		}
		hour := Timer_Text_kanjiAndFullNumeralReplaceInteger(leftStr, sentence)
		if(hour == "error"){
			gutimf_appendErrorExplain("Timer_Text_startNumeralFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。")
			return "0"
		}
		hour := Trim(hour)
		If hour is not number
		{
			gutimf_appendErrorExplain("Timer_Text_startNumeralFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n時間が数字ではない。`n時間  " . hour)
			return "0"
		}

		; 時間 の文字の右のみを timeWord に変える
		StringGetPos, index, timeWord, %target%
		indexPlus := index + 2
		StringTrimLeft, timeWord, timeWord, %indexPlus%

		; 半 の文字は ３０分 扱い
		StringLeft, lChr, timeWord, 1
		if( lChr == "半" ){
			min = 30
			; 半 の文字の右のみを timeWord に変える
			StringTrimLeft, timeWord, timeWord, 1
		}
		anyFlag := True
	}

	target := "分"
	IfInString, timeWord, %target%
	{
		StringGetPos, index, timeWord, %target%
		StringLeft, leftStr, timeWord, %index%
		leftStr := Trim(leftStr)
		; 分 の左側の文字に空白があったら、その右端のみを参考にする
		IfInString, leftStr, %A_Space%
		{
			StringGetPos, index2, leftStr, %A_Space%, R1
			StringTrimLeft, rightStr, leftStr, %index2%
			leftStr := LTrim( rightStr )
		}
		if(leftStr == ""){
			gutimf_appendErrorExplain("Timer_Text_startNumeralFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n指定がカラ。`n元の文字列  " . sentence)
			return "0"
		}
		min := Timer_Text_kanjiAndFullNumeralReplaceInteger(leftStr, sentence)
		if(min == "error"){
			gutimf_appendErrorExplain("Timer_Text_startNumeralFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。")
			return "0"
		}
		min := Trim(min)
		If min is not number
		{
			gutimf_appendErrorExplain("Timer_Text_startNumeralFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n分が数字ではない。`n分  " . min)
			return "0"
		}

		; 分 の文字の右のみを timeWord に変える
		StringGetPos, index, timeWord, %target%
		indexPlus := index + 1
		StringTrimLeft, timeWord, timeWord, %indexPlus%

		; 半 の文字は ３０秒 扱い
		StringLeft, lChr, timeWord, 1
		if( lChr == "半" ){
			sec = 30
			; 半 の文字の右のみを timeWord に変える
			StringTrimLeft, timeWord, timeWord, 1
		}
		anyFlag := True
	}


	target := "秒"
	IfInString, timeWord, %target%
	{
		StringGetPos, index, timeWord, %target%
		StringLeft, leftStr, timeWord, %index%
		leftStr := Trim(leftStr)
		; 秒 の左側の文字に空白があったら、その右端のみを参考にする
		IfInString, leftStr, %A_Space%
		{
			StringGetPos, index2, leftStr, %A_Space%, R1
			StringTrimLeft, rightStr, leftStr, %index2%
			leftStr := LTrim( rightStr )
		}
		if(leftStr == ""){
			gutimf_appendErrorExplain("Timer_Text_startNumeralFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n指定がカラ。`n元の文字列  " . sentence)
			return "0"
		}
		sec := Timer_Text_kanjiAndFullNumeralReplaceInteger(leftStr, sentence)
		if(sec == "error"){
			gutimf_appendErrorExplain("Timer_Text_startNumeralFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。")
			return "0"
		}
		sec := Trim(sec)
		If sec is not number
		{
			gutimf_appendErrorExplain("Timer_Text_startNumeralFromKanji() の関数のエラー。`n" . target . "  の指定でエラー。`n秒が数字ではない。`n秒  " . sec)
			return "0"
		}
		anyFlag := True
	}

	if( anyFlag == False ){
		gutimf_appendErrorExplain("Timer_Text_startNumeralFromKanji() の関数のエラー。`n時間の指定がされていない。`n文字列  " . sentence)
		return "0"
	}
	;if(listNumber == "_"){
	;	listNumber := guf_getControl( "List21_2", 21 )
	;}
	returnValue := time_stopWatch(hour, min, sec, listNumber)
	if( reloadNotFlag == False ){
		Timer_Text_listReloadForNumeral()
	}
	return returnValue
}
