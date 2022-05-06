; 必須 guf
; アイテムの登録を使うソフトに共通で使える

itef_iniFileObjSetting(softNamessFile, softIniFile, softObj){
	Loop, Read, %softNamessFile%
	{
		IniRead, arg1, %softIniFile%, %A_LoopReadLine%, pathUrl,    -1
		if(arg1 != -1) {
			IniRead, arg2, %softIniFile%, %A_LoopReadLine%, argss
			IniRead, arg3, %softIniFile%, %A_LoopReadLine%, workingdir
			itef_softObjInsert(arg1, arg2, arg3, A_LoopReadLine, softObj)
		}
	}
}

itef_iniFileSaveSoft(arg1, arg2, arg3, itemName, softIniFile){

	arg2 := itef_dbQuouteLsDowble(arg2)

	IniWrite, %arg1%, %softIniFile%, %itemName%, pathUrl
	IniWrite, %arg2%, %softIniFile%, %itemName%, argss
	IniWrite, %arg3%, %softIniFile%, %itemName%, workingdir
}

; ini ファイルの設定上、"" が両端にあったら読み込み時に削除されるので""を２重につける
itef_dbQuouteLsDowble(arg){
	StringLeft, lChr, arg, 1
	if(lChr == """"){
		StringRight, rChr, arg, 1
		if(lChr == """"){
			arg := """" . arg  . """"
		}
	}
	Return  arg
}

itef_softObjInsert(arg1, arg2, arg3, itemName, softObj){
	optionObj := Object()
	optionObj.Insert(1, arg1)
	optionObj.Insert(2, arg2)
	optionObj.Insert(3, arg3)
	softObj.Insert(itemName, optionObj)
}


itef_entryItemLogic(arg1, arg2, arg3, itemName, softObj, softNamessFile, softIniFile){
	itef_softObjInsert(arg1, arg2, arg3, itemName, softObj)

	itef_iniFileSaveSoft(arg1, arg2, arg3, itemName, softIniFile)

	itemName_n := itemName . "`n"
	FileAppend, %itemName_n%, %softNamessFile%
	res := gutimf_checkErrorLevelExplain(A_LineFile, A_LineNumber, "アイテムの登録時にエラーがあります。`n" . itemName)
	if(res){
		TrayTip, ソフトの登録, %itemName% を登録, 5
	}
}


itef_deleteItemLogic(itemName, softNamessFile, softIniFile, softObj){
	itemName := Trim(itemName)
	if(itemName == ""){
		return
	}
	if( IsObject(softObj[itemName]) ){
		IniDelete, %softIniFile%, %itemName%
		softNamess := itef_trimWordfileRead(itemName, softNamessFile)
		FileDelete, %softNamessFile%
		FileAppend, %softNamess%, %softNamessFile%
		softObj.Remove(itemName)
		res := gutimf_checkErrorLevelExplain(A_LineFile, A_LineNumber, "アイテムの削除の時にエラーがあります。`n" . itemName)
		if(res){
			TrayTip, ソフトの削除, %itemName% を削除, 5
		}
	} else {
		gutimf_explainSingleOutput("登録アイテムが見つかりません。")
	}
}


; メッセージボックスで確認してから削除
itef_deleteConfilm(itemName, softNamessFile, softIniFile, softObj){
	itemName := Trim(itemName)
	if(itemName == ""){
		gutimf_explainSingleOutput("登録アイテムが見つかりません。")
		return
	}
	MsgBox, 4097, ソフトの削除, %itemName% を削除します。`nよろしいですか?, 60
	IfMsgBox, OK
	{
		itef_deleteItemLogic(itemName, softNamessFile, softIniFile, softObj)
	}
}

 ; ファイルから 指定した文字と一致している行以外 全て読み込む
itef_trimWordfileRead(str, file) {
	IfExist, %file%
	{
		buff =
		Loop, Read, %file%
		{
			if(str != A_LoopReadLine) {
				buff .= A_LoopReadLine  . "`n"
			}
		}
	} else {
		gutimf_checkErrorLevelExplain(A_LineFile, A_LineNumber, "読み込むファイルが見つからず")
	}
	return  buff
}


itef_entryItemButton(Edit1, Edit2, Edit3, itemName, softObj, softNamessFile, softIniFile){
	Edit1 := Trim(Edit1)
	Edit2 := Trim(Edit2)
	Edit3 := Trim(Edit3)
	itemName := Trim(itemName)

	if(itemName == ""){
		Return
	}

	if( IsObject(softObj[itemName]) ){
		gutimf_explainSingleOutput("その名前はすでに使用されています。`n" . itemName)
		return
	}

	res := RegExMatch(itemName, "^[0-9a-zA-Z_@-]+$")
	if(res != 1) {
		gutimf_explainSingleOutput("無効な文字が入ってます。`n" . itemName)
		return
	}

	if(Edit1 == ""){
		gutimf_explainSingleOutput("ソフトのパスがカラなので登録できない。")
		return
	}

	itef_entryItemLogic(Edit1, Edit2, Edit3, itemName, softObj, softNamessFile, softIniFile)
}


itef_entrySoftInputBox(Edit1, Edit2, Edit3, softObj, softNamessFile, softIniFile){
	str := itef_splitFileOrFolderName(Edit1)
	InputBox, OutputVar , ソフトの新規登録, ソフト名を入れてください。, ,280 ,130 , , , , 180, %str%
	if(ErrorLevel == 0){
		if(OutputVar != ""){
			itef_entryItemButton(Edit1, Edit2, Edit3, OutputVar, softObj, softNamessFile, softIniFile)
		}
	}
}

; ファイル名を返す。フォルダ名か、存在しないなら空を返す
itef_splitFileOrFolderName(str){
	returnValue =
	type := FileExist(str)
	if(type == ""){
		
	} else {
		SplitPath, str , , OutDir, , OutNameNoExt
		IfInString, type , D
		{

		} else {
			returnValue := OutNameNoExt
		}
	}
	return  returnValue
}

itef_softObjToPipeStr(softObj){
	buff =
	for key, value in  softObj {
		if(key != ""){
			buff .= "|" . key
		}
	}
	buff := RTrim(buff, "|")
	return  buff
}
