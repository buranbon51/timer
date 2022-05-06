



; 今選択中のリストを更新する
; 時刻
Timer_Text_SubListReLoadForTime:
	time_changeListTimer()
	return

; 今からの時間
Timer_Text_SubListReLoadForNumeral:
	time_changeListStopWatch()
	return


; メインのウインドウを表示
Timer_Text_SubShowTimeOrNumeral:
	if( tglo_mainIsNumeralWindowFlag ){
		Gui, 21:Show
	} else {
		Gui, 20:Show
	}
	return

Timer_Text_SubShowErrorWindow:
	guf_showGuiAssign(33)
	return


; 音を止める
Timer_Text_SubStopAlarm:
	time_soundClose()
	; SoundPlay, _null_  のとき、エラーになるので対処
	ErrorLevel = 0
	return

; 音を止めて、アラームなってる時に表示するウインドウを閉じる
Timer_Text_SubStopAlarmAndCloseWindow:
	time_soundClose()
	; SoundPlay, _null_  のとき、エラーになるので対処
	ErrorLevel = 0
	Gui, 28:Hide
	return

; 音の一時停止ボタン。オン／オフ式
Timer_Text_SubSuspensionAlarmToggle:
	time_soundStop()
	; SoundPlay, _null_  のとき、エラーになるので対処
	ErrorLevel = 0
	return






