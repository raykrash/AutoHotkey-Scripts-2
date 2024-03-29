;---------------------------------------------------------------------------------------------
; Braces are used to be able to fold (!0) the document the way I want in Notepad++ 
;---------------------------------------------------------------------------------------------
#Include C:\Users\Mark\Desktop\Misc\AutoHotkey Scripts
#Include lib\processes.ahk
#Include lib\strings.ahk
#Include lib\constants.ahk       
#Include lib\utils.ahk
; #Include lib\npp.ahk
#Include lib\scite.ahk
#NoEnv
#SingleInstance Force
; #MenuMaskKey vk07   ; suppress unwanted win key default activation.
SendMode Input
SetTitleMatchMode %STM_CONTAINS% 
SetTitleMatchMode RegEx
SetWorkingDir %AHK_ROOT_DIR%
SetCapsLockState, AlWaysOff
; SetNumLockState, AlWaysOn
Menu, Tray, Icon, ..\resources\32x32\Old Key.png, 1
g_TRAY_MENU_ON_LEFTCLICK := True    ; see lib\utils.ahk

system_startup := (A_Args[1] = "system")		; configured in Window's Task Scheduler/Properties/Action parameter
SetTimer, PROCESSMONITOR, 1800000 ; check every 30 minutes 1 minute = 60,000 millisecs
SetTimer, TEXTNOW, 300000         ; check every 5 minutes if Textnow is running

Run, MyScripts\MyHotStrings.ahk
Run, MyScripts\Utils\Tab key For Open or Save Dialogs.ahk
Run, MyScripts\Utils\Web\Load Web Games Keyboard Shortcuts.ahk
Run, MyScripts\Utils\Create Menu From Directory - Launch Copy.ahk "C:\Users\Mark\Documents\Launch" %True% %False% %False% %True% %False%

; ttip("`r`nsystem_startup: " system_startup " `r`n A_Args[1]:" A_Args[1] , 1500)
If !system_startup
	Run, MyScripts\Utils\Web\TextNow.ahk "Minimize"
Else
{
	; run this on system startup not when invoked manually (^. hotkey)
	Run, MyScripts\Utils\Web\TextNow.ahk 
	WinWaitActive, .*Google Chrome
	If WinActive(".*Google Chrome")
		Run, MyScripts\Utils\Move Active Window To Other Virtual Desktop.ahk
}
; Run, MyScripts\Utils\Keep KDrive Active.ahk
; Run, plugins\Convert Numpad to Mouse.ahk
; Run, plugins\Hotkey Help (by Fanatic Guru).ahk
Return

;===========================================================================================

PROCESSMONITOR:
{
    return_array := {}
    found := find_process(return_array, "autohotkey", "monitor keyboard hotkeys")
    If Not found
        Run, MyScripts\Utils\Monitor Keyboard Hotkeys.ahk
    Return
}

TEXTNOW:
{
    Run, MyScripts\Utils\Web\TextNow.ahk "Minimize"
    Return
}
;************************************************************************
;
; The following hotkeys are globally available in any window 
; 
;************************************************************************
#IfWinActive
; these are here for documentation only they don't do anything. they "reserve" usage for windows
; #a::Return                   ; Window's view notifications history 
; #d::Return                   ; Window's show desktop toggle (minimize/restore all windows)
; #e::Return                   ; Window's File Explorer
; #h::Return                   ; Windows's Dictation
; #i::Return                   ; Window's Settings
; #l::Return                   ; Window's Lock Screen
; #m::Return                   ; Window's Minimize All Windows
; #w::Return                   ; Window's Ink Workspace  
; #=::Return                   ; Window's Magnifier
; Alt & Tab::Return            ; Window's switch application 
; Alt & Shift & Tab::Return    ; Window's switch application 
; Control & Tab::Return        ; Windows virtual desktop selector
; Control & LWin & Left::      ; Windows move to virtual desktop window on the left
; Control & LWin & Right::     ; Windows move to virtual desktop window on the right
^NumpadDot:: ; Runs MyHotkeys.ahk as administrator avoids User Access Control (UAC) prompt
^.::         ; Runs MyHotkeys.ahk as administrator avoids User Access Control (UAC) prompt
             ; for any program launched by MyHotkeys. Side effect is that all scripts launched will run as administrator.
{
	If WinActive("ahk_class Notepad\+\+")
		SendInput ^s    ; save current file 
    Run *RunAs "%A_AHKPath%" /restart "%AHK_ROOT_DIR%\MyScripts\MyHotkeys.ahk" %False%
    Return
}

^!+CapsLock::SetCapsLockState, On
~!+NumLock::	;	Start MouseKeys
	SetNumLockState, Off
	Return
#RButton::SendInput {LWin Down}{Tab}    ; virtual desktops

#Numpad0:: Run, "C:\Users\Mark\Desktop\Misc\AutoHotkey Scripts\MyScripts\Utils\Macro Recorder.ahk"

#+=::   ; Activate / Run Notepad++
{
    If WinExist("ahk_class Notepad\+\+ ahk_exe notepad\+\+\.exe")
        WinActivate
    Else
        Run, C:\Program Files (x86)\Notepad++\notepad++.exe
    Return
}

#+-::   ; Activate / Run SciTE4AutoHotkey
{
    If WinExist(".*SciTE4AutoHotkey.* ahk_class SciTEWindow ahk_exe SciTE\.exe")
        WinActivate
    Else
        Run, C:\Program Files\AutoHotkey\SciTE\SciTE.exe
    Return
}

^PgDn::     ; Run Browser - Next Numbered Page.ahk
{
    Run, MyScripts\Utils\Web\Browser - Next Numbered Page.ahk
    Return
}

#o::    ; open openload pairing page in browser and clicks the buttons
{
    Run, MyScripts\Utils\Web\Openload Pair.ahk
    Return
}

#h::    ; Doubleclick on mouse hover in selected windows
{
    Run, MyScripts\Utils\Hover Doubleclick.ahk
    Return
}   

^+Delete::
{
    KeyWait, Control
    KeyWait, Shift
    Run, C:\Users\Mark\Desktop\Misc\AutoHotkey Scripts\MyScripts\Utils\Kill Processes by Exe Name.ahk "AutoHotkey"
    Return
}

^!+c::
^+c::   ; either activates an existing browser window (excluding TextNow) or runs a new browser window
{
	new_window := (A_ThisHotkey = "^!+c")
	Run, MyScripts\Utils\Web\Activate Browser.ahk %new_window%
    Return
}

^!t::   ; run textnow with google contacts in a new maximized window
{
    Run, MyScripts\Utils\Web\TextNow.ahk
    Return
}

#t::    ; Toggles any window's always on top 
{
    Run, MyScripts\Utils\Set Any Window Always On Top.ahk
    Return
}   

#!g::   ; Close DbgView
#g::    ; Start's DbgView as administrator and avoids UAC prompt 
        ; - if MyHotkey was already started as admin
{
    WinGet, i_hwnd, ID, A
    active_win := "ahk_id " . i_hwnd
    dbgview_wintitle := "ahk_class dbgviewClass ahk_exe Dbgview.exe"
    If (A_ThisHotkey = "#!g")
    {
        WinClose, %dbgview_wintitle%
        Return
    }

    If !WinExist(dbgview_wintitle)
    {
        Run, "C:\Program Files (x86)\SysInternals\Dbgview.exe"
    }
    Else
    {
        WinGet, minmax_state, MinMax, %dbgview_wintitle%
        If (minmax_state >= 0)    ; 0 = neither min/maximized  or 1 = Maximized
            WinMinimize, %dbgview_wintitle%
        Else                      ; -1 = minimized
            WinRestore, %dbgview_wintitle%
    }
    WinWaitActive, %dbgview_wintitle%,,1
    ; accept filter window prompt
    If WinExist("DebugView Filter ahk_class #32770 ahk_exe Dbgview.exe")
        WinClose
    If WinActive(dbgview_wintitle)
    {
        WinMenuSelectItem, A,,Computer, Connect Local
        OutputDebug, DBGVIEWCLEAR
    }
    Run, MyScripts\Utils\DbgView Popup Menu.ahk     ; run this to reload new code if any
    ;
    SendInput {LWin Up}
    KeyWait, LWin, L T1
    BlockInput, On
    WinGet, extended_style, ExStyle, %dbgview_wintitle%
    If (extended_style & 0x8)  ; 0x8 is WS_EX_TOPMOST.    
        WinActivate, %active_win%
    Else
        WinActivate, %dbgview_wintitle%
    BlockInput, Off
    Return
}

#+0::    ; activate screensaver
{
    KeyWait LWin
    KeyWait Shift
    Sleep 2000  ; time needed to stop touching keyboard or mouse
    Run, C:\Users\Mark\Documents\Launch\Utils\Other\scrnsave.scr.lnk
    Return
}

~PrintScreen::  ; Captures entire screen and opens it up in IrfanView
{
    Run, C:\Program Files\IrfanView\i_view64.exe
    WinWait IrfanView
    If WinExist(IrfanView)
    {
        WinActivate
        SendInput !ep        ;edit paste 
    }   
    Return
}

~!PrintScreen::      ; Captures active window and opens it up in IrfanView
{
    Run, C:\Program Files\IrfanView\i_view64.exe
    WinWait IrfanView
    If WinExist(IrfanView)
    {
        WinActivate
        SendInput !ep        ;edit paste 
    }   
    Return
}

~#+s::      ; Captures selected portion of screen and opens it up in IrfanView
{
    ; Wait_For_Escape("Select capture with mouse then`n")
    Input, ov,,{Control}
    MsgBox % ErrorLevel
    Run, C:\Program Files\IrfanView\i_view64.exe
    WinWait, IrfanView ahk_class IrfanView
    If WinExist(IrfanView)
    {
        WinActivate
        SendInput !ep        ;edit paste 
    }  
    Return
}

LWin & WheelUp::    ; Scroll to Window's virtual desktop to the right
{
    SendInput {Control Down}{LWin Down}{Right}{Control Up}{LWin Up}
    Return
}

LWin & WheelDown::     ; Scroll to Window's virtual desktop to the left
{  
    SendInput {Control Down}{LWin Down}{Left}{Control Up}{LWin Up}
    Return
}

; Note: window's search hotkey is Win+s.
#!s::   ; Starts Seek script alternative to windows start search
{
    Run, plugins\seek.ahk
    Return
}
        
#!+w::   ; Runs Window Detective
{
    Run, C:\Program Files (x86)\Window Detective\Window Detective.exe
    Return
}

#!w::  ; Runs Visual Studio's Window Spy (changes default font)
{
       ; If MyHotkeys was started with Administrator privileges Spyxx will start without UAC prompt
    Run, C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\spyxx.exe
    While !WinActive("Microsoft Spy++")
    {
        WinActivate, Microsoft Spy++
        Sleep 500
    }
    WinMenuSelectItem, A,,Spy, Windows
    Sleep 500
    Gosub ^!+f  ; Changes font within MS Spy++
    Return
}

#^w::   ; Run WindowSpyToolTip.ahk
{
    Run, C:\Users\Mark\Desktop\Misc\AutoHotkey Scripts\MyScripts\Utils\WindowSpyToolTip.ahk
    Return
}

#+w::
#w::    ; Runs AutoHotkey's Window Spy 
{
    KeyWait LWin
    KeyWait Shift
    BlockInput, On
    save_coordmode := A_CoordModeMouse
    CoordMode, Mouse, Screen
    MouseGetPos, save_x, save_y
    SetTitleMatchMode 2
    ws_wintitle := "Window Spy ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe"
    Run, C:\Program Files\AutoHotkey\WindowSpy.ahk
    Sleep 1000
    ControlFocus, Button1, %ws_wintitle%
    Control, Check,,Button1, %ws_wintitle%   ; Follow Mouse
    ControlFocus, Button2, %ws_wintitle%
    Control, Check,,Button2, %ws_wintitle%   ; Slow TitleMatchMode
    WinGetPos, x, y, w, h, %ws_wintitle%
    If (A_ThisHotkey = "#w")
        MouseClickDrag, Right, x+180, y+15, 170,10  ; move top left
    Else If (A_ThisHotkey =  "#+w")
        MouseClickDrag, Right, x+180, y+15, A_ScreenWidth + 180 - w,10  ; move top right
    CoordMode, Mouse, %save_coordmode%
    BlockInput, Off
    Return
}
!+MButton::	  ; Reload "Launch folder"
+MButton::    ; Taskbar toolbar "Launch folder" replacement with popup menu for that directory
{                                                              
    Run, MyScripts\Utils\Create Menu From Directory - Launch Copy.ahk "C:\Users\Mark\Documents\Launch" %True% %False% %False% %True% 
    Return
}

#^d::    ; Create popup menu for any directory structure where cursor is pointing at in explorer 
         ; like programs or select a  directory path in a text file. Anything that will place
         ; a valid directory name in the clipboard if you would hit ^c on it.
{                                                                                           
    Run, MyScripts\Utils\Create Menu From Directory.ahk 
    Return
}

#!d::   ; Create popup menu for any directory showing file icons (See #^d for no icons version)
{                                                                                           
    Run, MyScripts\Utils\Create Menu From Directory.ahk "" "" "" "" %True%
    Return
}

#n::    ; Runs Window's Notepad 
{
    Run, Notepad.exe
    Return
}

#!n::   ; Close all untitled Notepad windows
{
    win_title := "Untitled - Notepad ahk_class Notepad"
        countx = 0
    While WinExist(win_title)
    {
        WinClose, %win_title%
        ; click don't save
        If WinExist("Notepad ahk_class #32770")
        {
            WinActivate
            WinWaitActive
            ; ControlClick, Button2, A
            SendInput n
            Sleep 10
        }
    }
    Return
}

#c::    ; Runs Window's Calc
{
    Run, Calc.exe
    Return
}
    
#!c::   ; Sorts a list of selected items (ie: filenames in explorer)
{
    Clipboard =
    SendInput ^c
    ClipWait 2
    If ErrorLevel
        Return
    Sort Clipboard
    MsgBox Ready to be pasted:`n%Clipboard%
    Return
}
    
#f::    ; Remapped to do nothing. Default is for it to run some program that gets an error all the time.
{
    Return
}
    
#!t::    ; Inserts a date and time in this kind of format: Jun-08-18 18:02
{
    SendInput % timestamp(2,2)
    Return
}

^!s::   ; Starts Search Everything
{
    ; If MyHotkeys was started with Administrator privileges Search Everything will start without UAC prompt
    Run, C:\Program Files\Everything\Everything.exe  -matchpath -sort "path" -sort-ascending 
    Return
}

^!+s::   ; Starts Search Everything for AutoHotkey type files
{
    ; If MyHotkeys was started with Administrator privileges Search Everything will start without UAC prompt
    Run, C:\Program Files\Everything\Everything.exe  -search "file:*.ahk|*.txt <Autohotkey Scripts> <!plugins> <!tetris>" -matchpath -sort "date modified" -sort-descending 
	WinWaitActive, ahk_class EVERYTHING ahk_exe Everything.exe
    SendInput {Home}{Right 5}
    Return
}

^!+x::  ; Clears Dbgview window without having to go there
{
    dbgview_win := "ahk_class dbgviewClass ahk_exe Dbgview.exe"
    If WinExist(dbgview_win)
        WinMenuSelectItem, %dbgview_win%,,Edit,Clear Display
    Return 
}

^!+a::  ; Toggle Dbgview window's AlwaysOnTop option without having to go there
{
    dbgview_win := "ahk_class dbgviewClass ahk_exe Dbgview.exe"
    If WinExist(dbgview_win)
        WinMenuSelectItem, %dbgview_win%,,Options,Always On Top
    Return 
}
    
CapsLock & F1::    ; Opens AutoHotkey Help file searching index for currently selected word available to any program as opposed to F1 below  
{
    Run, MyScripts\Utils\AHK Context Help File.ahk
    Return
}

#F1::  ; Hotkey Help - #F1 to active it.
{
    Run, plugins\Hotkey Help (by Fanatic Guru).ahk     
    Return
}
    
#F3::   ; Start TextCrawler
{
    Run, "C:\Program Files (x86)\TextCrawler Free\TextCrawler.exe"
    Return
}
    
RAlt & '::      ; Display basic active window info  
{
    WinGetTitle, i_title, A
    WinGetClass, i_class, A
    WinGet, i_procname, ProcessName, A
    WinGet, i_hwnd, ID, A
    i_class := "ahk_class " . i_class
    i_procname := "ahk_exe " . i_procname
    i_hwnd := "ahk_id " . i_hwnd
    active_win := i_title A_Space i_class A_Space i_procname
    WinActivate, %active_win%
    ControlGetFocus, got_focus, A
    WinGet, control_list, ControlList, A
    Sort control_list

    output_debug("")    ; starts dbgview if not already started
    Sleep 10
    OutputDebug, -------------------
    OutputDebug, % "title: " i_title
    OutputDebug, % "class: " i_class
    OutputDebug, % "proc : " i_procname
    OutputDebug, % "hwnd : " i_hwnd 
    OutputDebug, % "focus: " got_focus
    OutputDebug, -------------------
    Loop, Parse, control_list, "`r`n"
    {
        ControlGet, is_visible, Visible,, %A_LoopField%, A
        If is_visible
            OutputDebug % A_LoopField
    }
    Return
}

CapsLock & F10::   ; Adds selected words to lib\AHK_word_list.ahk
{
    Run, MyScripts\Utils\Add Selection To AHK Word List.ahk
    Return
}   
;************************************************************************
#If WinActive("Age of Empires II Expansion ahk_class Age of Empires II Expansion")
LWin::Return	; disable winkey in AOE
;************************************************************************
;
; Hotkeys available for MPV (NHLGames.exe default media player)
; 
;************************************************************************
#If WinActive("ahk_class mpv ahk_exe mpv.exe")
{
    LButton:: Click, Left
    Rbutton:: Click, Right
    WheelUp:: SendInput {Right 3}           ; seek forward  15 seconds
    WheelDown:: SendInput {Left 3}          ; seek backward 15 seconds
    LButton & WheelUp:: SendInput {Right}   ; seek forward  5 seconds
    LButton & WheelDown:: SendInput {Left}  ; seek backward 5 seconds
    RButton & WheelUp:: SendInput 0         ; volume up'
    RButton & WheelDown:: SendInput 9       ; volume down
    MButton:: SendInput O                   ; toggle show progress 
}
Return
;************************************************************************
;
; Make these hotkeys available ONLY when dealing with Youtube
; type video players  in Chrome
; 
;************************************************************************
#IfWinActive

^!+RButton::
^!+y::   ; Runs mouse hotkeys for embedded videoplayers with similar keyboard controls (ie youtube)
{
    win_title1 = ".*YouTube - Google Chrome ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe"
    win_title2 = ".*Watchseries - Google Chrome ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe"
    win_title3 = ".*dailymotion - Google Chrome ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe"
 
    Run, "C:\Users\Mark\Desktop\Misc\AutoHotkey Scripts\MyScripts\Utils\Web\Youtube - hotkeys.ahk" %win_title1% %win_title2% %win_title3%
    Return
}

^!y::
{
    Run, "C:\Users\Mark\Desktop\Misc\AutoHotkey Scripts\MyScripts\Utils\Web\Youtube Keys.ahk"
    Return
}
;************************************************************************
;
; Make these hotkeys available ONLY when dealing with Windows 10 Settings Pages
; 
;************************************************************************
#If WinActive("Settings ahk_class ApplicationFrameWindow ahk_exe ApplicationFrameHost.exe")
WheelUp::SendInput {PgUp}
WheelDown::SendInput {PgDn}
;************************************************************************
;
; Make these hotkeys available ONLY when dealing with Windows Magnifier (#=)
; 
;************************************************************************
#If WinExist("ahk_exe Magnify.exe")
#+=::Send #{Escape}   ; exit magnifier
;************************************************************************
;
; Make these hotkeys available Globally except in Chrome browser
; 
;************************************************************************
#If Not WinActive("ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe")
^h::    ; Searches MyHotkeys.ahk for desired hotkey
{
    Run, MyScripts\Utils\Find Hotkey.ahk
    Return
}
;************************************************************************
;
; Make these hotkeys available ONLY when dealing with WinMerge
; 
;************************************************************************
#If WinActive("ahk_class WinMergeWindowClassW ahk_exe WinMergeU.exe")
Shift & Tab::   ; WinMerge Change Pane
Tab::           ; WinMerge Change Pane
{
    SendInput {F6}
    Return
}

^Delete::   ; WinMerge Delete Line
{
    SendInput {Home}+{Down}{Delete}
    Return
}
;************************************************************************
;
; Make these hotkeys available ONLY when dealing with AutoHotkey Window Spy
; 
;************************************************************************
#If WinExist("Window Spy ahk_exe AutoHotkey.exe")
^!c::   ; Copies WinTitle info from AutoHotkey Window Spy to the clipboard
{
    ControlGetText, the_text,Edit1, Window Spy ahk_exe AutoHotkey.exe   
    Clipboard := StrReplace(the_text, "`r`nahk_exe", " ahk_exe")
    MsgBox, 64,,Window Spy info saved on clipboard.`n`n%clipboard%, 1
    Return
}

^!+c::   ; Copies WinTitle and ClassNN info from AutoHotkey Window Spy to the clipboard
{
    ControlGetText, the_text, Edit1, Window Spy ahk_exe AutoHotkey.exe   
    Clipboard := StrReplace(the_text, "`r`nahk_exe", " ahk_exe")
    ControlGetText, the_text, Edit3, Window Spy    
    Clipboard .= "`r`n`r`n" the_text
    MsgBox, 64,,Window Spy info saved on clipboard.`n`n%clipboard%, 1
    Return
}
;************************************************************************
;
; Make these hotkeys available ONLY within ConsoleWindowClass type windows
; ie cmd.exe. Exclude Powershell which scrolls properly without this.
; 
;************************************************************************
#If WinActive("ahk_class ConsoleWindowClass") and Not WinActive("ahk_class ConsoleWindowClass ahk_exe powershell.exe")

WheelUp::
PgUp::
{
    SendInput {Control Down}{Up 10}{Control Up}
    Return
}

WheelDown::
PgDn::
{
    SendInput {Control Down}{Down 10}{Control Up}
    Return
}
;************************************************************************
;
; Make these hotkeys available ONLY within Expresso
; 
;************************************************************************
#If WinActive("ahk_class WindowsForms10.Window.8.app.0.141b42a_r6_ad1 ahk_exe Expresso.exe")
^!x::    ; Exports current RegEx results to the desktop
{
    ; WinMenuSelectItem, A,,Tools,Export Results,Matched Text Only ...
    SendInput {LAlt Down}txm{LAlt Up}
    Sleep 1000
    SendInput C:\Users\Mark\Desktop\Expresso Results.txt
    Return
}
;************************************************************************
;
; Make these hotkeys available ONLY within Window Detective
; 
;************************************************************************
#If WinActive("Window Detective ahk_class Qt5QWindowIcon")
~f::    ; flash selected window
{
    SendInput {AppsKey}f{Enter}
    Return
}

~p::    ; show properties for selected window
{
    SendInput {AppsKey}p{Enter}
    Return
}
;************************************************************************
;
; Make these hotkeys available ONLY within Microsoft Spy++
; 
;************************************************************************
#If WinActive("Microsoft Spy++")
~f::    ; Flashes selected window or control (highlight)
{
    SendInput {AppsKey}h
    Return
}
    
^f::    ; Opens "find window" within list of windows in Spy++ (instead of find window locate a window dialog) 
{
    SendInput {LControl}{Home}    
    SendInput !{F3}
    Sleep 200
    SendInput {Delete}{Tab}{Delete}{Tab}{Delete}{LAlt Down}w{LAlt Up}{Shift Down}{Tab 2}{Shift Up}
    Return
}

^g::    ; Find Next
{
    SendInput {F3}
    Return
}

^!+f::  ; Change font
{
    WinMenuSelectItem,A,,View,Font
    WinWaitActive,Font ahk_class #32770, 
    If ErrorLevel = 0 
        SendEvent Consolas{Tab 2}16{Shift Down}{Tab 2}{Shift Up}{Enter}
    Return
}
    
^!+x::  ; Clear messages screen
{
    WinMenuSelectItem,A,,Messages,Clear Log
    Return
}
  
^m::    ; Go to Logging Options / wm_command
{
    WinMenuSelectItem, A,, &Messages, Logging &Options
    SendInput +{Tab}{Right}!c{Tab}w{down 19}    ; scroll down to wm_command
    Return
}  
#If WinActive("Find Window ahk_class #32770")
^+f::    ; This will synchronize when "Find Window" (Alt-f3) with the Spy++ listing
{
    SendInput {Enter}
    SendInput {Shift Down}{Tab 3}{Shift Up}{Enter}{Shift Down}{Tab 2}{Shift Up} 
    Return
}
;************************************************************************
;
; Make these hotkeys available ONLY within TextCrawler 3
; 
;************************************************************************
#If WinActive("TextCrawler 3 ahk_class WindowsForms10.Window.8.app.0.378734a")
^f::    ; Set focus on the "find" textbox
{
	ControlGet, is_visible, Visible,, Edit4, A
	If is_visible
		ControlClick, Edit4, ahk_class WindowsForms10.Window.8.app.0.378734a	; standard find
	Else
		ControlClick, Edit7, ahk_class WindowsForms10.Window.8.app.0.378734a	; regex find
    Return
}
;************************************************************************
;
; Make these hotkeys available to ZeroBrane Studio (LUA IDE)
; Clicks assume window is maximized
; 
;************************************************************************
#If WinActive("ZeroBrane Studio.* ahk_class wxWindowNR ahk_exe zbstudio.exe")
!n::	; click next
{
	WinMaximize
	Sleep 100
	Click, Left, 520, 117
	Return
}

F8::	; Activate/Switch between main window and active 'output/local console/markers' window
{
	WinMaximize
	Sleep 100
	save_coordmode_mouse := A_CoordModeMouse
	CoordMode, Mouse, Screen
	If (A_CaretY <= 745)
		Click, Left, 410, 930
	Else If (A_CaretY > 745)
		Click, Left, 410, 440
	CoordMode, Mouse, %save_coordmode_mouse%
	Return
}
;************************************************************************
;
; Make these hotkeys available to Notepad++ only
; 
;************************************************************************
#If WinActive("ahk_class Notepad\+\+") or WinActive("Find ahk_class #32770")
^+d::	; debug current file in SciTE4AutoHotkey
{
	script_fullpath := get_filepath_from_wintitle()
	oscite := create_scite_comobj()
	If (oscite = False)
		Return
	;
	oscite.DebugFile(script_fullpath)
	Sleep 10
	move_variable_list()
	Return
}

Alt & WheelUp::         ; chooses the next opened file in tab bar to the right
{
    WinMenuSelectItem,A,, View, Tab, Next Tab
    Return
}

Alt & WheelDown::       ; chooses the next opened file in tab bar the left
{
    WinMenuSelectItem,A,, View, Tab, Previous Tab
    Return
}

Control & WheelUp::     ; Move file tab forward in tab bar
{
    WinMenuSelectItem,A,, View, Tab, Move Tab Forward
    Return
}

Control & WheelDown::   ; Move file tab backward in tab bar
{
    WinMenuSelectItem,A,, View, Tab, Move Tab Backward 
    Return
}

F7::    ; Toggle Search Results Window
{
    Run, MyScripts\NPP\Misc\Toggle Search Results Window.ahk
    Return
}

^!F7::  ; Creates Shortcut Mapper List from scratch (ie the most updated status of shortcuts) and proceeds to Finder program
{
    Run, MyScripts\NPP\Shortcut Mapper\Get List.ahk
    Return
}

^F7::   ; Opens the last Shortcut Mapper List created and proceeds to Find routine. This is faster than creating from scratch but list may be outdated.
{
    Run, MyScripts\NPP\Shortcut Mapper\Finder.ahk
    Return
}

^w::    ; Close window. Overrides extend selection right in NPP.
{
    SendInput ^{F4}
    Return
}

^f::   ; Creates an Access Key in the Edit dialog to "Find All In Current Document"
{
    Run, MyScripts\NPP\Misc\Find All In Current Document.ahk
    Return
}

^+f::   ; Same as ^f but executes "Find All in Document" on selected text 
{
    Run, MyScripts\NPP\Misc\Find All In Current Document.ahk "DoIt"
    Return
}

^!+F8:: Run, "MyScripts\NPP\Misc\Rotate View.ahk"

!n::    ; open new ahk file in root dir
{
    KeyWait Alt
    Run, "MyScripts\NPP\Misc\Create New AHK Scratch File.ahk"
    Return
}

^q::    ; Toggles auto-completion
{
    Run,  MyScripts\NPP\Misc\Toggle Preferences Setting.ahk "Toggle" "Button141" "Autocomplete"
    Return
}

^!q::    ; Toggles Doc Switcher
{
    Run,  MyScripts\NPP\Misc\Toggle Preferences Setting.ahk "Toggle" "Button9" "Doc Switcher"
    Return
}

^!+n::  ; Save Session using current script as the session name.
{
    WinGetTitle, current_script, A
    SplitPath, current_script, of, od, oe, session_name, od
    WinMenuSelectItem, A,, File, Save Session
    Sleep 1000
    SendInput %session_name%{Tab}
    SendInput C:\Users\Mark\Google Drive\Misc Backups\Notepad
    ; for some reason SendInput translates ++ to a pipe | symbol.
    SendRaw   ++
    SendInput \backup\%session_name%.npp_savedsession
    Return
}

+BackSpace::    ; Remaps to do a regular backspace instead of inserting an ascii code BS.
{
    SendInput {BackSpace}
    Return
}

!F2::   ; Creates a file with only alt+0 folded lines for the current file
{
    Run, MyScripts\NPP\Misc\Copy Folded Visible Lines Only.ahk
    Return
}
    
F5::	; Run, F5 - Save and Run Current Script.ahk
{
	Run, F5 - Save and Run Current Script.ahk
	Return
}
; F5::
; {
    ; WinMenuSelectItem, A,, Plugins, DBGp, Stop
    ; WinMenuSelectItem, A,,File,Save
    ; Sleep 10
    ; fname := get_filepath_from_wintitle()
    ; OutputDebug, %A_AhkPath% "%fname%"
    ; Run, %A_AhkPath% "%fname%"
    ; Return
    ; ; outputdebug "here"
    ; ; Run, MyScripts\Utils\F5 - Run Current AHK Script(does not work from myhotkeys anymore).ahk
    ; ; Return
; }

F12::   ; Toggle edit/find all in documents results window
{
    Run, MyScripts\NPP\Misc\Close All Windows.ahk
    Return
}

;************************************************************************
;
; Make these hotkeys available to Notepad++ or Notepad
;
; Note: these probably work in most text controls, editors with standard keyboard shortcuts
; 
;************************************************************************
#If WinActive("ahk_class Notepad\+\+") or WinActive("ahk_class Notepad")


F1::    ; Opens AutoHotkey Help file searching index for currently selected word   
{
    Run, MyScripts\Utils\AHK Context Help File.ahk
    Return
}

F2::    ; Remaps keyboard so that typing in SEND commands is easier
{
    Run, MyScripts\Utils\Remap Keyboard for SEND.ahk
    Return
}

 
^!+i::  ; Debugging tool useful for blocking keyboard input and stopping console from closing
{
    SendInput {End}{Enter}Wait_For_Escape() `; debugging tool - defined in utils.ahk
    Return
}

^!+5::  ; Wrap percent signs %% around current word
{
    SendInput ^{Left}`%^!+{Right}`%
    Return
}

^[::    ; Wrap Braces {} around current line
{
    SendInput {Home}+{Tab}
    SendRaw {
    SendInput {Enter}{Tab}{End}{Enter}+{Tab}
    SendRaw }
    SendInput {Up}^{Right}
    Return
}    

^!+[::  ; Wrap braces {} around current word
{
    SendInput ^{Left}
    SendRaw {
    SendInput ^!+{Right}
    SendRaw }
    Return
}

^!+'::  ; Wrap double quotes "" around current word
{
    SendInput ^{Left}`"^!+{Right}`"
    Return
}
    
Control & Insert::    ; Select entire line including any leading whitespace  
{
    SendInput {LAlt Down}{Home}{Shift Down}{End}{LAlt Up}{Shift Up}
    Return
}
   
^+r::   ; Recent files menu
{
    SendInput !fr{Down 3}
    Return
}

CapsLock & a::  ; Replaces the the selected character with corresponding chr(<x>) phrase. 
                ; ie: select a semicolon hit the hotkey and it will be replaced with chr(59)
{
    OutputDebug, % "A_ThisHotkey: " A_ThisHotkey " - A_ScriptName: " A_ScriptName 
    SetCapsLockState, AlwaysOff
    char := check_selection_copy(1,0,0)
    If (char == "")
    {
        MsgBox, 48,, % "Selection didn't meet parameter requirements.", 10
        Return
    }
    OutputDebug, % "char: |" char "|"
    If char
    {
        saved_clipboard := ClipboardAll
        Clipboard := char
        ClipWait, 1
        SendInput % "chr(" Asc(char) ")"
        SendInput {Tab} 
        SendInput % Chr(59)
        SendInput {Space} is ASCII: ^v
        Sleep 500
        Clipboard := saved_clipboard
    }
    Return
}

^Numpad9::    ; Runs active script as administrator
{ 
	If WinActive("ahk_class Notepad\+\+")
		SendInput ^s  
    script_fullpath := get_filepath_from_wintitle()	
    Run *RunAs "%A_AHKPath%" /restart "%script_fullpath%"
    Return
}

^l::    ; Documents all procedure calls in lib directory
{
    RunWait, MyScripts\Utils\Lib Procedures Documenter.ahk
    Sleep 500
    Run, MyScripts\NPP\Misc\Find All In Current Document.ahk    
    Return
}


^!+F1::     ; AutoHotkey RegEx Quick Reference
{
    Run, https://www.autohotkey.com/docs/misc/RegEx-QuickRef.htm
    Return
}
;************************************************************************
;
; Hotkeys that are the same for Notepad++ and SciTE4AutoHotkey
;
;************************************************************************
#If WinActive("ahk_class SciTEWindow") or WinActive("ahk_class Notepad\+\+")

CapsLock & F2::     ; Beautify current AHK Script
{
    WinMenuSelectItem, A,,File,Save
    Run, MyScripts\Utils\Beautify AHK.ahk
    Return
}

RAlt & s::	; Open current script in SciTE4AutoHotkey or Notepad++
{
	script_fullpath := get_filepath_from_wintitle()
	If WinActive("ahk_class Notepad\+\+") 
		Run, "C:\Program Files\AutoHotkey\SciTE\SciTE.exe" "%script_fullpath%"
	Else If WinActive("ahk_class SciTEWindow")
		Run, "C:\Program Files (x86)\Notepad++\notepad++.exe" "%script_fullpath%"
	Return
}

^!+0::  ; Wrap Expressions In Parentheses
{
    Run, MyScripts\Utils\Wrap Expressions In Parentheses.ahk
    Return
}

^m::    ; Copies the current word and pastes it to MsgBox % statement on a new line.
{
    saved_clipboard := ClipboardAll
    Clipboard := ""
    SendMode Input
    SendInput % SEND_COPYWORD
    ClipWait, 5
    SendInput {End}{Enter}MsgBox{Space}`%{Space}
    SendInput % SEND_WORD_NAME_VALUE_NO_DELIM
    SendInput {Home}
    Sleep 200
    Clipboard := saved_clipboard
    Return
}

!+o::   ; output_debug("*** time ***" ) debugging statement on a new line.
{
    SendInput {End}{Enter}OutputDebug, `% `"*** `" . get_time() . ":" . A_MSec . `" ***`"{Home}
    Return
}


^!o::   ; Copies the current word and pastes it to OutputDebug statement on a new line.
{
    the_word := RTrim(select_and_copy_word())
    SendInput {End}{Enter}OutputDebug, `% 
    SendRaw %the_word%
    SendInput {Home}
    Return
}
    
^!+o::  ; Copies the current word and inserts into: OutputDebug, % "theword: " theword - statement on a new line.
{
    the_word := RTrim(select_and_copy_word())
    send_cmd := " % " . Chr(34) . the_word . ": "  . Chr(34) . A_Space . the_word
    SendInput {End}{Enter}OutputDebug, 
    SendRaw %send_cmd%
    SendInput {Home}   
    Return
}

^!+t::  ; Copies the current word and inserts it into ttip("theword: " theword, 1500) on a new line.
{
    the_word := RTrim(select_and_copy_word())
    send_cmd = "``r``n%the_word%: " %the_word% " ``r``n ",,500,500) 
    SendInput {End}{Enter}ttip( 
    SendRaw %send_cmd%
    SendInput {Home}   
    Return
}

^!w::	; Toggle Wrap
{
	WinMenuSelectItem, A,, Options, Wrap
	Return
}
;************************************************************************
;
; Hotkeys that are for SciTE4AutoHotkey only 
;
;************************************************************************
#Include MyScripts\SciTE\lib\scite4ahk_hotkeys.ahk
