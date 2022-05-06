


cont_alarmPatternGuiShow(alarmNum){
	guf_setControl( alarmNum, "HiddenEdit27_1", 27 )
	guf_setControl( tglo_iniAlarmLength%alarmNum%, "UpDown27_2", 27 )
	guf_setControl( glotimer_bellNote%alarmNum%, "Edit27_3", 27 )
	guf_setControl( tglo_iniReAlarmPeriod%alarmNum%, "UpDown27_4", 27 )
	textStr := "アラームの「パターン" . alarmNum . "」 の設定"
	guf_setControl( textStr, "Text27_1", 27 )
	glotimer_Gui27Title := "アラームのパターン" . alarmNum . " の設定"
	Sleep, 200
	Gui, 27:Show, , %glotimer_Gui27Title%
}

cont_alarmConfigDefaultButton(alarmNum, pControl, guiNum){
	guf_setControl( glotimer_bellNoteDefault%alarmNum%, pControl, guiNum )
}

cont_inialarmValuesSet(num){
	bellNoteDefault := glotimer_bellNoteDefault%num%
	IniRead, OutputVar2, %glotimer_settingIni%, alarmPattern%num%, AlarmLength , 120
	IniRead, OutputVar3, %glotimer_settingIni%, alarmPattern%num%, alarm , %bellNoteDefault%
	IniRead, OutputVar4, %glotimer_settingIni%, alarmPattern%num%, alarmRePertSec , 16
	tglo_iniAlarmLength%num%  = %OutputVar2%

	; おまけ要素  %%で囲んだ文字を展開する
	OutputVar3_ch := outstime_textOutTrimssParsent(OutputVar3)
	glotimer_bellNote%num%  =  %OutputVar3_ch%

	tglo_iniReAlarmPeriod%num% = %OutputVar4%
}

; 起動時に早めに実行する設定
cont_beforehandIniOptionSet(){
	IniRead, out1, %glotimer_settingIni%, mainOption, timerAllFontSize ,4
	IniRead, out2, %glotimer_settingIni%, mainOption, timerAllFontName , %A_Space%
	IniRead, out3, %glotimer_settingIni%, mainOption, noticeCloseKeyName , %A_Space%

	tglo_iniSetTimerAllFontSize = %out1%
	tglo_iniSetTimerAllFontName = %out2%
	tglo_iniSetNoticeCloseKeyName = %out3%
}

cont_iniOptionSet(){
	cont_inialarmValuesSet(1)
	cont_inialarmValuesSet(2)
	cont_inialarmValuesSet(3)
	cont_inialarmValuesSet(4)
	IniRead, OutputVar1, %glotimer_settingIni%, mainOption, SetTextPeriod , 5
	IniRead, OutputVar2, %glotimer_settingIni%, mainOption, noticeCloseNotFlag , 0
	IniRead, OutputVar3, %glotimer_settingIni%, mainOption, exitIfWinCloseNotFlag , 0
	IniRead, OutputVar4, %glotimer_settingIni%, mainOption, noticeGuiShowNotFlag , 0
	IniRead, OutputVar5, %glotimer_settingIni%, mainOption, noticeAppEndFlag , 0
	tglo_iniSetTextPeriod_sec = %OutputVar1%
	tglo_iniSetNoticeCloseNotFlag = %OutputVar2%
	tglo_iniSetExitIfWinCloseNotFlag = %OutputVar3%
	tglo_iniSetNoticeGuiShowNotFlag = %OutputVar4%
	tglo_iniSetNoticeAppEndFlag = %OutputVar5%
}

cont_optionGuiShow(order="_"){

	guf_setControl( tglo_iniSetTextPeriod_sec, "UpDown24_1", 24 )
	guf_setControl( tglo_iniSetNoticeCloseNotFlag, "Checkbox24_1", 24 )
	guf_setControl( tglo_iniSetExitIfWinCloseNotFlag, "Checkbox24_2", 24 )
	guf_GuiControl("DropDownList24_1", 24, "Choose", tglo_iniSetTimerAllFontSize)
	guf_setControl( tglo_iniSetTimerAllFontName, "Edit24_2", 24 )
	guf_setControl( tglo_iniSetNoticeCloseKeyName, "Edit24_3", 24 )
	guf_setControl( "", "Hotkey24_1", 24 )
	guf_setControl( tglo_iniSetNoticeGuiShowNotFlag, "Checkbox24_3", 24 )
	guf_setControl( tglo_iniSetNoticeAppEndFlag, "Checkbox24_4", 24 )

	Sleep, 200
	guf_showGuiAssign(24, order)
}

cont_alarmOptionSubmit(Edit2, Edit3, Edit4, alarmNum){

	outstime_fileCheckAndMakeFolder(glotimer_settingIni, glotimer_userDir)

	; おまけ要素  %%で囲んだ文字を展開する
	textOutEdit3 := outstime_textOutTrimssParsent(Edit3)

	Edit2 := Trim(Edit2)
	textOutEdit3 := Trim(textOutEdit3)
	Edit4 := Trim(Edit4)
	if(textOutEdit3 == ""){		; アラームのファイルがカラならデフォルトのを入れる
		bellNoteDefault := glotimer_bellNoteDefault%alarmNum%
		textOutEdit3 = %bellNoteDefault%
		Edit3 = %bellNoteDefault%
	}

	tglo_iniAlarmLength%alarmNum%  = %Edit2%
	if(Edit2 == ""){
		gutimf_appendErrorExplain("アラームを鳴らす時間のエラー`nカラなので、`n初期値を設定する")
		tglo_iniAlarmLength%alarmNum% = 120
		Edit2 = 120
	}
	if(Edit2 >= 10000){
		gutimf_appendErrorExplain("アラームを鳴らす時間のエラー`n10000以上を指定できないため、`n初期値を設定する")
		tglo_iniAlarmLength%alarmNum% = 120
		Edit2 = 120
	}
	glotimer_bellNote%alarmNum%  =  %textOutEdit3%
	tglo_iniReAlarmPeriod%alarmNum% = %Edit4%
	if(Edit4 == ""){
		gutimf_appendErrorExplain("繰り返して再生するまでの時間のエラー`nカラなので、`n初期値を設定する")
		tglo_iniReAlarmPeriod%alarmNum% = 16
		Edit4 = 16
	}
	if(Edit4 >= 10000){
		gutimf_appendErrorExplain("繰り返して再生するまでの時間のエラー`n10000以上を指定できないため、`n初期値を設定する")
		tglo_iniReAlarmPeriod%alarmNum% = 16
		Edit4 = 16
	}

	IniWrite, %Edit2%, %glotimer_settingIni%, alarmPattern%alarmNum%, AlarmLength
	IniWrite, %Edit3%, %glotimer_settingIni%, alarmPattern%alarmNum%, alarm
	IniWrite, %Edit4%, %glotimer_settingIni%, alarmPattern%alarmNum%, alarmRePertSec
	gutimf_checkErrorLevelExplain("", A_LineFile, A_LineNumber)
}

cont_optionSubmit(){
	outstime_fileCheckAndMakeFolder(glotimer_settingIni, glotimer_userDir)
	tglo_iniSetTextPeriod_sec := guf_getControl( "UpDown24_1", 24 )
	if(tglo_iniSetTextPeriod_sec == ""){
		gutimf_appendErrorExplain("あと何秒を表示する間隔のエラー`nカラなので、`n初期値を設定する")
		tglo_iniSetTextPeriod_sec = 5
	}
	If tglo_iniSetTextPeriod_sec is not number
	{
		gutimf_appendErrorExplain("あと何秒を表示する間隔のエラー`n数字ではないのでエラー。`n初期値を設定する")
		tglo_iniSetTextPeriod_sec = 5
	}
	if(tglo_iniSetTextPeriod_sec <= 0){
		gutimf_appendErrorExplain("あと何秒を表示する間隔のエラー`n0 を指定できないため、`n初期値を設定する")
		tglo_iniSetTextPeriod_sec = 5
	}
	if(tglo_iniSetTextPeriod_sec >= 1000){
		gutimf_appendErrorExplain("あと何秒を表示する間隔のエラー`n1000以上を指定できないため、`n初期値を設定する")
		tglo_iniSetTextPeriod_sec = 5
	}
	tglo_iniSetNoticeCloseNotFlag := guf_getControl( "Checkbox24_1", 24 )
	tglo_iniSetExitIfWinCloseNotFlag := guf_getControl( "Checkbox24_2", 24 )
	; 再起動しないと反映しない設定も、グローバル変数に代入する
	tglo_iniSetTimerAllFontSize := guf_getControl( "DropDownList24_1", 24 )
	tglo_iniSetTimerAllFontName := guf_getControl( "Edit24_2", 24 )
	tglo_iniSetNoticeCloseKeyName := guf_getControl( "Edit24_3", 24 )
	tglo_iniSetNoticeGuiShowNotFlag := guf_getControl( "Checkbox24_3", 24 )
	tglo_iniSetNoticeAppEndFlag := guf_getControl( "Checkbox24_4", 24 )


	IniWrite, %tglo_iniSetTextPeriod_sec%, %glotimer_settingIni%, mainOption, SetTextPeriod
	IniWrite, %tglo_iniSetNoticeCloseNotFlag%, %glotimer_settingIni%, mainOption, noticeCloseNotFlag
	IniWrite, %tglo_iniSetExitIfWinCloseNotFlag%, %glotimer_settingIni%, mainOption, exitIfWinCloseNotFlag
	IniWrite, %tglo_iniSetTimerAllFontSize%, %glotimer_settingIni%, mainOption, timerAllFontSize
	IniWrite, %tglo_iniSetTimerAllFontName%, %glotimer_settingIni%, mainOption, timerAllFontName
	IniWrite, %tglo_iniSetNoticeCloseKeyName%, %glotimer_settingIni%, mainOption, noticeCloseKeyName
	IniWrite, %tglo_iniSetNoticeGuiShowNotFlag%, %glotimer_settingIni%, mainOption, noticeGuiShowNotFlag
	IniWrite, %tglo_iniSetNoticeAppEndFlag%, %glotimer_settingIni%, mainOption, noticeAppEndFlag
}
