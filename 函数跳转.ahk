cango_函数跳转:

candyselected=%1%
MouseGetPos,    Candy_CurrWin_x,Candy_CurrWin_y,Candy_CurrWin_id,Candy_CurrWin_ClassNN,    

	WinGetTitle,title,Ahk_ID %Candy_CurrWin_id%
	MsgBox %title%
	SplitPath,title,,当前文档所在目录
	MsgBox %当前文档所在目录%
	WinGet,path,ProcessPath,Ahk_ID %Candy_CurrWin_id%

	loop,%当前文档所在目录%\lib\*.ahk
	{
		IfInString,A_LoopFileFullPath,%candyselected%   ;把这个换成正则
		{
			Run,%path% "%A_LoopFileFullPath%"  ;如果想更精确的话，就进文件看看
			Break
		}
	}
	Return
	/*
这是Scite支持的lua写的内部插件

-- this centers the cursor position
 function center_pos(line)
 local line
  if not line then 
     -- this is the current line
     line = editor:LineFromPosition(editor.CurrentPos)
  end
  local top = editor.FirstVisibleLine
  local middle = top + editor.LinesOnScreen/2
  editor:LineScroll(0,line - middle)
 end
*/

