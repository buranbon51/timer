
; 普通行われる処理の変わりに実行する処理を記入する。
; 返り値が True なら、普通行われる処理を実行せずスルーする。
; 返り値が False なら、普通行われる処理が実行される（アラームとか）


; 時刻で指定し、その時間になった際に実行する処理。
userase_anyScriptExecuteTime(listNumber, expression, file, args, workFolder){

/*
	flag := globalValueFlag%listNumber%
	if( flag ){
		userMakeFunction(args)

		return True
	}
*/


	return False
}

; 数字指定で指定し、その時間になった際に実行する処理。
userase_anyScriptExecuteNumeral(listNumber, expression, file, args, workFolder){

/*
	flag := globalValueFlag%listNumber%
	if( flag ){
		userMakeFunction(args)

		return True
	}
*/


	return False
}
