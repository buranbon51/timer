





gutiin_cleatedDateTimer(){
	version := "v1.00"
	cleatedDate := "2023年4月17日"
	str_local := "昔のAhkの解像度の違いに対応"
	softName := "ListTimerBU"

	Gui, 34:Add, Text,   X70 Y10 , %softName%

	groupW := cetimer_timerNumFromDpiAndFontSize(18, 20, 250, 270, 290)
	groupH := cetimer_timerNumFromDpiAndFontSize(6, 8, 145, 165, 185)
	Gui, 34:Add, GroupBox, X10 y+15  w%groupW% h%groupH%
	Gui, 34:Add, Text,  X30 yp+20,    バージョン：
	Gui, 34:Add, Text,    x+20 yp+0 , %version%
	Gui, 34:Add, Text,  X30 y+15,    %str_local%
	Gui, 34:Add, Text,  X30 y+15,    更新日　：
	Gui, 34:Add, Text,    x+20 yp+0 , %cleatedDate%
	Gui, 34:Add, Text,  X30 y+15,    作者　　：
	Gui, 34:Add, Text,    x+20 yp+0 ,    ブランボン
	Gui, 34:Add, Text,  X30 y+30,    AHKのバージョン：
	Gui, 34:Add, Text,    x+10 yp+0 ,  %A_AhkVersion%
	Gui, 34:Add, Text,  xp+0 y+15,    %timema_bitVar%
	Gui, 34:Add, Text,  X30 y+15,    %timema_sign%
}

gutiin_initGuiAll(){
	gutiin_initGui20()
	gutiin_initGui21()
	gutiin_initGui22()
	gutiin_initGui23()
	gutiin_initGui24()
	gutiin_initGui25()
	gutiin_initGui26()
	gutiin_initGui27()
	gutiin_initGui28()
	gutiin_initGui29()

	gutiin_initGui31()
	gutiin_initGui32()
	gutiin_initGui33()
	gutiin_initGui34()

}

gutiin_initGui20() {
	width := cetimer_timerNumFromDpiAndFontSize(17, 24, 260, 283, 303)
	height := cetimer_timerNumFromDpiAndFontSize(17, 16, 297, 317, 337)
	Gui, 20:Show, Hide  x60 y320 w%width% h%height%, %glotimer_Gui20Title%
}

gutiin_initGui21() {
	width := cetimer_timerNumFromDpiAndFontSize(23, 36, 351, 391, 431)
	height := cetimer_timerNumFromDpiAndFontSize(19, 16, 295, 315, 335)
	Gui, 21:Show, Hide  x60 y320 w%width% h%height%, %glotimer_Gui21Title%
}

gutiin_initGui22() {
	width := cetimer_timerNumFromDpiAndFontSize(17, 18, 296, 316, 336)
	height := cetimer_timerNumFromDpiAndFontSize(17, 19, 361, 381, 401)
	Gui, 22:Show, Hide  x290 y250 w%width% h%height%, %glotimer_Gui22Title%
}

gutiin_initGui23() {
	width := cetimer_timerNumFromDpiAndFontSize(12, 18, 283, 303, 323)
	height := cetimer_timerNumFromDpiAndFontSize(26, 20, 407, 427, 447)
	Gui, 23:Show, Hide  x110 y150 w%width% h%height%, %glotimer_Gui23Title%
}

gutiin_initGui24() {
	Gui, 24:Show, Hide  x70 y30 AutoSize, %glotimer_Gui24Title%
}

gutiin_initGui25() {
	width := cetimer_timerNumFromDpiAndFontSize(17, 18, 296, 316, 336)
	height := cetimer_timerNumFromDpiAndFontSize(17, 19, 361, 381, 401)
	Gui, 25:Show, Hide  x290 y250 w%width% h%height%, %glotimer_Gui25Title%
}

gutiin_initGui26() {
	width := cetimer_timerNumFromDpiAndFontSize(12, 18, 283, 303, 323)
	height := cetimer_timerNumFromDpiAndFontSize(26, 20, 407, 427, 447)
	Gui, 26:Show, Hide  x110 y150 w%width% h%height%, %glotimer_Gui26Title%
}

gutiin_initGui27() {
	Gui, 27:Show, Hide  x180 y90 AutoSize  ; , タイトルはここで設定しない
}

gutiin_initGui28() {
	width := cetimer_timerNumFromDpiAndFontSize(19, 24, 328, 363, 393)
	height := cetimer_timerNumFromDpiAndFontSize(7, 8, 83, 93, 103)
	Gui, 28:Show, Hide  x80 y340 w%width% h%height%, %glotimer_Gui28Title%
}

gutiin_initGui29() {
	Gui, 29:Show, Hide  x80 y340 AutoSize, %glotimer_Gui29Title%
}


gutiin_initGui31() {
	width := cetimer_timerNumFromDpiAndFontSize(15, 25, 251, 281, 311)
	height := cetimer_timerNumFromDpiAndFontSize(25, 24, 323, 343, 363)
	Gui, 31:Show, Hide  x350 y280 w%width% h%height%, %glotimer_Gui31Title%
}

gutiin_initGui32() {
	width := cetimer_timerNumFromDpiAndFontSize(15, 25, 251, 281, 311)
	height := cetimer_timerNumFromDpiAndFontSize(25, 24, 323, 343, 363)
	Gui, 32:Show, Hide  x350 y280 w%width% h%height%, %glotimer_Gui32Title%
}

gutiin_initGui33() {
	Gui, 33:Show, Hide x290 y321  AutoSize, %glotimer_Gui33Title%
}

gutiin_initGui34() {
	Gui, 34:Show, Hide x160 y200  AutoSize, %glotimer_Gui34Title%
}
