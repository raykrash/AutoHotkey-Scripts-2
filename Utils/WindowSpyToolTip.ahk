#SingleInstance Force
#Include C:\Users\Mark\Desktop\Misc\AutoHotkey Scripts
#Include lib\constants.ahk
SetWorkingDir %AHK_ROOT_DIR%
Menu, Tray, Icon, ..\resources\32x32\Visual Studio\spyxx_1.ico
Loop
{
    MouseGetPos, x, y, out_hwnd, out_class

    WinGetTitle, i_title, ahk_id %out_hwnd%
    WinGetClass, i_class, ahk_id %out_hwnd%
    WinGet, i_procname, ProcessName, ahk_id %out_hwnd%
    i_class := "ahk_class " . i_class
    i_procname := "ahk_exe " . i_procname
    active_win := i_title "`n" i_class " " i_procname
    WinGet, control_list, ControlList, ahk_id %out_hwnd%
    sort control_list
    visible_control_list := ""
    Loop, parse, control_list, "`r`n"
    {
        ControlGet, is_visible, Visible,, %A_LoopField%, A
        if is_visible
            visible_control_list .= A_LoopField "`n"
    }

    active_win := If StrLen(active_win) <= 60 ? active_win : SubStr(active_win,1,3) "..." Substr(active_win,60)
    tooltip_text := "" 
        . "RBbutton=short info | Ctrl+RButton=long info | Escape=Exit" 
        . "`n`n" active_win
        . "`nahk_id " out_hwnd 
        . "`nControl: " out_class
        . "`n`nMouse - CoordMode: " A_CoordModeMouse " | x, y: " x ", " y

    tooltip_text_full := tooltip_text  "`nControl list: `n" visible_control_list

    tooltip, %tooltip_text% , x + 20, y + 20  
    Sleep 1000
}

ExitApp     ; see escape hotkey

RButton:: Clipboard := tooltip_text

Control & RButton:: 
    tooltip, %tooltip_text_full% , x + 20, y + 20 
    tooltip_text_full := StrReplace(tooltip_text_full, "`nahk_class", " ahk_class",,1)
    Clipboard := tooltip_text_full
    ClipWait, 1
    Return

Escape::ExitApp

