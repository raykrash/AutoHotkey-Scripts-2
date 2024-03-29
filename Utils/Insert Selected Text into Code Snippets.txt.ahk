#SingleInstance Force
#Include C:\Users\Mark\Desktop\Misc\AutoHotkey Scripts
#Include lib\strings.ahk
#Include lib\npp.ahk
#Include lib\misc.ahk
#Include lib\utils.ahk
#Include lib\constants.ahk
#Include lib\Code Snippets.txt
SetWorkingDir %AHK_ROOT_DIR%
g_TRAY_EXIT_ON_LEFTCLICK := True      ; set only 1 to true to enable, see lib\utils.ahk

key_word := select_and_copy_word()
key_word := RegExReplace(key_word,"(\s|`r|`n)", "") ; remove whitespace
key_word := tcase(key_word) ; titlecase
If (key_word == "")
{
    MsgBox, 48,, % "Error: Cursor not on word / nothing selected..."
    Return
}
If (code_snippetz[key_word] <> "")
{
    MsgBox, 48,, % "Duplicate Key Word: " key_word "`r`n`r`n" code_snippetz[key_word]
    Return
}
;
SendInput {Down}!{Home}
MouseMove, A_CaretX, A_CaretY
msg = `r`n`r`n    Select code lines to be added with MOUSE then hit {Return} to accept. {Escape} to cancel.    `r`n`r`n.
Loop, 5
{
    ToolTip, %msg%, 800, 0
    Sleep 100
    ToolTip, %msg%, 800, 150
    Sleep 100
}
Input,ov, L1, {Escape}{Return}
If (ErrorLevel = "EndKey:Escape")
    Goto INSERT_CS_EXIT
ToolTip
SendInput ^c
ClipWait, 2
code_snippet := Clipboard 
write_string := create_code_snippet_entry(key_word, code_snippet)
;
SetTimer, answer_reload_prompt, 100
cs_file = %AHK_ROOT_DIR%\lib\Code Snippets.txt
FileAppend, %write_string%, %cs_file%
npp_open_file(cs_file)
;
saved_autotrim := A_AutoTrim
AutoTrim Off
one_tab := "    "   ; 4 spaces
Clipboard = %one_tab%Else If RegExMatch(p_key_word,`"i)\b%key_word%.*\b`")`r`n%one_tab%%one_tab%code_snippet := p_code_snippet_array[`"%key_word%`"]
ClipWait, 2 
AutoTrim := saved_autotrim
MsgBox, 33,, % "The required code is saved on the Clipboard.`r`n`r`nOk to edit Insert Snippet for Selected Word.ahk?"
IfMsgBox, Cancel
    Goto INSERT_CS_EXIT
; edit Insert Snippet for Selected Word.ahk
insert_file = %AHK_ROOT_DIR%\MyScripts\Utils\Insert Snippet for Selected Word.ahk
npp_open_file(insert_file)

; Find the insertion point for the line of code where Clipboard contents should be pasted.
line_num := 0
code_line := "#### DO NOT REMOVE THIS COMMENT. IT IS USED TO FIND THIS LINE NUMBER IN THIS CODE BY OTHER PROGRAMS ###"
FileRead, in_file_var, %insert_file% 
Loop, Parse, in_file_var, `n, `r 
{
    If (SubStr(Trim(A_LoopField), 3) == code_line)
    {
        line_num := A_Index
        Break
    }
}
; Goto insertion point
line_found := goto_line(line_num - 1)
If line_found
{
    SendInput {Enter}{Up}
    MouseMove, A_CaretX, A_CaretY
    MouseGetPos, x, y
    Loop, 5
    {
        Tooltip, % "`r`n    Paste code on this line here....    `r`n ", x+5, y+5
        Sleep 500
        Tooltip
        Sleep 100
    }
    Tooltip  
}
INSERT_CS_EXIT:
SetTitleMatchMode %A_TitleMatchMode%
; WinActivate, ahk_class dbgviewClass ahk_exe Dbgview.exe
ExitApp

answer_reload_prompt()
{
    saved_titlematchmode := A_TitleMatchMode
    SetTitleMatchMode 3
    reload_wintitle = Reload ahk_class #32770 ahk_exe notepad++.exe
    If WinExist(reload_wintitle)
    {
        ControlGetText, prompt_text, Static2, %reload_wintitle%
        If InStr(prompt_text, "Code Snippets.txt")
        {
            While WinExist(reload_wintitle)
            {
                WinActivate, %reload_wintitle%
                ControlClick, &Yes, %reload_wintitle%,, Left, 1, NA
                Sleep 100
            }
            SetTimer, %A_ThisFunc%, Off
            ;
            insert_msg_wintitle = Insert Selected Text into Code Snippets.txt.ahk ahk_class #32770 ahk_exe AutoHotkey.exe
            While WinExist(insert_msg_wintitle) 
            {
                If Not WinActive
                    WinActivate, %insert_msg_wintitle%
                Sleep 100
            }
        }
    }
    SetTitleMatchMode %A_TitleMatchMode%
    Return
}