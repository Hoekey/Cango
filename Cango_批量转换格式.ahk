/*
作者:    	莫名iceideal[at]gmail[dot]com
脚本说明：	接受文件夹路径，将该文件夹及其子文件夹下 用户指定后缀 的文本文件转换成指定的编码。并可选择是否备份
范例：    	批量转换格式 = run|Extension\批量转换格式.ahk "{file:pathfull}"
注意：		不要指定非文本文档的后缀哦。因为 FileAppend 的处理过快，造成loop的重新坛坛循环已经处理过的文件，所以将生成的文件暂存在所处理的文件夹的上一层，在处理完后，再统一移动回来。
完成时间：	2013-01-31 10:34:46
*/
SetBatchLines, -1  ; 让操作以最快速度进行.

;============================================接受参数============================================
pathfull = %1%
if pathfull =
{
	MsgBox, 没用输入参数，请查正
	Return
}
;============================================设置，临时文件夹处理============================================
存入剪贴板 = 1  ;将转换列表存入剪贴板
转换列表 =  
转换个数=0
备份 = 0

SplitPath, pathfull, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
;上一层文件夹为 OutDir
FormatTime, NowTime,, yyyyMMdhmmss 
临时文件夹名字 := OutDir . "\~转换格式临时文件夹" . NowTime 
FileCreateDir, %临时文件夹名字%
;============================================用户输入============================================
InputBox,后缀, 请输入文件后缀,ini，ahk...,,200,140,,,,,ini
if 后缀 = 
{
	后缀 = txt
}
InputBox,编码, 请输入要转换后编码,默认UTF-8`n还可以是UTF-16，UTF-8-RAW 或 UTF-16-RAW，ANSI,,300,160,,,,,UTF-8
if(!RegExMatch(编码,"i)^(UTF-8|UTF-16|UTF-8-RAW|UTF-16-RAW|ANSI)$"))
{
	Encoding = UTF-8
}
if(编码 = ansi)
{
	Encoding = 
}
MsgBox, 36, 提示, 转换前备份（加.bak，如果有同名备份文件，则覆盖）原始文件`,继续？
IfMsgBox Yes
{
	备份 = 1
}
;============================================转换============================================
Loop,%pathfull%\*.%后缀%,0,1
{
	;TrayTip,进度,正在转换%A_LoopFileLongPath%
	FileRead,fileContent,%A_LoopFileLongPath%
	if 备份 = 1
	{
		FileMove, %A_LoopFileLongPath%, %A_LoopFileLongPath%.bak ,1
	}Else{
		FileDelete, %A_LoopFileLongPath%
	}
	FileAppend,%fileContent%,%临时文件夹名字%\%A_LoopFileName%,%Encoding%
	转换列表 .= A_LoopFileLongPath . "`n"
	转换个数 ++
}
FileMoveDir,%临时文件夹名字%,%pathfull%,2
;============================================提示============================================
if 转换个数 > 0
{
	Clipboard := 转换列表
	ClipWait
	转换列表 := "成功转换了以下" . 转换个数 . "个文件为" . 编码 . "：`n" . 转换列表
	TrayTip,转换完成,%转换列表%
}Else{
	TrayTip,转换完成,没有相符的文件，你确定 %后缀% 没有错？
}
Sleep, 3000
TrayTip