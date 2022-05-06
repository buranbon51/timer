



; アイコンに使う画像ファイルを返り値に返す。無ければカラの文字
outstime_iconPictureEnyExtFileTimer(noExtFile){
	; noExtFile は拡張子がないファイル名
	; いろんな拡張子に対応させる
	file =

	pngFile := noExtFile . ".png"
	gifFile := noExtFile . ".gif"
	iconFile := noExtFile . ".ico"

	if( func_myFileExist(pngFile) ){
		file := pngFile
	} else if( func_myFileExist(gifFile) ){
		file := gifFile
	} else if( func_myFileExist(iconFile) ){
		file := iconFile
	}
	return file
}

; 指定した画像ファイルがあったら、バックグラウンドとして使用する。
outstime_bgPictureAddEnyExtFileTimer(noExtFile, option, GuiNum){
	; noExtFile は拡張子がないファイル名
	; いろんな拡張子に対応させる
	existFlag := False
	file =

	jpgFile := noExtFile . ".jpg"
	jpegFile := noExtFile . ".jpeg"
	pngFile := noExtFile . ".png"
	gifFile := noExtFile . ".gif"

	if( func_myFileExist(jpgFile) ){
		existFlag := True
		file := jpgFile
	} else if( func_myFileExist(jpegFile) ){
		existFlag := True
		file := jpegFile
	} else if( func_myFileExist(pngFile) ){
		existFlag := True
		file := pngFile
	} else if( func_myFileExist(gifFile) ){
		existFlag := True
		file := gifFile
	}

	if( existFlag ){
		Gui, %GuiNum%:Add, Picture, %option%, %file%
	}
}

outstime_windowSizePosSaveIniWrite(winTitle, iniFile){
	; 最大化か最小化してる場合は諦める
	if( func_isWindowMaxSize(winTitle) ){
		return
	}
	; 非表示のウインドウは DetectHiddenWindows,Off なら、最小化されていてもTrueになってしまうので
	; func_isWindowMinimizeSize(winTitle) の使用が変更になった場合は注意
	if( func_isWindowMinimizeSize(winTitle) ){
		return
	}

	; 指定のウインドウが見つからないなら、飛ばす。現時点では意味はないが、
	; func_isWindowMinimizeSize(winTitle) の使用が変更になった場合にそなえて。
/*
	if( func_ifWinExist(winTitle) == False ){
		return
	}
*/

	WinGetPos, X, Y, Width, Height, %winTitle%
	IniWrite, %X%, %iniFile%, %winTitle%, guiX
	IniWrite, %Y%, %iniFile%, %winTitle%, guiY
	IniWrite, %Width%, %iniFile%, %winTitle%, guiWidth
	IniWrite, %Height%, %iniFile%, %winTitle%, guiHeight
}

outstime_windowSizePosSaveIniRead(winTitle, iniFile){
	IniRead, posX, %iniFile%, %winTitle%, guiX , 0
	IniRead, posY, %iniFile%, %winTitle%, guiY , 0
	IniRead, Width, %iniFile%, %winTitle%, guiWidth , 0
	IniRead, Height, %iniFile%, %winTitle%, guiHeight , 0
	if(posX == 0){
		; guit_errorAppendOnTime("Guiの位置とサイズを読み出し時にエラーあり", winTitle . " の時のエラー")
		return
	}
	WinMove, %WinTitle%, , %posX%, %posY% , %Width%, %Height%
}

outstime_fileSelectButton(str, pControl, titleWord, defaultFolder, guiNum){
	str := outstime_textOutTrimssParsent(str)
	; フォルダなら True
	if( func_isFolder(str) ){
		FileSelectFile, OutputVar, 3, %str%, %titleWord%
	} else {
		FileSelectFile, OutputVar, 3, %defaultFolder%, %titleWord%
	}
	if(OutputVar != ""){
		guf_setControl( OutputVar, pControl, guiNum )
	}
}

outstime_setRadioControl(radioNum, pRadio1, pRadio2, pRadio3, pRadio4, GuiNum){
	if(radioNum == 1) {
		guf_setControl( 1, pRadio1, GuiNum )
	} else if (radioNum == 2) {
		guf_setControl( 1, pRadio2, GuiNum )
	} else if (radioNum == 3) {
		guf_setControl( 1, pRadio3, GuiNum )
	} else {
		guf_setControl( 1, pRadio4, GuiNum )
	}
}

outstime_guiRadioNum(radio1, radio2, radio3, radio4) {
	if(radio1 == 1) {
		return  1
	} else if (radio2 == 1) {
		return  2
	} else if (radio3 == 1) {
		return  3
	} else {
		return  4
	}
}

outstime_guiRadioControl(pRadio1, pRadio2, pRadio3, pRadio4, GuiNum) {
	radio1 := guf_getControl( pRadio1, GuiNum )
	radio2 := guf_getControl( pRadio2, GuiNum )
	radio3 := guf_getControl( pRadio3, GuiNum )
	radio4 := guf_getControl( pRadio4, GuiNum )
	radioNum := outstime_guiRadioNum(radio1, radio2, radio3, radio4)
	return radioNum
}

; % で囲まれた変数の中身を表示させる
outstime_textOutTrimssParsent(com2) {
	pasentChar := "%"
	IfInString, com2, %pasentChar%
	{
		Loop
		{
			res := RegExMatch(com2, "i)^([^%]*)%(\w+)%([\w\W]*)" , val_ )
			; ちなみに \s は半角Space \D は半角以外の文字 \\ は \  \wは[0-9a-zA-Z_]と同じ
			if(val_2 != ""){
				val_2 := outstime_ansValuePersent(val_2)		; 変数の中身を取得
				if(val_2 == ""){
					; 値が空なので中断
					break
				}
				com2 := val_1 . val_2 . val_3		; 元の値を変更して、ループを繰り返す
			} else {
				break
			}
		}
	}
	return com2
}


outstime_ansValuePersent(str) {
	res := RegExMatch(str, "^[0-9a-zA-Z_@#$]+$")
	if(res == 1) {
		if (%str% == "") {			; 変数を表示させる
			;outstime_outPattern1("%の値が見つかりません")
		} else {
			var2 := %str%
			return var2
		}
	} else {
		gutimf_explainSingleOutput("%%の中に無効な文字が入ってます")
	}
	gutimf_checkErrorLevelExplain(A_LineFile, A_LineNumber, ErrorLevel)
	return ""
}


outstime_winSizePosSave(windowTitle, iniFile, Section){
	DetectHiddenWindows, On
	WinRestore, %windowTitle%
	WinGetPos , X, Y, Width, Height, %windowTitle%
	IniWrite, %X%, %iniFile%, %Section%, GuiX
	IniWrite, %Y%, %iniFile%, %Section%, GuiY
	IniWrite, %Width%, %iniFile%, %Section%, GuiWidth
	IniWrite, %Height%, %iniFile%, %Section%, GuiHeight
}

outstime_winSizePosLoad(windowTitle, iniFile, Section, defX=100, defY=100, defWidth=300, defHeight=300){
	DetectHiddenWindows, On
	IniRead, VarX, %iniFile%, %Section%, GuiX , %defX%
	IniRead, VarY, %iniFile%, %Section%, GuiY , %defY%
	IniRead, VarWidth, %iniFile%, %Section%, GuiWidth , %defWidth%
	IniRead, VarHeight, %iniFile%, %Section%, GuiHeight , %defHeight%
	WinMove, %windowTitle%, , %VarX%, %VarY% , %VarWidth%, %VarHeight%
}

; フォルダかどうかを調べる ファイル自体がなければ Trueを返す
outstime_existNotFolderCheck(folder){
	type := FileExist(folder)
	if(type == ""){
		return  True
	} else {
		IfInString, type, D
		{

		} else {
			MsgBox , 4097 , 警告 , %folder%はフォルダ名ではありません , 180
		}
		return  False
	}
}

; ファイルがあるかチェックしてなければ指定のフォルダを作る
outstime_fileCheckAndMakeFolder(file, folder){
	IfNotExist, %file%
	{
		if( outstime_existNotFolderCheck(folder) ){
			FileCreateDir, %folder%
		}
	}
}

; 1h 1m 1s などの指定を 秒に変換する。
; あと、１日以内の指定かをチェック
outstime_confirmAndGetAllSecFromWord(argss){
	allSec := outstime_confirmTimerArgss(argss)
	if(allSec == "error"){

	} else if(allSec > 0){
		if( allSec >= 86400 ){
			gutimf_appendErrorExplain("現時点では２４時間以上先の指定はできない")
			return "error"
		}
	}
	return allSec
}

; 1h 1m 1s などの指定を 秒に変換する。
; trr の linu_confirmTimerArgss(argss) をそのままコピーしたもの
outstime_confirmTimerArgss(argss){
	argss := Trim(argss)
	StringLower, argss, argss
	arg_1 =
	arg_2 =
	arg_3 =
	arg_4 =
	IfInString, argss, %A_Space%
	{
		StringSplit, arg_ , argss , %A_Space%, %A_Space%
	} else {
		arg_1 := argss
	}

	if(arg_4 != null){
		return  "error"
	}


	; 時間の指定の仕方が 1h 1m 1s などになっているかチェック
	flagHorMorS := True
	if( outstime_confirmHorMorS(arg_1) == False ){
		flagHorMorS := False
	}
	if( outstime_confirmHorMorS(arg_2) == False ){
		flagHorMorS := False
	}
	if( outstime_confirmHorMorS(arg_3) == False ){
		flagHorMorS := False
	}
	if( flagHorMorS == False ){
		return  "error"
	}



	hour := outstime_confirmHourMinSec(arg_1, arg_2, arg_3, "h")
	min := outstime_confirmHourMinSec(arg_1, arg_2, arg_3, "m")
	sec := outstime_confirmHourMinSec(arg_1, arg_2, arg_3, "s")
	if(hour == "error"){
		return  "error"
	} else if(min == "error"){
		return  "error"
	} else if(min == "error"){
		return  "error"
	}
	if(hour == null){
		hour = 0
	}
	if(min == null){
		min = 0
	}
	if(sec == null){
		sec = 0
	}
	allSec := outstime_minHourToSec(hour, min, sec)
	return  allSec
}

; 1h 1m 1s などの文字列から、時間の部分のみを変換する。
outstime_confirmTimerArgssHourOnly(argss, funcName){
	argss := Trim(argss)
	StringLower, argss, argss
	arg_1 =
	arg_2 =
	arg_3 =
	arg_4 =
	IfInString, argss, %A_Space%
	{
		StringSplit, arg_ , argss , %A_Space%, %A_Space%
	} else {
		arg_1 := argss
	}

	if(arg_4 != null){
		return  "error"
	}

	; 時間の指定の仕方が 1h 1m 1s などになっているかチェック
	flagHorMorS := True
	if( outstime_confirmHorMorS(arg_1) == False ){
		flagHorMorS := False
	}
	if( outstime_confirmHorMorS(arg_2) == False ){
		flagHorMorS := False
	}
	if( outstime_confirmHorMorS(arg_3) == False ){
		flagHorMorS := False
	}
	if( flagHorMorS == False ){
		return  "error"
	}

	hour := outstime_confirmHourMinSec(arg_1, arg_2, arg_3, "h")
	if(hour == "error"){
		return  "error"
	}
	if(hour == null){
		hour = 0
	}
	allSec := outstime_minHourToSec(hour, 0, 0)
	if( allSec >= 86400 ){
		gutimf_appendErrorExplain(funcName . "  のエラー。`n現時点では２４時間以上先の指定はできない`n時間の指定  " . hour)
		return "error"
	}

	return  hour
}

; 1h 1m 1s などの文字列から、分の部分のみを変換する。
outstime_confirmTimerArgssMinuteOnly(argss, funcName){
	argss := Trim(argss)
	StringLower, argss, argss
	arg_1 =
	arg_2 =
	arg_3 =
	arg_4 =
	IfInString, argss, %A_Space%
	{
		StringSplit, arg_ , argss , %A_Space%, %A_Space%
	} else {
		arg_1 := argss
	}

	if(arg_4 != null){
		return  "error"
	}

	; 時間の指定の仕方が 1h 1m 1s などになっているかチェック
	flagHorMorS := True
	if( outstime_confirmHorMorS(arg_1) == False ){
		flagHorMorS := False
	}
	if( outstime_confirmHorMorS(arg_2) == False ){
		flagHorMorS := False
	}
	if( outstime_confirmHorMorS(arg_3) == False ){
		flagHorMorS := False
	}
	if( flagHorMorS == False ){
		return  "error"
	}

	min := outstime_confirmHourMinSec(arg_1, arg_2, arg_3, "m")
	if(min == "error"){
		return  "error"
	}
	if(min == null){
		min = 0
	}
	allSec := outstime_minHourToSec(0, min, 0)
	if( allSec >= 86400 ){
		gutimf_appendErrorExplain(funcName . "  のエラー。`n現時点では２４時間以上先の指定はできない`n分の指定  " . min)
		return "error"
	}

	return  min
}

; 1h 1m 1s などの文字列から、秒の部分のみを変換する。
outstime_confirmTimerArgssSecondOnly(argss, funcName){
	argss := Trim(argss)
	StringLower, argss, argss
	arg_1 =
	arg_2 =
	arg_3 =
	arg_4 =
	IfInString, argss, %A_Space%
	{
		StringSplit, arg_ , argss , %A_Space%, %A_Space%
	} else {
		arg_1 := argss
	}

	if(arg_4 != null){
		return  "error"
	}

	; 時間の指定の仕方が 1h 1m 1s などになっているかチェック
	flagHorMorS := True
	if( outstime_confirmHorMorS(arg_1) == False ){
		flagHorMorS := False
	}
	if( outstime_confirmHorMorS(arg_2) == False ){
		flagHorMorS := False
	}
	if( outstime_confirmHorMorS(arg_3) == False ){
		flagHorMorS := False
	}
	if( flagHorMorS == False ){
		return  "error"
	}

	sec := outstime_confirmHourMinSec(arg_1, arg_2, arg_3, "s")
	if(sec == "error"){
		return  "error"
	}
	if(sec == null){
		sec = 0
	}
	if( sec >= 86400 ){
		gutimf_appendErrorExplain(funcName . "  のエラー。`n現時点では２４時間以上先の指定はできない`n秒の指定  " . sec)
		return "error"
	}

	return  sec
}

outstime_minHourToSec(hour, min, sec){
	minToSec := min * 60
	hourToSec := hour * 3600
	allSec := hourToSec + minToSec + sec
	return  allSec
}

; 時間の指定の仕方が 1h 1m 1s などになっているかチェック
outstime_confirmHorMorS(arg){
	if( arg == null ){
		return  True
	}
	StringRight, searchChar, arg, 1
	if( searchChar == "h" ){

	} else if(searchChar == "m"){

	} else if(searchChar == "s"){

	} else {
		return  False
	}

	StringTrimRight, leftStr, arg, 1
	If leftStr is not number
	{
		return  False
	}
	return  True
}

outstime_confirmHourMinSec(arg_1, arg_2, arg_3, searchChar){
	hour_if := outstime_hourOrMinOrSecArgGet(arg_1, searchChar)
	if(hour_if != null){
		return  hour_if
	}
	hour_if := outstime_hourOrMinOrSecArgGet(arg_2, searchChar)
	if(hour_if != null){
		return  hour_if
	}
	hour_if := outstime_hourOrMinOrSecArgGet(arg_3, searchChar)
	if(hour_if != null){
		return  hour_if
	}
	return  null
}

outstime_hourOrMinOrSecArgGet(arg, searchChar){
	IfInString, arg, %searchChar%
	{
		StringGetPos, count, arg, %searchChar%
		StringLeft, str_sec, arg, %count%
		str_sec := LTrim(str_sec)
		If str_sec is  number
		{
			return  str_sec
		}
		return  "error"
	}
	return  null
}
