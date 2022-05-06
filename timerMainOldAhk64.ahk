
#SingleInstance FORCE	;終了してから再起動

#KeyHistory 0

; 後で設定
;DetectHiddenWindows, Off
DetectHiddenText, Off

CoordMode, ToolTip, Screen
SetDefaultMouseSpeed, 1

ListLines, Off			;スクリプトの実行履歴


SetWorkingDir, %A_ScriptDir%

global timema_bitVar := "64ビット"
global timema_sign := ""

#Include %A_ScriptDir%\src\timerIniSetting.ahk

#Include %A_ScriptDir%\src\timerGlobal.ahk

#Include %A_ScriptDir%\src\beforehandInitTimer.ahk

#Include %A_ScriptDir%\src\userPlus\startup\beforeGuiMakeStartup.ahk

;#Include %A_ScriptDir%\src\newAhk_Gui\timerGui.ahk
#Include %A_ScriptDir%\src\oldAhk_Gui\timerGui.ahk

gutimf_checkErrorLevelExplain("起動時にエラーがあります。")

#Include %A_ScriptDir%\src\userPlus\startup\afterGuiMakeStartup.ahk

gutimf_checkErrorLevelExplain("起動時にエラーがあります。")


DetectHiddenWindows, Off


;global trrma_bitVar := "64ビット"
;global trrma_sign := ""
;#Include %A_ScriptDir%\trrEvery\src\var2\oldAhk_Gui\startTrrVar2\startUpExecute.ahk


#Include %A_ScriptDir%\src\argUseTimerStartup.ahk

cetimer_showStartUseWindow()

return


;#Include %A_ScriptDir%\trrEvery\src\var2\oldAhk_Gui\startTrrVar2\subroutineAndFunction.ahk



#Include %A_ScriptDir%\src\timerGuiSubLutin.ahk

#Include %A_ScriptDir%\src\timerSubLutin.ahk

#Include %A_ScriptDir%\src\easyToUse\easyToUseTimerSubroutine.ahk



#Include %A_ScriptDir%\src\commonSrc\functionCommon.ahk

#Include %A_ScriptDir%\src\commonSrc\guiCommonFunction.ahk

#Include %A_ScriptDir%\src\commonSrc\otherLibFunc.ahk

#Include %A_ScriptDir%\src\commonSrc\windowCommonFunc.ahk


#Include %A_ScriptDir%\src\guiThisTimerFunc.ahk

;#Include %A_ScriptDir%\src\newAhk_Gui\guiTimerInitFunc.ahk
#Include %A_ScriptDir%\src\oldAhk_Gui\guiTimerInitFunc.ahk

#Include %A_ScriptDir%\src\timerFunc.ahk

#Include %A_ScriptDir%\src\outSideTimerFunc.ahk

#Include %A_ScriptDir%\src\itemCommonFunc.ahk

#Include %A_ScriptDir%\src\itemTimerFunc.ahk

#Include %A_ScriptDir%\src\configTimer.ahk

#Include %A_ScriptDir%\src\timerStockList.ahk

#Include %A_ScriptDir%\src\centreNearTimerFunc.ahk

#Include %A_ScriptDir%\src\hotKeyThisTimerFunc.ahk

#Include %A_ScriptDir%\src\superfluityTimerFunc.ahk

#Include %A_ScriptDir%\src\argUseTimerFunc.ahk

#Include %A_ScriptDir%\src\userPlus\startButtonSetting.ahk

#Include %A_ScriptDir%\src\userPlus\anyScriptExecute.ahk

#Include %A_ScriptDir%\src\userPlus\actionOfChangeListBox.ahk

#Include %A_ScriptDir%\src\easyToUse\easyToUseTimerFunc.ahk
