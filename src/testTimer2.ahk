


















Timer_Text_item_mojiTimerAlarm
Timer_Text_item_mojiNumeralAlarm




Gosub, E_showLastWordToggle



O_lastWordKey2_1 = 時計で
O_lastWordKey2_2 = 後に
O_lastWordKey2_3 = 時刻のアイテム
O_lastWordKey2_4 = 数字のアイテム
O_lastWordKey2_5 = 時刻を止める
O_lastWordKey2_6 = 数字を止める

O_lastWordTabAllFlag2 := True



O_lastWordScript2_1 = Timer_Text_item_mojiTimerAlarm
O_lastWordScript2_2 = Timer_Text_item_mojiNumeralAlarm
O_lastWordScript2_3 = Timer_Text_item_setTimerItemForTime
O_lastWordScript2_4 = Timer_Text_item_setTimerItemForNumeral
O_lastWordScript2_5 = Timer_Text_item_stopTime
O_lastWordScript2_6 = Timer_Text_item_stopNumeralSuspension




























time
numeral


listChange

























Numeral




AssignBySec









var1 := guf_getControl( "Tab18_1", 18 )


「表示する文字」をリストの文字に反映させる

tsl_changeTimerListTitle(){

	buff := "|"
	Loop , 20
	{
		IniRead, titleTmp, %glob_timerListIniFile%, listTitleSection, titleName%A_Index% , 時間指定%A_Index%
		titleTmp := Trim(titleTmp)
		if(titleTmp == ""){
			titleTmp := "時間指定" . A_Index
		}
		if(A_Index == 1){
			buff .= titleTmp  . "|"
		} else {
			buff .= "|" . titleTmp
		}
	}

	buff := RTrim(buff, "|")
	guf_setControl( buff, "List61_1", 61 )
}














