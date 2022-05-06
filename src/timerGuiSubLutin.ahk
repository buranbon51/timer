




20GuiClose:
	if( tglo_iniSetExitIfWinCloseNotFlag ){
		Gui, 20:Minimize
		return
	}
	cetimer_exitAppsConfirmEnyExecution()

	;ボタンを押さないと閉じないようにする
	;Gui, 20:Minimize
	return

20GuiDropFiles:
	gutimf_dropFileLogicMain(True)
	return

21GuiClose:
	if( tglo_iniSetExitIfWinCloseNotFlag ){
		Gui, 21:Minimize
		return
	}
	cetimer_exitAppsConfirmEnyExecution()

	;ボタンを押さないと閉じないようにする
	;Gui, 21:Minimize
	return

21GuiDropFiles:
	gutimf_dropFileLogicMain(False)
	return


23GuiDropFiles:
	gutimf_dropFileLogicMain(True)
	return

26GuiDropFiles:
	gutimf_dropFileLogicMain(False)
	return

27GuiDropFiles:
	StringSplit, filess, A_GuiEvent,`n
	guf_setControl( filess1, "Edit27_3", 27 )
	return

28GuiClose:
	; タイマーを実行した後に終了する設定の場合
	cetimer_exitAppsIfNotHaveExecution()

	;音を鳴らすタイマーを停止して、閉じる
	time_soundClose()
	Gui, 28:Hide
	return

29GuiClose:
	;音を鳴らすタイマーを停止して、閉じる
	time_soundTestPlayClose()
	Gui, 29:Hide
	return


33GuiClose:
	gutimf_hideGuiAppendExplain()
	return

33GuiSize:
	width := A_GuiWidth - 20
	height := A_GuiHeight -50
	changeY1 := height + 15
	GuiControl, 33:Move, EditBox33_1, w%width%  h%height%
	GuiControl, 33:Move, Button33_1,  y%changeY1%
	return





; Escで閉じない
20GuiEscape:
	Gui, 20:Minimize
return

; Escで閉じない
21GuiEscape:
	Gui, 21:Minimize
return

22GuiEscape:
	Gui, 22:Hide
return

23GuiEscape:
	Gui, 23:Hide
return

24GuiEscape:
	Gui, 24:Hide
return

25GuiEscape:
	Gui, 25:Hide
return

26GuiEscape:
	Gui, 26:Hide
return

27GuiEscape:
	Gui, 27:Hide
return

28GuiEscape:
	; Escで閉じない
return

29GuiEscape:
	; Escで閉じない
return

31GuiEscape:
	Gui, 31:Hide
return

32GuiEscape:
	Gui, 32:Hide
return

33GuiEscape:
	gutimf_hideGuiAppendExplain()
return

34GuiEscape:
	Gui, 34:Hide
return



SubButton20_1_1:
	Gui, 20:Submit, NoHide
;	WinMinimize , A
	time_timerExecute(DateTime20_1, List20_1)
	
	return

SubButton20_1_2:
	Gui, 20:Submit, NoHide
;	WinMinimize , A
	time_stopLogic(List20_1)
	return

SubButton20_1_3:
	gutimf_showSoftWindowTimer("_")
	return

SubButton20_1_4:
	Gui, 22:Show
	return

SubButton20_1_5:
	cetimer_exitAppsConfirmEnyExecution()
	return

SubButton20_7:
	gutimf_switchTimerWindow(True)
	return

SubList20_1:
	time_changeListTimer()
	return




SubButton21_2_1:
	Gui, 21:Submit, NoHide
;	WinMinimize , A
	time_stopWatch(UpDown21_1, UpDown21_2, UpDown21_3, List21_2)
	return

SubButton21_2_2:
	Gui, 21:Submit, NoHide
;	WinMinimize , A
	time_stopStopWatchLogic(List21_2)
	return

SubButton21_2_3:
	gutimf_showSoftWindowAssignBySec("_")
	return

SubButton21_2_4:
	Gui, 25:Show
	return

SubButton21_2_5:
	cetimer_exitAppsConfirmEnyExecution()
	return

SubButton21_2_6:
	Gui, 21:Submit, NoHide
;	WinMinimize , A
	time_reStartStopWa(List21_2)
	return

SubButton21_7:
	gutimf_switchTimerWindow(False)
	return

SubList21_2:
	time_changeListStopWatch()
	return




SubButton22_1_3:
	Gui, 31:Show
	return

SubButton22_1_4:
	Gui, 22:Hide
	return

; ２箇所で使用する
SubButton22_1_5:
	cont_optionGuiShow("_")
	return

; ２箇所で使用する
SubButton22_1_6:
	;cetimer_whichMainUseHide()
	Gui, 22:Hide
	Gui, 25:Hide
	Gui, 20:Hide
	Gui, 21:Hide
	return



SubButton23_1:
	Gui, 23:Submit, NoHide
	outstime_fileSelectButton(Edit23_1, "Edit23_1", "ファイルの選択", A_MyDocuments, 23)
	return

SubButton23_2:
	Gui, 23:Hide
	return

SubButton23_3:
	Gui, 23:Submit, NoHide
	outstime_fileCheckAndMakeFolder(glotimer_softIniFile, glotimer_entrySoftDir)
	itef_entrySoftInputBox(Edit23_1, Edit23_2, Edit23_3, glotimer_softObj, glotimer_softNamessFile, glotimer_softIniFile)
	itet_setCombBoxSoftObj()
	return

SubButton23_4:
	Gui, 23:Submit, NoHide
	itef_deleteConfilm(ComboBox23_1, glotimer_softNamessFile, glotimer_softIniFile, glotimer_softObj)
	itet_setCombBoxSoftObj()
	return

SubEdit23_1:
	time_autoSetEdit23_1()
	return

SubComboBox23_1:
	itet_combBoxToEditss("ComboBox23_1", "Edit23_1", "Edit23_2", "Edit23_3", 23 )
	return

SubCheckbox23_1:
	Gui, 23:Submit, NoHide
	guf_switchEnableByFlag(Checkbox23_1, "Edit23_1", 23)
	guf_switchEnableByFlag(Checkbox23_1, "Edit23_2", 23)
	guf_switchEnableByFlag(Checkbox23_1, "Edit23_3", 23)
	return



SubButton24_1:
	cont_alarmPatternGuiShow(1)
	return

SubButton24_2:
	cont_alarmPatternGuiShow(2)
	return

SubButton24_3:
	cont_alarmPatternGuiShow(3)
	return

SubButton24_4:
	cont_alarmPatternGuiShow(4)
	return

SubHotkey24_1:
	gutimf_setInputKeyAlarmStop()
	return

24ButtonOK(O):
	cont_optionSubmit()
	Gui, 24:Hide
	return

24ButtonCancel(C):
	Gui, 24:Hide
	return




SubButton25_1_3:
	Gui, 32:Show
	return

SubButton25_1_4:
	Gui, 25:Hide
	return



SubButton26_1:
	Gui, 26:Submit, NoHide
	outstime_fileSelectButton(Edit26_1, "Edit26_1", "ファイルの選択", A_MyDocuments, 26)
	return

SubButton26_2:
	Gui, 26:Hide
	return

SubButton26_3:
	Gui, 26:Submit, NoHide
	outstime_fileCheckAndMakeFolder(glotimer_softIniFile, glotimer_entrySoftDir)
	itef_entrySoftInputBox(Edit26_1, Edit26_2, Edit26_3, glotimer_softObj, glotimer_softNamessFile, glotimer_softIniFile)
	itet_setCombBoxSoftObj()
	return

SubButton26_4:
	Gui, 26:Submit, NoHide
	itef_deleteConfilm(ComboBox26_1, glotimer_softNamessFile, glotimer_softIniFile, glotimer_softObj)
	itet_setCombBoxSoftObj()
	return

SubEdit26_1:
	time_autoSetEdit26_1()
	return

SubComboBox26_1:
	itet_combBoxToEditss("ComboBox26_1", "Edit26_1", "Edit26_2", "Edit26_3", 26 )
	return

SubCheckbox26_1:
	Gui, 26:Submit, NoHide
	guf_switchEnableByFlag(Checkbox26_1, "Edit26_1", 26)
	guf_switchEnableByFlag(Checkbox26_1, "Edit26_2", 26)
	guf_switchEnableByFlag(Checkbox26_1, "Edit26_3", 26)
	return


SubButton27_1:
	Gui, 27:Submit
	cont_alarmOptionSubmit(UpDown27_2, Edit27_3, UpDown27_4, HiddenEdit27_1)
	return

SubButton27_2:
	Gui, 27:Hide
	return

SubButton27_3:
	Gui, 27:Submit, NoHide
	cont_alarmConfigDefaultButton(HiddenEdit27_1, "Edit27_3", 27)
	return

SubButton27_4:
	Gui, 27:Submit, NoHide
	outstime_fileSelectButton(Edit27_3, "Edit27_3", "音楽ファイルの選択", A_MyDocuments, 27)
	return

SubButton27_5:
	Gui, 27:Submit, NoHide
	time_alarmTestPlay(UpDown27_2, Edit27_3, UpDown27_4, HiddenEdit27_1)
	return

SubButton28_1:
	; タイマーを実行した後に終了する設定の場合
	cetimer_exitAppsIfNotHaveExecution()

	;音を鳴らすタイマーを停止して、閉じる
	time_soundClose()
	Gui, 28:Hide
	return

SubButton28_2:
	time_soundStop()
	return

SubButton29_1:
	;音を鳴らすタイマーを停止して、閉じる
	time_soundTestPlayClose()
	Gui, 29:Hide
	return

SubButton29_2:
	time_soundTestPlayStop()
	return


SubButton31_1:
	Gui, 31:Submit, NoHide
	tsl_timerListLoad(List31_1)
	return

SubButton31_2:
	Gui, 31:Submit, NoHide
	tsl_timerListSave(List31_1, Edit31_1)
	return

SubButton31_3:
	Gui, 31:Hide
	return

SubButton32_1:
	Gui, 32:Submit, NoHide
	tsl_stopWaListLoad(List32_1)
	return

SubButton32_2:
	Gui, 32:Submit, NoHide
	tsl_stopWaListSave(List32_1, Edit32_1)
	return

SubButton32_3:
	Gui, 32:Hide
	return

SubButton33_1:
	gutimf_hideGuiAppendExplain()
	return
