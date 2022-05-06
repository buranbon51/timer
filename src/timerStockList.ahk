




tsl_changeTimerListTitle(){

	buff := "|"
	Loop , 20
	{
		IniRead, titleTmp, %glotimer_timerListIniFile%, listTitleSection, titleName%A_Index% , 時刻%A_Index%
		titleTmp := Trim(titleTmp)
		if(titleTmp == ""){
			titleTmp := "時刻" . A_Index
		}
		if(A_Index == 1){
			buff .= titleTmp  . "|"
		} else {
			buff .= "|" . titleTmp
		}
	}

	buff := RTrim(buff, "|")
	guf_setControl( buff, "List31_1", 31 )
}

tsl_changeStopWaListTitle(){

	buff := "|"
	Loop , 20
	{
		IniRead, titleTmp, %glotimer_stopWatchIniFile%, stopWaListTitleSection, titleName%A_Index% , 数字指定%A_Index%
		titleTmp := Trim(titleTmp)
		if(titleTmp == ""){
			titleTmp := "数字指定" . A_Index
		}
		if(A_Index == 1){
			buff .= titleTmp  . "|"
		} else {
			buff .= "|" . titleTmp
		}
	}

	buff := RTrim(buff, "|")
	guf_setControl( buff, "List32_1", 32 )
}

tsl_timerListSave(listNum, title) {
	if(listNum != ""){
		listName := "時刻" . listNum
		MsgBox, 4129, 保存の確認, %listName% を保存していいか？, 60
		IfMsgBox, OK
		{
			iniFile := glotimer_timerListIniFile
			title := Trim(title)

			tsl_timerListSaveLogic(listName, title, iniFile)

			; タイトル名の保存
			IniWrite, %title%, %iniFile%, listTitleSection, titleName%listNum%
			gutimf_checkErrorLevelExplain(listName  . " のリストの保存時に`n何らかのエラーがある。")

			;リストを更新
			tsl_changeTimerListTitle()

			;今のリストを選択状態に
			guf_GuiControl("List31_1", 31, "Choose", listNum)
			gutimf_checkErrorLevelExplain("リスト の更新時にエラーあり")
		}
	} else {
		gutimf_explainSingleOutput("保存するリストが選ばれていない")
	}
}

tsl_timerListSaveLogic(listName, title, iniFile) {
	; 日付の部分は無視して、時間の部分だけをセーブする
	dateTime := guf_getControl( "DateTime20_1", 20 )
	StringRight, timeOnly, dateTime, 6

	radioNum := outstime_guiRadioControl("Radio22_1", "Radio22_2", "Radio22_3", "Radio22_4", 22)
	Edit22_1 := guf_getControl( "Edit22_1", 22 )

	Checkbox23_1 := guf_getControl( "Checkbox23_1", 23 )
	Edit23_1 := guf_getControl( "Edit23_1", 23 )
	Edit23_2 := guf_getControl( "Edit23_2", 23 )
	Edit23_3 := guf_getControl( "Edit23_3", 23 )

	outstime_fileCheckAndMakeFolder(iniFile, glotimer_userDir)
	IniWrite, %title%, %iniFile%, %listName%, titleKey
	IniWrite, %timeOnly%, %iniFile%, %listName%, timeOnlyKey
	IniWrite, %radioNum%, %iniFile%, %listName%, alarmKey
	IniWrite, %Edit22_1%, %iniFile%, %listName%, expressionKey
	IniWrite, %Checkbox23_1%, %iniFile%, %listName%, appFlagKey
	IniWrite, %Edit23_1%, %iniFile%, %listName%, appNameKey
	IniWrite, %Edit23_2%, %iniFile%, %listName%, appArgsKey
	IniWrite, %Edit23_3%, %iniFile%, %listName%, appWorkDirKey

}

tsl_stopWaListSave(listNum, title) {
	if(listNum != ""){
		listName := "数字指定" . listNum
		MsgBox, 4129, 保存の確認, %listName% を保存していいか？, 60
		IfMsgBox, OK
		{
			iniFile := glotimer_stopWatchIniFile
			title := Trim(title)

			tsl_stopWaListSaveLogic(listName, title, iniFile)

			; タイトル名の保存
			IniWrite, %title%, %iniFile%, stopWaListTitleSection, titleName%listNum%
			gutimf_checkErrorLevelExplain(listName  . " のリストの保存時に`n何らかのエラーがある。")

			;リストを更新
			tsl_changeStopWaListTitle()

			;今のリストを選択状態に
			guf_GuiControl("List32_1", 32, "Choose", listNum)
			gutimf_checkErrorLevelExplain("リスト の更新時にエラーあり")
		}
	} else {
		gutimf_explainSingleOutput("保存するリストが選ばれていない")
	}
}

tsl_stopWaListSaveLogic(listName, title, iniFile) {
	UpDown21_1 := guf_getControl( "UpDown21_1", 21 )
	UpDown21_2 := guf_getControl( "UpDown21_2", 21 )
	UpDown21_3 := guf_getControl( "UpDown21_3", 21 )

	radioNum := outstime_guiRadioControl("Radio25_1", "Radio25_2", "Radio25_3", "Radio25_4", 25)
	Edit25_1 := guf_getControl( "Edit25_1", 25 )

	Checkbox26_1 := guf_getControl( "Checkbox26_1", 26 )
	Edit26_1 := guf_getControl( "Edit26_1", 26 )
	Edit26_2 := guf_getControl( "Edit26_2", 26 )
	Edit26_3 := guf_getControl( "Edit26_3", 26 )

	outstime_fileCheckAndMakeFolder(iniFile, glotimer_userDir)
	IniWrite, %title%, %iniFile%, %listName%, titleStopWaKey

	IniWrite, %UpDown21_1%, %iniFile%, %listName%, stopWaTimeKey1
	IniWrite, %UpDown21_2%, %iniFile%, %listName%, stopWaTimeKey2
	IniWrite, %UpDown21_3%, %iniFile%, %listName%, stopWaTimeKey3

	IniWrite, %radioNum%, %iniFile%, %listName%, alarmStopWaKey
	IniWrite, %Edit25_1%, %iniFile%, %listName%, expressionStopWaKey
	IniWrite, %Checkbox26_1%, %iniFile%, %listName%, appFlagStopWaKey
	IniWrite, %Edit26_1%, %iniFile%, %listName%, appNameStopWaKey
	IniWrite, %Edit26_2%, %iniFile%, %listName%, appArgsStopWaKey
	IniWrite, %Edit26_3%, %iniFile%, %listName%, appWorkDirStopWaKey
}

tsl_timerListLoad(listNum) {
	listName := "時刻" . listNum
	if(listNum != ""){
		MsgBox, 4129, 読み込みの確認, %listName% を表示していいか？, 60
		IfMsgBox, OK
		{
			iniFile := glotimer_timerListIniFile
			tsl_timerListLoadLogic(listName, iniFile)
		}
	} else {
		gutimf_explainSingleOutput("読み出すリストが選ばれていない")
	}
}

; 読みだしたリストがカラなら、 0 を返す。正常なら 1 を返す
tsl_timerListLoadLogic(listName, iniFile){

	returnValue = 1
	IniRead, OutTitle, %iniFile%, %listName%, titleKey , %A_Space%
	IniRead, Out1, %iniFile%, %listName%, timeOnlyKey , %A_Space%
	IniRead, Out2, %iniFile%, %listName%, alarmKey , 1
	IniRead, Out3, %iniFile%, %listName%, expressionKey , %A_Space%
	IniRead, Out4, %iniFile%, %listName%, appFlagKey , 0
	IniRead, Out5, %iniFile%, %listName%, appNameKey , %A_Space%
	IniRead, Out6, %iniFile%, %listName%, appArgsKey , %A_Space%
	IniRead, Out7, %iniFile%, %listName%, appWorkDirKey , %A_Space%

	guf_setControl( OutTitle, "Edit31_1", 31 )

	if(Out1 == ""){
		Out1 = %A_Now%
		returnValue = 0
	} else {
		; 今日の日付をつける
		Out1 := A_YYYY . A_MM . A_DD . Out1
	}
	guf_setControl( Out1, "DateTime20_1", 20 )
	outstime_setRadioControl(Out2, "Radio22_1", "Radio22_2", "Radio22_3", "Radio22_4", 22)
	guf_setControl( Out3, "Edit22_1", 22 )
	guf_setControl( Out4, "Checkbox23_1", 23 )
	guf_setControl( Out5, "Edit23_1", 23 )
	guf_setControl( Out6, "Edit23_2", 23 )
	guf_setControl( Out7, "Edit23_3", 23 )
	return returnValue
}

tsl_stopWaListLoad(listNum) {
	listName := "数字指定" . listNum
	if(listNum != ""){
		MsgBox, 4129, 読み込みの確認, %listName% を表示していいか？, 60
		IfMsgBox, OK
		{
			iniFile := glotimer_stopWatchIniFile
			tsl_stopWaListLoadLogic(listName, iniFile)
		}
	} else {
		gutimf_explainSingleOutput("読み出すリストが選ばれていない")
	}
}

; 読みだしたリストがカラなら、 0 を返す。正常なら 1 を返す
tsl_stopWaListLoadLogic(listName, iniFile){

	returnValue = 1
	IniRead, OutTitle, %iniFile%, %listName%, titleStopWaKey , %A_Space%

	IniRead, Out1, %iniFile%, %listName%, stopWaTimeKey1 , error
	IniRead, Out2, %iniFile%, %listName%, stopWaTimeKey2 , 0
	IniRead, Out3, %iniFile%, %listName%, stopWaTimeKey3 , 0

	IniRead, Out4, %iniFile%, %listName%, alarmStopWaKey , 1
	IniRead, Out5, %iniFile%, %listName%, expressionStopWaKey , %A_Space%
	IniRead, Out6, %iniFile%, %listName%, appFlagStopWaKey , 0
	IniRead, Out7, %iniFile%, %listName%, appNameStopWaKey , %A_Space%
	IniRead, Out8, %iniFile%, %listName%, appArgsStopWaKey , %A_Space%
	IniRead, Out9, %iniFile%, %listName%, appWorkDirStopWaKey , %A_Space%

	if(Out1 == "error"){
		Out1 = 0
		returnValue = 0
	}

	guf_setControl( OutTitle, "Edit32_1", 32 )

	guf_setControl( Out1, "UpDown21_1", 21 )
	guf_setControl( Out2, "UpDown21_2", 21 )
	guf_setControl( Out3, "UpDown21_3", 21 )

	outstime_setRadioControl(Out4, "Radio25_1", "Radio25_2", "Radio25_3", "Radio25_4", 25)
	guf_setControl( Out5, "Edit25_1", 25 )
	guf_setControl( Out6, "Checkbox26_1", 26 )
	guf_setControl( Out7, "Edit26_1", 26 )
	guf_setControl( Out8, "Edit26_2", 26 )
	guf_setControl( Out9, "Edit26_3", 26 )
	return returnValue
}
