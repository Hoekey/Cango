
cango_文字到桌面txt:
FileName=%A_Now%
if 0>0
{
   candyselected=%1%
   MsgBox %candyselected%
 }  


if strlen(candyselected)=0
{
   TrayTip, 提示1:, 剪切板中没有内容，文件未创建！
   Sleep,3000
}
else
{
   fileappend,%candyselected%,%A_Desktop%\%FileName%.ahk
   ifexist %A_Desktop%\%FileName%.ahk
   {
      TrayTip, 提示2:, 桌面上新建了%FileName%.ahk，内容是：`n%candyselected%
      run %A_Desktop%\%FileName%.ahk
   }
   else
   {
   traytip,提示3,出问题了，没建成功！
   }
}
return
