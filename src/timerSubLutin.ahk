




SubCancelTimer:

	return

SubVisibleMainTimer:
	; 使用中のウインドウの方を表示する
	cetimer_showInUseWindow()
	;Gui, 20:Show
	return

SubExitAppTimer:
	cetimer_exitAppsConfirmEnyExecution()
	return

SubPosDefaultTimer:
	gutiin_initGuiAll()
	IfExist, %glotimer_windowSizePosIni%
	{
		FileDelete, %glotimer_windowSizePosIni%
	}
	guf_showGuiAssign(20)
	return

SubConseTimer:
	guf_showGuiAssign(33)
	return

SubSoundCloseOnlyTimer:
	time_soundClose()
	return

SubVersionGuiTimer:
	guf_showGuiAssign(34)
	return

SubTimerTimerType1:
	tglo_setTextTime1 := tglo_setTextTime1 + tglo_timePeriod_sec
	if(tglo_setTextTime1 >= tglo_iniSetTextPeriod_sec){
		time_setTextTimer_2(1)
	}

	if(glotimer_timer1 <= A_Now) {
		SetTimer, SubTimerTimerType1 , Off
		time_timeOutLogic(1)
	}
	return

SubTimerTimerType2:
	tglo_setTextTime2 := tglo_setTextTime2 + tglo_timePeriod_sec
	if(tglo_setTextTime2 >= tglo_iniSetTextPeriod_sec){
		time_setTextTimer_2(2)
	}

	if(glotimer_timer2 <= A_Now) {
		SetTimer, SubTimerTimerType2 , Off
		time_timeOutLogic(2)
	}
	return

SubTimerTimerType3:
	tglo_setTextTime3 := tglo_setTextTime3 + tglo_timePeriod_sec
	if(tglo_setTextTime3 >= tglo_iniSetTextPeriod_sec){
		time_setTextTimer_2(3)
	}

	if(glotimer_timer3 <= A_Now) {
		SetTimer, SubTimerTimerType3 , Off
		time_timeOutLogic(3)
	}
	return

SubTimerTimerType4:
	tglo_setTextTime4 := tglo_setTextTime4 + tglo_timePeriod_sec
	if(tglo_setTextTime4 >= tglo_iniSetTextPeriod_sec){
		time_setTextTimer_2(4)
	}

	if(glotimer_timer4 <= A_Now) {
		SetTimer, SubTimerTimerType4 , Off
		time_timeOutLogic(4)
	}
	return

SubTimerTimerType5:
	tglo_setTextTime5 := tglo_setTextTime5 + tglo_timePeriod_sec
	if(tglo_setTextTime5 >= tglo_iniSetTextPeriod_sec){
		time_setTextTimer_2(5)
	}

	if(glotimer_timer5 <= A_Now) {
		SetTimer, SubTimerTimerType5 , Off
		time_timeOutLogic(5)
	}
	return

SubStopWatchType1:
	tglo_startStopWaToSec1 := tglo_startStopWaToSec1 + tglo_timePeriod_sec
	tglo_setTextStopWa1    := tglo_setTextStopWa1 + tglo_timePeriod_sec
	if(tglo_setTextStopWa1 >= tglo_iniSetTextPeriod_sec){
		time_setTextStopWa_2(1)
	}

	if(tglo_stopWaToSec1 <= tglo_startStopWaToSec1) {
		SetTimer, SubStopWatchType1 , Off
		time_timeOutStopWaLogic(1)
	}
	return

SubStopWatchType2:
	tglo_startStopWaToSec2 := tglo_startStopWaToSec2 + tglo_timePeriod_sec
	tglo_setTextStopWa2    := tglo_setTextStopWa2 + tglo_timePeriod_sec
	if(tglo_setTextStopWa2 >= tglo_iniSetTextPeriod_sec){
		time_setTextStopWa_2(2)
	}

	if(tglo_stopWaToSec2 <= tglo_startStopWaToSec2) {
		SetTimer, SubStopWatchType2 , Off
		time_timeOutStopWaLogic(2)
	}
	return

SubStopWatchType3:
	tglo_startStopWaToSec3 := tglo_startStopWaToSec3 + tglo_timePeriod_sec
	tglo_setTextStopWa3    := tglo_setTextStopWa3 + tglo_timePeriod_sec
	if(tglo_setTextStopWa3 >= tglo_iniSetTextPeriod_sec){
		time_setTextStopWa_2(3)
	}

	if(tglo_stopWaToSec3 <= tglo_startStopWaToSec3) {
		SetTimer, SubStopWatchType3 , Off
		time_timeOutStopWaLogic(3)
	}
	return

SubStopWatchType4:
	tglo_startStopWaToSec4 := tglo_startStopWaToSec4 + tglo_timePeriod_sec
	tglo_setTextStopWa4    := tglo_setTextStopWa4 + tglo_timePeriod_sec
	if(tglo_setTextStopWa4 >= tglo_iniSetTextPeriod_sec){
		time_setTextStopWa_2(4)
	}

	if(tglo_stopWaToSec4 <= tglo_startStopWaToSec4) {
		SetTimer, SubStopWatchType4 , Off
		time_timeOutStopWaLogic(4)
	}
	return

SubStopWatchType5:
	tglo_startStopWaToSec5 := tglo_startStopWaToSec5 + tglo_timePeriod_sec
	tglo_setTextStopWa5    := tglo_setTextStopWa5 + tglo_timePeriod_sec
	if(tglo_setTextStopWa5 >= tglo_iniSetTextPeriod_sec){
		time_setTextStopWa_2(5)
	}

	if(tglo_stopWaToSec5 <= tglo_startStopWaToSec5) {
		SetTimer, SubStopWatchType5 , Off
		time_timeOutStopWaLogic(5)
	}
	return

SubAlarmTimer:
	if(tglo_reAlarmTimer <= A_Now){
		SoundPlay, %glotimer_bellNotePlaying%
		time_reAlarmTimeSetForPlaying()
	}

	if(tglo_alarmTimer <= A_Now) {
		time_soundCloseAndGuiHide()
	}

	return

SubTestPlayAlarm:
	tglo_setTextTestPlay_sec += tglo_timePeriod_sec
	if(tglo_setTextTestPlay_sec >= tglo_iniSetTextPeriod_sec){
		time_setTextTestPlay()
	}

	if(tglo_reAlarmTestPlay <= A_Now){
		SoundPlay, %tglo_bellNoteTestPlay%
		time_reAlarmTestPlayPlaying()
	}

	if(tglo_alarmTestPlay <= A_Now) {
		time_soundTestPlayClose()
	}

	return
