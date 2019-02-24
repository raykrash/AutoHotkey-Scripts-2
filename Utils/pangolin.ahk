#SingleInstance Force
#Include C:\Users\Mark\Desktop\Misc\AutoHotkey Scripts
#Include lib\trayicon.ahk
#Include lib\processes.ahk
; #NoTrayIcon
#IfWinActive


Return 

CapsLock & 0::
CapsLock & 9:: 
CapsLock & 8:: 
CapsLock & 7:: 
CapsLock & 6:: 
CapsLock & 5:: 
CapsLock & 4:: 
CapsLock & 3:: 
CapsLock & 2::
    SetCapsLockState, AlwaysOff
    save_detect_hidden_windows := A_DetectHiddenWindows 
    DetectHiddenWindows, On

    
    If (A_ThisHotkey = "Capslock & 0")
        dimmer_level := 2
    Else If (A_ThisHotkey = "Capslock & 9") 
        dimmer_level := 3
    Else If (A_ThisHotkey = "Capslock & 8") 
        dimmer_level := 4
    Else If (A_ThisHotkey = "Capslock & 7") 
        dimmer_level := 5
    Else If (A_ThisHotkey = "Capslock & 6") 
        dimmer_level := 6
    Else If (A_ThisHotkey = "Capslock & 5") 
        dimmer_level := 7
    Else If (A_ThisHotkey = "Capslock & 4") 
        dimmer_level := 8
    Else If (A_ThisHotkey = "Capslock & 3") 
        dimmer_level := 9
    Else If (A_ThisHotkey = "Capslock & 2")
        dimmer_level := 10
    Else
    {
        OutputDebug, % "Unexepected hotkey: " A_ThisHotkey " (" A_ScriptName ")"
        Return
    }
        
    TrayIcon_Button("PangoBright.exe", "R", False, 1)    
    Sleep 300
    SetTitleMatchMode 2 
    If Not WinExist("ahk_class #32768 ahk_exe PangoBright.exe")
        MsgBox, 48,, % "Pangolin Popup menu does not exist", 10
    Else
    {
        WinSet, Top
        Sleep 100
        SendInput {Down %dimmer_level%}
        Sleep 300
        SendInput {Enter}   
    }
    SendInput {CapsLock Up}
    DetectHiddenWindows, %save_detect_hidden_windows%
    Return 
