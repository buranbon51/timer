




hotttif_wordReplaceAndLower(keyName, SearchText, ReplaceText){
	StringLower, tmpKeyName, keyName
	IfInString, tmpKeyName, %SearchText%
	{
		StringReplace, keyName, tmpKeyName, %SearchText% , %ReplaceText%
	}
	return keyName
}

; + を shift+ に変える場合、Ctrl+A などロングネームがある場合、無駄に置換されてしまう。
; Ctrl+やAlt+などの文字を１度削除してから、+ を Shift+ に置換する。
; さらにこの関数は Win+Ctrl+Alt+Shift+ の順番に並び替える役割も担っている。
; あと、hotttif_wordReplaceAndLower() で ^ ! # を置換した後でこの関数を使わないと、順番の並び替えができない。
hotttif_shiftShortNameToLongName(keyName){
	; + がなかったら、何にもせずに終わる。 ^ や ! や # があった場合、すでに + があるはず。
	IfNotInString, keyName, +
	{
		return keyName
	}

	StringLower, keyName, keyName
	buff =
	IfInString, keyName, win+
	{
		StringReplace, keyName, keyName, win+
		buff .= "Win+"
	}
	IfInString, keyName, ctrl+
	{
		StringReplace, keyName, keyName, ctrl+
		buff .= "Ctrl+"
	}
	IfInString, keyName, alt+
	{
		StringReplace, keyName, keyName, alt+
		buff .= "Alt+"
	}
	IfInString, keyName, shift+
	{
		StringReplace, keyName, keyName, shift+
		buff .= "Shift+"
	}
	IfInString, keyName, +
	{
		StringReplace, keyName, keyName, + , Shift+
	}
	keyName := buff . keyName
	return keyName
}

; キーのショートネームをロングネームに変える
; さらにこの関数は Win+Ctrl+Alt+Shift+ の順番に並び替える役割も担っている。
hotttif_shortKeyNameToLongName(keyName){
	; キーのショートネームをロングネームに変える
	longKeyName := hotttif_wordReplaceAndLower(keyName, "^", "ctrl+")
	longKeyName := hotttif_wordReplaceAndLower(longKeyName, "!", "alt+")
	longKeyName := hotttif_wordReplaceAndLower(longKeyName, "#", "win+")
	; + を shift+ に変える場合、Ctrl+A などロングネームがある場合、無駄に置換されてしまう。
	; Ctrl+やAlt+などの文字を１度削除してから、+ を shift+ に置換する。
	; さらにこの関数は Win+Ctrl+Alt+Shift+ の順番に並び替える役割も担っている。
	longKeyName := hotttif_shiftShortNameToLongName(longKeyName)

	; 右端が + だった場合にエラーになるようにした
	StringRight, rChr, longKeyName, 1
	if(rChr == "+"){
		str := "エラー  " . keyName
		return str
	}
	return longKeyName
}

hotttif_errorMsgForHotkey(errlevel, keyName, str){
	errorStr =
	if(errlevel == 1){
		errorStr := str . "するホットキーの登録でエラー。`n指定のサブルーチンが存在しない。`nホットキー  " . keyName
	} else if(errlevel == 2){
		errorStr := str . "するホットキーの登録でエラー。`n指定したキーは登録できない。`nホットキー  " . keyName
	} else {
		errorStr := str . "するホットキーの登録でエラー。`nホットキー  " . keyName
	}
	return errorStr
}

hotttif_entrySoundCloseKey(){
	if( tglo_iniSetNoticeCloseKeyName == "" ){
		return
	}
	Hotkey, %tglo_iniSetNoticeCloseKeyName% , SubSoundCloseOnlyTimer, UseErrorLevel
	errorStr := hotttif_errorMsgForHotkey(ErrorLevel, tglo_iniSetNoticeCloseKeyName, "アラームを停止")
	gutimf_checkErrorLevelExplain(errorStr)
}
