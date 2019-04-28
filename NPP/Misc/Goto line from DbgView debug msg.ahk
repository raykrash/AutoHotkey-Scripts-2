#SingleInstance Force
#Include C:\Users\Mark\Desktop\Misc\AutoHotkey Scripts
#Include lib\strings.ahk
#Include lib\npp.ahk
SetTitleMatchMode 2
npp_wintitle := ".ahk - Notepad++ ahk_class Notepad++ ahk_exe notepad++.exe"
dbgview_wintitle := "ahk_class dbgviewClass ahk_exe Dbgview.exe"
dialog_wintitle := "ahk_class #32770 ahk_exe AutoHotkey.exe"

If WinActive(dialog_wintitle)
    ControlGetText, text_line, Static1, %dialog_wintitle%
Else
    ControlGet, text_line, List, Selected, SysListView321, %dbgview_wintitle%

; note controlget from SysListView321 returns the selected line multiple times. 
; the regexreplace also handles this retrieving the line# once.
line_num := RegExReplace(text_line, "si)^.*Line#(\d+).*$", "$1", replaced_count)
If replaced_count
    npp_goto_line(line_num, npp_wintitle)
Else
    MsgBox, 48,, % "Line# not found in selected Dbgview line or dialog box.", 2
ExitApp
