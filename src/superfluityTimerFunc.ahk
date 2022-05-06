



sufltif_setItemLogicTime(itemName){
	optionObj := glotimer_softObj[itemName]
	if( IsObject(optionObj) ){
		guf_setControl( True, "Checkbox23_1", 23 )
		guf_GuiControl("ComboBox23_1", 23, "Choose", itemName)
		guf_setControl( optionObj[1], "Edit23_1", 23 )
		guf_setControl( optionObj[2], "Edit23_2", 23 )
		guf_setControl( optionObj[3], "Edit23_3", 23 )
		return True
	}
	return False
}

sufltif_setItemLogicNumeral(itemName){
	optionObj := glotimer_softObj[itemName]
	if( IsObject(optionObj) ){
		guf_setControl( True, "Checkbox26_1", 26 )
		guf_GuiControl("ComboBox26_1", 26, "Choose", itemName)
		guf_setControl( optionObj[1], "Edit26_1", 26 )
		guf_setControl( optionObj[2], "Edit26_2", 26 )
		guf_setControl( optionObj[3], "Edit26_3", 26 )
		return True
	}
	return False
}

; 6 桁にして返す。 time_checkErrorFormatDateTimeUseText() の後に使う事が前提
sufltif_formatDateTimeUseText(str){
	If str is not integer
	{
		return "error"
	}

	StringLen, length, str
	if(length == 2){
		str .= 0000
	} else if(length == 4){
		str .= 00
	} else if(length == 6){

	} else {
		return "error"
	}
	return str
}

; 23:59:59 などの書式なら、６桁の数字にして返す。
; 書式が違うなら、元の文字列を返す
sufltif_colonFormatDateTime6Char(str){
	IfNotInString, str, :
	{
		return str
	}
	hour =
	min =
	sec =
	sentence = %str%
	pmFlag := False

	StringLeft, leftStr, sentence, 2
	; 午後か午前の文字が先頭にあったら
	if( leftStr == "午前" ){
		StringTrimLeft, sentence, sentence, 2
		StringLeft, leftStr, sentence, 2
	} else if( leftStr == "午後" ){
		StringTrimLeft, sentence, sentence, 2
		StringLeft, leftStr, sentence, 2
		pmFlag := True
	}

	; 時間が１桁なら
	StringRight, rChr, leftStr, 1
	if( rChr == ":" ){
		StringTrimRight, leftStr2, leftStr, 1
		If leftStr2 is not integer
		{
			return str
		}
		hour = %leftStr2%
		if( pmFlag ){
			hour += 12
		} else {
			hour := "0" . leftStr2
		}

		StringTrimLeft, sentence, sentence, 2
	} else {
		StringLeft, leftStr, sentence, 3
		StringRight, rChr, leftStr, 1
		if( rChr != ":" ){
			; ３文字目が : でないなら違う
			return str
		} 
		StringTrimRight, hour, leftStr, 1
		If hour is not integer
		{
			return str
		}
		if( pmFlag ){
			hour += 12
		}
		if( hour >= 24 ){
			return str
		}
		StringTrimLeft, sentence, sentence, 3
	}

	StringLen, strLen, sentence
	if( strLen == 1 ){
		If sentence is not integer
		{
			return str
		}
		min := "0" . sentence
		returnValue := hour . min . "00"
		return returnValue
	} else if( strLen == 2 ){
		If sentence is not integer
		{
			return str
		}
		min := sentence
		if( min >= 60 ){
			return str
		}
		returnValue := hour . min . "00"
		return returnValue
	}


	StringLeft, leftStr, sentence, 2
	StringRight, rChr, leftStr, 1
	if( rChr == ":" ){
		StringTrimRight, leftStr2, leftStr, 1
		If leftStr2 is not integer
		{
			return str
		}
		min := "0" . leftStr2
		StringTrimLeft, sentence, sentence, 2
	} else {
		StringLeft, leftStr, sentence, 3
		StringRight, rChr, leftStr, 1
		if( rChr != ":" ){
			; ３文字目が : でないなら違う
			return str
		} 
		StringTrimRight, min, leftStr, 1
		If min is not integer
		{
			return str
		}
		if( min >= 60 ){
			return str
		}
		StringTrimLeft, sentence, sentence, 3
	}

	StringLen, strLen, sentence
	if( strLen == 1 ){
		If sentence is not integer
		{
			return str
		}
		sec := "0" . sentence
		returnValue := hour . min . sec
		return returnValue
	} else if( strLen == 2 ){
		If sentence is not integer
		{
			return str
		}
		sec := sentence
		if( sec >= 60 ){
			return str
		}
		returnValue := hour . min . sec
		return returnValue
	}
	; sentence が 2文字でないなら、違う
	return str
}

; 23:59:59 などの書式なら、23h 59m 59s の文字列に変換して返す。
; 書式が違うなら、元の文字列を返す
sufltif_colonFormatHMSSentence(str){
	IfNotInString, str, :
	{
		return str
	}
	hour =
	min =
	sec =
	sentence = %str%

	; 時間が１桁なら
	StringLeft, leftStr, sentence, 2
	StringRight, rChr, leftStr, 1
	if( rChr == ":" ){
		StringTrimRight, leftStr2, leftStr, 1
		If leftStr2 is not integer
		{
			return str
		}
		hour := leftStr2
		StringTrimLeft, sentence, sentence, 2
	} else {
		StringLeft, leftStr, sentence, 3
		StringRight, rChr, leftStr, 1
		if( rChr != ":" ){
			; ３文字目が : でないなら違う
			return str
		} 
		StringTrimRight, hour, leftStr, 1
		If hour is not integer
		{
			return str
		}
		if( hour >= 24 ){
			return str
		}
		StringTrimLeft, sentence, sentence, 3
	}

	StringLen, strLen, sentence
	if( strLen == 1 ){
		If sentence is not integer
		{
			return str
		}
		min := sentence
		returnValue := hour . "h " . min . "m"
		return returnValue
	} else if( strLen == 2 ){
		If sentence is not integer
		{
			return str
		}
		min := sentence
		if( min >= 60 ){
			return str
		}
		returnValue := hour . "h " . min . "m"
		return returnValue
	}

	StringLeft, leftStr, sentence, 2
	StringRight, rChr, leftStr, 1
	if( rChr == ":" ){
		StringTrimRight, leftStr2, leftStr, 1
		If leftStr2 is not integer
		{
			return str
		}
		min := leftStr2
		StringTrimLeft, sentence, sentence, 2
	} else {
		StringLeft, leftStr, sentence, 3
		StringRight, rChr, leftStr, 1
		if( rChr != ":" ){
			; ３文字目が : でないなら違う
			return str
		} 
		StringTrimRight, min, leftStr, 1
		If min is not integer
		{
			return str
		}
		if( min >= 60 ){
			return str
		}
		StringTrimLeft, sentence, sentence, 3
	}

	StringLen, strLen, sentence
	if( strLen == 1 ){
		If sentence is not integer
		{
			return str
		}
		sec := sentence
		returnValue := hour . "h " . min . "m " . sec . "s"
		return returnValue
	} else if( strLen == 2 ){
		If sentence is not integer
		{
			return str
		}
		sec := sentence
		if( sec >= 60 ){
			return str
		}
		returnValue := hour . "h " . min . "m " . sec . "s"
		return returnValue
	}
	; sentence が 2文字でないなら、違う
	return str
}
