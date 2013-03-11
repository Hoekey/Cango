;DaysLeft.ahk
; Author snwind 
; http://blog.csdn.net/liuyukuan

/*
[config]
DateTarget=20130302000000
DateFrom=19820401000000
*/

;~ #SingleInstance,force
;~ ListLines, On

FormatTime, today,, yyyyMMdd
IniRead,DateTarget,%A_ScriptFullPath%,config,DateTarget
IniRead,DateFrom,%A_ScriptFullPath%,config,DateFrom,%today%
;为了cango才处理传参
if  0>0
{
	DateTarget =%1%	
	DateFrom=%today%
}
Gui, Add, DateTime, x86 y7 w160 h40 vDateFrom Choose%DateFrom% gCount ,yyyy-MM-dd
Gui,Add,Button,x286 y7 w90 h20 gFromToday,设置成今天
Gui, Add, DateTime, x86 y57 w160 h40 vDateTarget Choose%DateTarget% gCount ,yyyy-MM-dd
Gui,Add,Button,x286 y57 w90 h20 gTargetToday,设置成今天
Gui, Add, GroupBox, x26 y107 w260 h120 , DaysLeft
Gui, Font, s18 cRed Bold, Verdana  ; 如果需要, 使用这样的一行给窗口设置新的默认字体.
Gui, Add, Text, x36 y127 w240 h60 vDaysLeft
;~ GuiControl, Font,DaysLeft  ; 让上面的字体设置对控件生效.
Gui, Add, Text, x6 y7 w70 h30 , 开始
Gui, Add, Text, x6 y57 w70 h30 , 目标
; Generated using SmartGUI Creator 4.0
;~ Gui, Show,, DaysLeft
Gosub,Count
Gui, Show,, DaysLeft
return


Count:
gui,SUBMIT,NOHIDE
IniWrite %DateTarget%,%A_ScriptFullPath%,config,DateTarget
IniWrite %DateFrom%,%A_ScriptFullPath%,config,DateFrom
DaysLeft :=DateTarget
EnvSub, DaysLeft, %DateFrom%, days
nian:=DaysLeft//365
tian:=Mod(DaysLeft,365)
tips=%DaysLeft%天`n~%nian%年，又%tian%天
GuiControl,,DaysLeft,%tips%
return

FromToday:
GuiControl,,DateFrom,%today%
Gosub,Count
return

TargetToday:
GuiControl,,DateTarget,%today%
Gosub,Count
return



GuiEscape:
GuiClose:
ButtonCancel:
ExitApp
