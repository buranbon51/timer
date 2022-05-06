
; リストが変わったときに自動で実行する処理を記述する。
; 自作したＧｕｉなどを操作する場合を想定している。
; runningFlag　が　True　なら実行中のタイマーを意味している。


; 時刻で指定の方の、時刻リストの選択が変わったときに、自動で動作する処理
useracl_actionOfChangeListBoxTime(runningFlag, listNumber){

/*
	if( runningFlag ){
		guf_setControl( globalValue%listNumber%, "controlValue", GuiNum )
	} else {
		guf_setControl( "", "controlValue", GuiNum )
	}
*/


}

; 数字指定で指定の方の、今からの時間リストの選択が変わったときに、自動で動作する処理
useracl_actionOfChangeListBoxNumeral(runningFlag, listNumber){

/*
	if( runningFlag ){
		guf_setControl( globalValue%listNumber%, "controlValue", GuiNum )
	} else {
		guf_setControl( "", "controlValue", GuiNum )
	}
*/


}
