





; マージン用　設定したフォントのサイズによって変化させる
; halveSub  halvePlus  を元の数字に対して割った数を、プラス、マイナスさせる（数が小さいほど影響が大きい）
cetimer_marginNumFromFontSize(halveSub, halvePlus, marginNum){
	if(tglo_iniSetTimerAllFontSize == 1){
		halvedNum := marginNum // halveSub
		subNum := halvedNum * 2
		marginNum -= subNum
	} else if(tglo_iniSetTimerAllFontSize == 2){
		halvedNum := marginNum // halveSub
		marginNum -= halvedNum
	} else if(tglo_iniSetTimerAllFontSize == 3){
		halvedNum := marginNum // halveSub
		marginNum -= halvedNum
	} else if(tglo_iniSetTimerAllFontSize == 5){
		halvedNum := marginNum // halvePlus
		marginNum += halvedNum
	} else if(tglo_iniSetTimerAllFontSize == 6){
		halvedNum := marginNum // halvePlus
		marginNum += halvedNum
	} else if(tglo_iniSetTimerAllFontSize == 7){
		halvedNum := marginNum // halvePlus
		plusNum := halvedNum * 2
		marginNum += plusNum
	} else if(tglo_iniSetTimerAllFontSize == 8){
		halvedNum := marginNum // halvePlus
		plusNum := halvedNum * 2
		marginNum += plusNum
	}
	return marginNum
}

; 設定したフォントのサイズとDPI（PCの解像度）によって、取得する値が変えられる。
; variationNum にフォントのサイズによっておこる小さな変化を起こす値を入れる。
cetimer_timerNumFromDpiAndFontSize(variationMinus, variationPlus, lessThan110, lessThan140, moreThan140){
	plus = 0
	if(tglo_iniSetTimerAllFontSize == 1){
		plus := variationMinus * -3
	} else if(tglo_iniSetTimerAllFontSize == 2){
		plus := variationMinus * -2
	} else if(tglo_iniSetTimerAllFontSize == 3){
		plus := variationMinus * -1
	} else if(tglo_iniSetTimerAllFontSize == 5){
		plus := variationPlus
	} else if(tglo_iniSetTimerAllFontSize == 6){
		plus := variationPlus * 2
	} else if(tglo_iniSetTimerAllFontSize == 7){
		plus := variationPlus * 3
	} else if(tglo_iniSetTimerAllFontSize == 8){
		plus := variationPlus * 4
	}
	lessThan110 += plus
	lessThan140 += plus
	moreThan140 += plus
	returnValue := gutimf_anyOfNumFromDpi(lessThan110, lessThan140, moreThan140)
	return returnValue
}

; 設定したフォントのサイズとDPI（PCの解像度）によって、取得する値が変えられる。
cetimer_timerFontFromDpiAndFontSize(lessThan110, lessThan140, moreThan140){
	plus = 0
	if(tglo_iniSetTimerAllFontSize == 1){
		plus := -3
	} else if(tglo_iniSetTimerAllFontSize == 2){
		plus := -2
	} else if(tglo_iniSetTimerAllFontSize == 3){
		plus := -1
	} else if(tglo_iniSetTimerAllFontSize == 5){
		plus := 1
	} else if(tglo_iniSetTimerAllFontSize == 6){
		plus := 2
	} else if(tglo_iniSetTimerAllFontSize == 7){
		plus := 3
	} else if(tglo_iniSetTimerAllFontSize == 8){
		plus := 4
	}
	lessThan110 += plus
	lessThan140 += plus
	moreThan140 += plus
	returnValue := gutimf_anyOfNumFromDpi(lessThan110, lessThan140, moreThan140)
	return returnValue
}

; 終了するとき、時刻の指定と、数字指定のどちらを使っていたか
cetimer_whichMainUseExit(){
	;DetectHiddenWindows, Off
	flagNum = 1
	IfWinExist, %glotimer_Gui20Title%
	{
		flagNum = 0
	}
	IniWrite, %flagNum%, %glotimer_windowSizePosIni%, __windowUse__, whichStart
}

/*
cetimer_whichMainUseHide(){
	IfWinExist, %glotimer_Gui20Title%
	{
		tglo_mainIsNumeralWindowFlag = 0
	} else {
		tglo_mainIsNumeralWindowFlag = 1
	}
}
*/

cetimer_showStartUseWindow(){
	if( tglo_iniSetStartWindow ){
		Gui, 21:Show
	} else {
		Gui, 20:Show
	}
}

cetimer_showInUseWindow(){
	if( tglo_mainIsNumeralWindowFlag ){
		Gui, 21:Show
	} else {
		Gui, 20:Show
	}
}

cetimer_windowSizePosSaveAll(){
	DetectHiddenWindows, On
	func_folderCheckMakeFolder(glotimer_userDir)
	outstime_windowSizePosSaveIniWrite(glotimer_Gui20Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniWrite(glotimer_Gui21Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniWrite(glotimer_Gui22Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniWrite(glotimer_Gui23Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniWrite(glotimer_Gui24Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniWrite(glotimer_Gui25Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniWrite(glotimer_Gui26Title, glotimer_windowSizePosIni)
	; 音楽ファイルの設定のウインドウは何もしない
	outstime_windowSizePosSaveIniWrite(glotimer_Gui28Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniWrite(glotimer_Gui29Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniWrite(glotimer_Gui31Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniWrite(glotimer_Gui32Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniWrite(glotimer_Gui33Title, glotimer_windowSizePosIni)
	;outstime_windowSizePosSaveIniWrite(glotimer_Gui34Title, glotimer_windowSizePosIni)
	;gutimf_checkErrorLevelExplain("ウインドウの位置とサイズの保存時にエラーあり")
}

cetimer_windowSizePosLoadAll(){
	DetectHiddenWindows, On
	outstime_windowSizePosSaveIniRead(glotimer_Gui20Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniRead(glotimer_Gui21Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniRead(glotimer_Gui22Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniRead(glotimer_Gui23Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniRead(glotimer_Gui24Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniRead(glotimer_Gui25Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniRead(glotimer_Gui26Title, glotimer_windowSizePosIni)
	; 音楽ファイルの設定のウインドウは何もしない
	outstime_windowSizePosSaveIniRead(glotimer_Gui28Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniRead(glotimer_Gui29Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniRead(glotimer_Gui31Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniRead(glotimer_Gui32Title, glotimer_windowSizePosIni)
	outstime_windowSizePosSaveIniRead(glotimer_Gui33Title, glotimer_windowSizePosIni)
	;outstime_windowSizePosSaveIniRead(glotimer_Gui34Title, glotimer_windowSizePosIni)
}


; どれかのタイマーが実行中なら True を返す
cetimer_confirmEnyExecution(){
	returnValue := False
	if( tglo_timerToSec1 >= 1 ){
		returnValue := True
	} else if( tglo_timerToSec2 >= 1 ){
		returnValue := True
	} else if( tglo_timerToSec3 >= 1 ){
		returnValue := True
	} else if( tglo_timerToSec4 >= 1 ){
		returnValue := True
	} else if( tglo_timerToSec5 >= 1 ){
		returnValue := True
	} else if( tglo_stopWaToSec1 >= 1 ){
		returnValue := True
	} else if( tglo_stopWaToSec2 >= 1 ){
		returnValue := True
	} else if( tglo_stopWaToSec3 >= 1 ){
		returnValue := True
	} else if( tglo_stopWaToSec4 >= 1 ){
		returnValue := True
	} else if( tglo_stopWaToSec5 >= 1 ){
		returnValue := True
	}
	return returnValue
}

cetimer_differentWordIfNull(word, differentWord){
	if( word == "" ){
		word := differentWord
	}
	return word
}

; 実行中のタイマーの 「表示する文字」 を全て蓄えて返す
cetimer_getExpressionEveryExecution(){
	buff =
	if( tglo_timerToSec1 >= 1 ){
		tmpStr := cetimer_differentWordIfNull(tglo_timerExpression1, "時間指定１")
		buff .= tmpStr . "`n"
	}
	if( tglo_timerToSec2 >= 1 ){
		tmpStr := cetimer_differentWordIfNull(tglo_timerExpression2, "時間指定２")
		buff .= tmpStr . "`n"
	}
	if( tglo_timerToSec3 >= 1 ){
		tmpStr := cetimer_differentWordIfNull(tglo_timerExpression3, "時間指定３")
		buff .= tmpStr . "`n"
	}
	if( tglo_timerToSec4 >= 1 ){
		tmpStr := cetimer_differentWordIfNull(tglo_timerExpression4, "時間指定４")
		buff .= tmpStr . "`n"
	}
	if( tglo_timerToSec5 >= 1 ){
		tmpStr := cetimer_differentWordIfNull(tglo_timerExpression5, "時間指定５")
		buff .= tmpStr . "`n"
	}
	if( tglo_stopWaToSec1 >= 1 ){
		tmpStr := cetimer_differentWordIfNull(tglo_stopWaExpression1, "数字指定１")
		buff .= tmpStr . "`n"
	}
	if( tglo_stopWaToSec2 >= 1 ){
		tmpStr := cetimer_differentWordIfNull(tglo_stopWaExpression2, "数字指定２")
		buff .= tmpStr . "`n"
	}
	if( tglo_stopWaToSec3 >= 1 ){
		tmpStr := cetimer_differentWordIfNull(tglo_stopWaExpression3, "数字指定３")
		buff .= tmpStr . "`n"
	}
	if( tglo_stopWaToSec4 >= 1 ){
		tmpStr := cetimer_differentWordIfNull(tglo_stopWaExpression4, "数字指定４")
		buff .= tmpStr . "`n"
	}
	if( tglo_stopWaToSec5 >= 1 ){
		tmpStr := cetimer_differentWordIfNull(tglo_stopWaExpression5, "数字指定５")
		buff .= tmpStr . "`n"
	}
	return buff
}

cetimer_exitAppsLogic(){
	time_soundClose()
	cetimer_whichMainUseExit()
	cetimer_windowSizePosSaveAll()
	ExitApp
}

; 実行中のタイマーがあるか確認して警告をだして、終了する
cetimer_exitAppsConfirmEnyExecution(){
	buff := cetimer_getExpressionEveryExecution()

	if( buff == "" ){
		cetimer_exitAppsLogic()
	}

	warningStr := "実行中のタイマーがある。`n終了してよいか？`n" . buff . "がまだ実行中"
	MsgBox , 4099, 終了の確認, %warningStr%
	IfMsgBox, Yes
	{
		cetimer_exitAppsLogic()
	}
}

; タイマーを実行した後に終了する設定の場合
; 実行中のタイマーが無いなら終了。
cetimer_exitAppsIfNotHaveExecution(){
	if( tglo_iniSetNoticeAppEndFlag ){
		buff := cetimer_getExpressionEveryExecution()

		if( buff == "" ){
			time_soundClose()
			Gui, 28:Hide
			Sleep, 1000
			cetimer_exitAppsLogic()
		}
	}
}

cetimer_textIconSetIfExistFileTimer(){
	glotimer_iconTimer := outstime_iconPictureEnyExtFileTimer(glotimer_docDir . glotimer_iconTimerDefault)
	glotimer_iconStopWatch := outstime_iconPictureEnyExtFileTimer(glotimer_docDir . glotimer_iconStopWatchDefault)

	if( glotimer_iconTimer == "" ){
		glotimer_iconTimer := glotimer_trayIcon
	}
	if( glotimer_iconStopWatch == "" ){
		glotimer_iconStopWatch := glotimer_trayIcon
	}
}
