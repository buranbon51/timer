





gutimf_anyOfNumFromDpi(lessThan110, lessThan140, moreThan140){
	if(tglo_dpiNum <= 110){
		return lessThan110
	} else if(tglo_dpiNum <= 140){
		return lessThan140
	} else if(tglo_dpiNum >= 140){
		return moreThan140
	}
	return lessThan110
}

gutimf_setInputKeyAlarmStop(){
	shortKeyStr := guf_getControl( "Hotkey24_1", 24 )
	guf_setControl( shortKeyStr, "Edit24_3", 24 )
}

gutimf_showSoftWindowTimer(order="_"){
	flag := guf_getControl( "Checkbox23_1", 23 )
	guf_switchEnableByFlag(flag, "Edit23_1", 23)
	guf_switchEnableByFlag(flag, "Edit23_2", 23)
	guf_switchEnableByFlag(flag, "Edit23_3", 23)
	; アイテムの更新
	itet_setCombBoxSoftObj()

	Sleep, 200
	guf_showGuiAssign(23, order)
}

gutimf_showSoftWindowAssignBySec(order="_"){
	flag := guf_getControl( "Checkbox26_1", 26 )
	guf_switchEnableByFlag(flag, "Edit26_1", 26)
	guf_switchEnableByFlag(flag, "Edit26_2", 26)
	guf_switchEnableByFlag(flag, "Edit26_3", 26)
	; アイテムの更新
	itet_setCombBoxSoftObj()

	Sleep, 200
	guf_showGuiAssign(26, order)
}

gutimf_switchTimerWindow(dateTimeFlag){
	WinGetActiveStats, Title, Width, Height, posX, posY
	if( dateTimeFlag ){
		tglo_mainIsNumeralWindowFlag := True
		Gui, 20:Hide
		WinWaitActive , A, , 1
		Gui, 21:Show, x%posX% y%posY%
	} else {
		tglo_mainIsNumeralWindowFlag := False
		Gui, 21:Hide
		WinWaitActive , A, , 1
		Gui, 20:Show, x%posX% y%posY%
	}
}

gutimf_hideGuiAppendExplain(){

	Gui, 33:Hide
}

;  追加するのではなく、単独表示
gutimf_explainSingleOutput(before, after="@", str3="@", str4="@", str5="@") {
	if(after == "@") {
		GuiControl,33: , EditBox33_1, %before%`n
	} else if (str3 == "@") {
		GuiControl,33: , EditBox33_1, %before%`n%after%`n
	} else if (str4 == "@") {
		GuiControl,33: , EditBox33_1, %before%`n%after%`n%str3%`n
	} else if (str5 == "@") {
		GuiControl,33: , EditBox33_1, %before%`n%after%`n%str3%`n%str4%`n
	} else {
		GuiControl,33: , EditBox33_1, %before%`n%after%`n%str3%`n%str4%`n%str5%`n
	}
	Gui, 33:Show, NA
	ControlSend , , ^{End}, ahk_id  %glotimer_hwndEditBox33_1%
}

;  エラー表示用に改良  
gutimf_appendErrorExplain(append="", str2="@", str3="@", str4="@") {
	GuiControlGet, EditBox33_1, 33:
	if(append == "@") {
		;GuiControl,33: , EditBox33_1, %EditBox33_1%`n
	} else if (str2 == "@") {
		GuiControl,33: , EditBox33_1, %EditBox33_1%%append%`n
	} else if (str3 == "@") {
		GuiControl,33: , EditBox33_1, %EditBox33_1%%append%`n%str2%`n
	} else if (str4 == "@") {
		GuiControl,33: , EditBox33_1, %EditBox33_1%%append%`n%str2%`n%str3%`n
	} else {
		GuiControl,33: , EditBox33_1, %EditBox33_1%%append%`n%str2%`n%str3%`n%str4%`n
	}
	Gui, 33:Show, NA
	DetectHiddenWindows, On
	ControlSend , , ^{End}, ahk_id %glotimer_hwndEditBox33_1%
	DetectHiddenWindows, Off
	;ControlSend , , {Home}, ahk_id  %glotimer_hwndEditBox33_1%
}

;  エラーレベルがあるならFalseを  なければTrueに
gutimf_checkErrorLevelExplain(append="", str2="@", str3="@", str4="@") {
	if(ErrorLevel >= 1){
		gutimf_appendErrorExplain("ErrorLevel   " . ErrorLevel, append, str2, str3)
		return False
	}
	return True
}

;  単独表示
gutimf_checkErrorLevelExplainSingleOutput(append="", str2="@", str3="@", str4="@") {
	if(ErrorLevel >= 1){
		gutimf_explainSingleOutput("ErrorLevel   " . ErrorLevel, append, str2, str3)
		return False
	}
	return True
}

gutimf_dropFileLogicMain(dateTimeFlag){
	StringSplit, filess, A_GuiEvent,`n
	if(dateTimeFlag){
		guf_setControl( filess1, "Edit23_1", 23 )
		guf_setControl( "", "Edit23_2", 23 )
		IfExist,  %filess1%
		{
			SplitPath, filess1 , , OutDir
			guf_setControl( OutDir, "Edit23_3", 23 )
		} else {
			guf_setControl( "", "Edit23_3", 23 )
		}
		guf_setControl( 1, "Checkbox23_1", 23 )
		guf_switchEnableByFlag(1, "Edit23_1", 23)
		guf_switchEnableByFlag(1, "Edit23_2", 23)
		guf_switchEnableByFlag(1, "Edit23_3", 23)
		guf_showGuiAssign(23)
	} else {
		guf_setControl( filess1, "Edit26_1", 26 )
		guf_setControl( "", "Edit26_2", 26 )
		IfExist,  %filess1%
		{
			SplitPath, filess1 , , OutDir
			guf_setControl( OutDir, "Edit26_3", 26 )
		} else {
			guf_setControl( "", "Edit26_3", 26 )
		}
		guf_setControl( 1, "Checkbox26_1", 26 )
		guf_switchEnableByFlag(1, "Edit26_1", 26)
		guf_switchEnableByFlag(1, "Edit26_2", 26)
		guf_switchEnableByFlag(1, "Edit26_3", 26)
		guf_showGuiAssign(26)
	}
}
