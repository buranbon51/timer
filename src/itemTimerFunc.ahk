
itet_iniSetCombBox(){
	itef_iniFileObjSetting(glotimer_softNamessFile, glotimer_softIniFile, glotimer_softObj)
	itet_setCombBoxSoftObj()
}

itet_setCombBoxSoftObj(){
	buff := itef_softObjToPipeStr(glotimer_softObj)
	guf_setControl( buff, "ComboBox23_1", 23 )
	guf_setControl( buff, "ComboBox26_1", 26 )
}

itet_combBoxToEditss(ComboBox, Edit1, Edit2, Edit3, GuiNum ){
	comb := guf_getControl( ComboBox, GuiNum )
	optionObj := glotimer_softObj[comb]
	guf_setControl( optionObj[1], Edit1, GuiNum )
	guf_setControl( optionObj[2], Edit2, GuiNum )
	guf_setControl( optionObj[3], Edit3, GuiNum )
}
