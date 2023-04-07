




; 指定した文字の 右の文字を返す。なければ 空の文字を返す
arutif_rightStrOrNullFromSearchStr(str, searchStr){
	IfNotInString, str, %searchStr%
	{
		return  ""
	}
	StringGetPos, count, str, %searchStr%
	StringLen, length, searchStr
	count += length
	StringTrimLeft, rStr , str, %count%
	rStr  := Trim(rStr )
	return  rStr 
}

; 指定した文字の 左の文字を返す。なければ 空の文字を返す
arutif_leftStrOrNullFromSearchStr(str, searchStr){
	IfNotInString, str, %searchStr%
	{
		return  ""
	}
	StringGetPos, count, str, %searchStr%
	StringLeft, leftStr, str, %count%
	leftStr := Trim(leftStr)
	return  leftStr
}

arutif_saveListExecuteTime(saveListNum){
	listName := "時刻" . saveListNum
	iniFile := glotimer_timerListIniFile
	res := tsl_timerListLoadLogic(listName, iniFile)
	if( res == 0 ){
		gutimf_appendErrorExplain("起動時のパラメータのエラー。`ntimelist= 指定のエラー。`n以下の番号のリストは内容がカラである`n" . saveListNum)
		return
	}
	; 値が反映されるまで念のため待機
	Sleep, 1000
	dateTime := guf_getControl( "DateTime20_1", 20 )
	;listNum := guf_getControl( "List20_1", 20 )
	time_timerExecute(dateTime, 1)
}

arutif_confirmSaveListExecuteTime(arg){
	rightStr := arutif_rightStrOrNullFromSearchStr(arg, "=")
	if(rightStr == ""){
		gutimf_appendErrorExplain("起動時のパラメータのエラー。`ntimelist= 指定のエラー。`n指定がカラ")
		return
	}
	If rightStr is not integer
	{
		gutimf_appendErrorExplain("起動時のパラメータのエラー。`ntimelist= 指定のエラー。`n数字が指定されていない。`n" . arg)
		return
	}
	If rightStr not between 1 and 20
	{
		gutimf_appendErrorExplain("起動時のパラメータのエラー。`ntimelist= 指定のエラー。`n数字が 1 から 20 の数字しか指定できない。`n" . arg)
		return
	}
	arutif_saveListExecuteTime(rightStr)
}

arutif_saveListExecuteNumeral(saveListNum){
	listName := "数字指定" . saveListNum
	iniFile := glotimer_stopWatchIniFile
	res := tsl_stopWaListLoadLogic(listName, iniFile)
	if( res == 0 ){
		gutimf_appendErrorExplain("起動時のパラメータのエラー。`nnumerallist= 指定のエラー。`n以下の番号のリストは内容がカラである`n" . saveListNum)
		return
	}
	; 値が反映されるまで念のため待機
	Sleep, 1000
	hour := guf_getControl( "UpDown21_1", 21 )
	min := guf_getControl( "UpDown21_2", 21 )
	sec := guf_getControl( "UpDown21_3", 21 )
	;listNum := guf_getControl( "List21_2", 21 )
	time_stopWatch(hour, min, sec, 1)
}

arutif_confirmSaveListExecuteNumeral(arg){
	rightStr := arutif_rightStrOrNullFromSearchStr(arg, "=")
	if(rightStr == ""){
		gutimf_appendErrorExplain("起動時のパラメータのエラー。`nnumerallist= 指定のエラー。`n指定がカラ")
		return
	}
	If rightStr is not integer
	{
		gutimf_appendErrorExplain("起動時のパラメータのエラー。`nnumerallist= 指定のエラー。`n数字が指定されていない。`n" . arg)
		return
	}
	If rightStr not between 1 and 20
	{
		gutimf_appendErrorExplain("起動時のパラメータのエラー。`nnumerallist= 指定のエラー。`n数字が 1 から 20 の数字しか指定できない。`n" . arg)
		return
	}
	arutif_saveListExecuteNumeral(rightStr)
}

; ６桁の数字、または dateTime の形式の数字なら、時刻で実行する。
; 23:59:59 などの書式 でも可能。
; 返り値は、実行するリストの番号。ミスがある場合と、該当しないときは 0 を返す。
arutif_confirmDateTime6CharExecuteTime(argAll){
	returnValue = 0
	if(argAll == ""){
		return returnValue
	}
	; dateTime の数字の場合、4桁の数字などは日付扱いされるのでやめる。
	;If argAll is time
	;{
		;listNum := guf_getControl( "List20_1", 20 )
	;	returnValue := time_timerExecute(argAll, 1)
	;	return returnValue
	;}

	; 23:59:59 などの書式なら、６桁の数字にして返す。
	tmpArgAll := sufltif_colonFormatDateTime6Char(argAll)
	; 6桁の数字でも、実行できる。
	if( time_checkErrorFormatDateTimeUseText(tmpArgAll) == False ){
		tmpArgAll := sufltif_formatDateTimeUseText(tmpArgAll)
		tmpArgAll := func_changeTodayDateTime(tmpArgAll)
		If tmpArgAll is time
		{
			;listNum := guf_getControl( "List20_1", 20 )
			returnValue := time_timerExecute(tmpArgAll, 1)
			return returnValue
		}
	}
	return returnValue
}

; 23h 59m 59s の文字列なら、今からの時間指定で実行する。
; 返り値は、実行するリストの番号。ミスがある場合と、該当しないときは 0 を返す。
arutif_confirmHourMinSecExecuteNumeral(argAll){
	returnValue = 0
	if(argAll == ""){
		return returnValue
	}
	allSec := outstime_confirmAndGetAllSecFromWord(argAll)
	if(allSec != "error"){
		hour := outstime_confirmTimerArgssHourOnly(argAll, A_ThisFunc)
		min := outstime_confirmTimerArgssMinuteOnly(argAll, A_ThisFunc)
		sec := outstime_confirmTimerArgssSecondOnly(argAll, A_ThisFunc)
		;listNum := guf_getControl( "List21_2", 21 )
		returnValue := time_stopWatch(hour, min, sec, 1)
		return returnValue
	}
	return returnValue
}

arutif_argUseExeTimerAll(arg1, arg2, arg3, arg4){

	if(arg1 == "time"){
		tglo_iniSetStartWindow := False
		tglo_mainIsNumeralWindowFlag := False
		return
	} else if(arg1 == "numeral"){
		tglo_iniSetStartWindow := True
		tglo_mainIsNumeralWindowFlag := True
		return
	}

	leftStr := arutif_leftStrOrNullFromSearchStr(arg1, "=")
	StringLower, leftStr, leftStr
	if(leftStr == "timelist"){
		tglo_iniSetStartWindow := False
		tglo_mainIsNumeralWindowFlag := False
		arutif_confirmSaveListExecuteTime(arg1)
		return
	} else if(leftStr == "numerallist"){
		tglo_iniSetStartWindow := True
		tglo_mainIsNumeralWindowFlag := True
		arutif_confirmSaveListExecuteNumeral(arg1)
		return
	}

	if(leftStr == "timeitem"){
		tglo_iniSetStartWindow := False
		tglo_mainIsNumeralWindowFlag := False
		rightStr := arutif_rightStrOrNullFromSearchStr(arg1, "=")
		res := sufltif_setItemLogicTime(rightStr)
		if( res == False ){
			gutimf_appendErrorExplain("起動時のパラメータのエラー。`ntimeitem= 指定のエラー`n以下の登録ソフトが見つからない。`n" . rightStr)
			return
		}
		; arg2 が ６桁の数字なら、時刻で実行する
		num := arutif_confirmDateTime6CharExecuteTime(arg2)
		if( num >= 1 ){
			time_changeListTimer()
		}
		return
	}
	; ６桁の数字なら、時刻で実行する
	num := arutif_confirmDateTime6CharExecuteTime(arg1)
	if( num >= 1 ){
		tglo_iniSetStartWindow := False
		tglo_mainIsNumeralWindowFlag := False
		time_changeListTimer()
		return
	}

	argAll := arg1 . " " . arg2 . " " . arg3 . " " . arg4
	argAll := Trim(argAll)
	if(leftStr == "numeralitem"){
		tglo_iniSetStartWindow := True
		tglo_mainIsNumeralWindowFlag := True
		; argAll の１つめの空白の左のみを使う
		leftStrSpace := func_separationSpaceLeftOrAll(argAll)
		rightStr := arutif_rightStrOrNullFromSearchStr(leftStrSpace, "=")
		res := sufltif_setItemLogicNumeral(rightStr)
		if( res == False ){
			gutimf_appendErrorExplain("起動時のパラメータのエラー。`nnumeralitem= 指定のエラー`n以下の登録ソフトが見つからない。`n" . rightStr)
			return
		}
		; argAll の１つめの空白の右が 23h 59m 59s の文字列なら、今からの時間指定で実行する。
		rightStrSpace := arutif_rightStrOrNullFromSearchStr(argAll, A_Space)
		num := arutif_confirmHourMinSecExecuteNumeral(rightStrSpace)
		if( num >= 1 ){
			time_changeListStopWatch()
		}
		return
	}
	; 23h 59m 59s の文字列なら、今からの時間指定で実行する。
	num := arutif_confirmHourMinSecExecuteNumeral(argAll)
	if( num >= 1 ){
		tglo_iniSetStartWindow := True
		tglo_mainIsNumeralWindowFlag := True
		time_changeListStopWatch()
		return
	}
	gutimf_appendErrorExplain("起動時のパラメータのエラー。`nこのパラメータは使用できない`n" . argAll)
}
