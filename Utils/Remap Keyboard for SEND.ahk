;
;
; Remap keyboard & mouse to type SEND commands more easily
;
;
#Include C:\Users\Mark\Desktop\Misc\AutoHotkey Scripts
#Include lib\constants.ahk
#Include lib\utils.ahk
#SingleInstance Force
#NoEnv
SendMode Input
SetTitleMatchMode 2
SetWorkingDir %AHK_ROOT_DIR%
Menu, Tray, Icon, ..\resources\32x32\Signs\burn.png

Global tt_line1_text = "^C = Exit   ^T = Toggle ToolTip"
Global tt_line1 := "`n   " . tt_line1_text . "   `n`t"
ToolTip, `n REMAP: ON  `n`t, get_window("w") - 75, 0, 2

; the sequence of the following tooltip and suspend commands is important for things to work as expected. Don't move the code around.
tooltip_on := True
SendInput ^t



^c::
    ExitApp

^t::
    If tooltip_on
        ToolTip, %tt_line1%, get_window("w")/2, 0, 1
    Else
        ToolTip,,1
    tooltip_on := !tooltip_on
    Return


type_in(p_keystring)
{
    Clipboard := p_keystring
    SendInput ^v
    Return
}

get_window(p_info_type:="w",p_win_title:="A")
{
    if p_info_type in [x,X,y,Y,w,W,h,H]
        WinGetPos, x, y, w, h, A
    else
        p_info_type := ""
    result := %p_info_type%
    return result
}

REMAPKEYS:
#If WinActive("ahk_class Notepad++ ahk_exe notepad++.exe") Or WinActive("ahk_class Notepad ahk_exe Notepad.exe")

Alt::type_in("{Alt}")
Alt & Up::type_in("{Alt Up}")
Alt & Down::type_in("{Alt Down}")
AppsKey::type_in("{AppsKey}")
AppsKey & Up::type_in("{AppsKey Up}")
AppsKey & Down::type_in("{AppsKey Down}")
BackSpace::type_in("{BackSpace}")
BackSpace & Up::type_in("{BackSpace Up}")
BackSpace & Down::type_in("{BackSpace Down}")
Break::type_in("{Break}")
Break & Up::type_in("{Break Up}")
Break & Down::type_in("{Break Down}")
Browser_Back::type_in("{Browser_Back}")
Browser_Back & Up::type_in("{Browser_Back Up}")
Browser_Back & Down::type_in("{Browser_Back Down}")
Browser_Favorites::type_in("{Browser_Favorites}")
Browser_Favorites & Up::type_in("{Browser_Favorites Up}")
Browser_Favorites & Down::type_in("{Browser_Favorites Down}")
Browser_Forward::type_in("{Browser_Forward}")
Browser_Forward & Up::type_in("{Browser_Forward Up}")
Browser_Forward & Down::type_in("{Browser_Forward Down}")
Browser_Home::type_in("{Browser_Home}")
Browser_Home & Up::type_in("{Browser_Home Up}")
Browser_Home & Down::type_in("{Browser_Home Down}")
Browser_Refresh::type_in("{Browser_Refresh}")
Browser_Refresh & Up::type_in("{Browser_Refresh Up}")
Browser_Refresh & Down::type_in("{Browser_Refresh Down}")
Browser_Search::type_in("{Browser_Search}")
Browser_Search & Up::type_in("{Browser_Search Up}")
Browser_Search & Down::type_in("{Browser_Search Down}")
Browser_Stop::type_in("{Browser_Stop}")
Browser_Stop & Up::type_in("{Browser_Stop Up}")
Browser_Stop & Down::type_in("{Browser_Stop Down}")
CapsLock::type_in("{CapsLock}")
CapsLock & Up::type_in("{CapsLock Up}")
CapsLock & Down::type_in("{CapsLock Down}")
; Control::type_in("{Control}")
; Control & Up::type_in("{Control Up}")
; Control & Down::type_in("{Control Down}")
CtrlBreak::type_in("{CtrlBreak}")
CtrlBreak & Up::type_in("{CtrlBreak Up}")
CtrlBreak & Down::type_in("{CtrlBreak Down}")
Delete::type_in("{Delete}")
Delete & Up::type_in("{Delete Up}")
Delete & Down::type_in("{Delete Down}")
Down::type_in("{Down}")
; Down & Up::type_in("{Down Up}")
; Down & Down::type_in("{Down Down}")
End::type_in("{End}")
End & Up::type_in("{End Up}")
End & Down::type_in("{End Down}")
Enter::type_in("{Enter}")
Enter & Up::type_in("{Enter Up}")
Enter & Down::type_in("{Enter Down}")
Escape::type_in("{Escape}")
Escape & Up::type_in("{Escape Up}")
Escape & Down::type_in("{Escape Down}")
F1::type_in("{F1}")
F1 & Up::type_in("{F1 Up}")
F1 & Down::type_in("{F1 Down}")
F10::type_in("{F10}")
F10 & Up::type_in("{F10 Up}")
F10 & Down::type_in("{F10 Down}")
F11::type_in("{F11}")
F11 & Up::type_in("{F11 Up}")
F11 & Down::type_in("{F11 Down}")
F12::type_in("{F12}")
F12 & Up::type_in("{F12 Up}")
F12 & Down::type_in("{F12 Down}")
F13::type_in("{F13}")
F13 & Up::type_in("{F13 Up}")
F13 & Down::type_in("{F13 Down}")
F14::type_in("{F14}")
F14 & Up::type_in("{F14 Up}")
F14 & Down::type_in("{F14 Down}")
F15::type_in("{F15}")
F15 & Up::type_in("{F15 Up}")
F15 & Down::type_in("{F15 Down}")
F16::type_in("{F16}")
F16 & Up::type_in("{F16 Up}")
F16 & Down::type_in("{F16 Down}")
F17::type_in("{F17}")
F17 & Up::type_in("{F17 Up}")
F17 & Down::type_in("{F17 Down}")
F18::type_in("{F18}")
F18 & Up::type_in("{F18 Up}")
F18 & Down::type_in("{F18 Down}")
F19::type_in("{F19}")
F19 & Up::type_in("{F19 Up}")
F19 & Down::type_in("{F19 Down}")
F2::type_in("{F2}")
F2 & Up::type_in("{F2 Up}")
F2 & Down::type_in("{F2 Down}")
F20::type_in("{F20}")
F20 & Up::type_in("{F20 Up}")
F20 & Down::type_in("{F20 Down}")
F21::type_in("{F21}")
F21 & Up::type_in("{F21 Up}")
F21 & Down::type_in("{F21 Down}")
F22::type_in("{F22}")
F22 & Up::type_in("{F22 Up}")
F22 & Down::type_in("{F22 Down}")
F23::type_in("{F23}")
F23 & Up::type_in("{F23 Up}")
F23 & Down::type_in("{F23 Down}")
F24::type_in("{F24}")
F24 & Up::type_in("{F24 Up}")
F24 & Down::type_in("{F24 Down}")
F3::type_in("{F3}")
F3 & Up::type_in("{F3 Up}")
F3 & Down::type_in("{F3 Down}")
F4::type_in("{F4}")
F4 & Up::type_in("{F4 Up}")
F4 & Down::type_in("{F4 Down}")
F5::type_in("{F5}")
F5 & Up::type_in("{F5 Up}")
F5 & Down::type_in("{F5 Down}")
F6::type_in("{F6}")
F6 & Up::type_in("{F6 Up}")
F6 & Down::type_in("{F6 Down}")
F7::type_in("{F7}")
F7 & Up::type_in("{F7 Up}")
F7 & Down::type_in("{F7 Down}")
F8::type_in("{F8}")
F8 & Up::type_in("{F8 Up}")
F8 & Down::type_in("{F8 Down}")
F9::type_in("{F9}")
F9 & Up::type_in("{F9 Up}")
F9 & Down::type_in("{F9 Down}")
Help::type_in("{Help}")
Help & Up::type_in("{Help Up}")
Help & Down::type_in("{Help Down}")
Home::type_in("{Home}")
Home & Up::type_in("{Home Up}")
Home & Down::type_in("{Home Down}")
Insert::type_in("{Insert}")
Insert & Up::type_in("{Insert Up}")
Insert & Down::type_in("{Insert Down}")
LAlt::type_in("{LAlt}")
LAlt & Up::type_in("{LAlt Up}")
LAlt & Down::type_in("{LAlt Down}")
Launch_App1::type_in("{Launch_App1}")
Launch_App1 & Up::type_in("{Launch_App1 Up}")
Launch_App1 & Down::type_in("{Launch_App1 Down}")
Launch_App2::type_in("{Launch_App2}")
Launch_App2 & Up::type_in("{Launch_App2 Up}")
Launch_App2 & Down::type_in("{Launch_App2 Down}")
Launch_Mail::type_in("{Launch_Mail}")
Launch_Mail & Up::type_in("{Launch_Mail Up}")
Launch_Mail & Down::type_in("{Launch_Mail Down}")
Launch_Media::type_in("{Launch_Media}")
Launch_Media & Up::type_in("{Launch_Media Up}")
Launch_Media & Down::type_in("{Launch_Media Down}")
LButton::type_in("{LButton}")
LButton & Up::type_in("{LButton Up}")
LButton & Down::type_in("{LButton Down}")
LControl::type_in("{LControl}")
LControl & Up::type_in("{LControl Up}")
LControl & Down::type_in("{LControl Down}")
Left::type_in("{Left}")
Left & Up::type_in("{Left Up}")
Left & Down::type_in("{Left Down}")
LShift::type_in("{LShift}")
LShift & Up::type_in("{LShift Up}")
LShift & Down::type_in("{LShift Down}")
LWin::type_in("{LWin}")
LWin & Up::type_in("{LWin Up}")
LWin & Down::type_in("{LWin Down}")
MButton::type_in("{MButton}")
MButton & Up::type_in("{MButton Up}")
MButton & Down::type_in("{MButton Down}")
Media_Next::type_in("{Media_Next}")
Media_Next & Up::type_in("{Media_Next Up}")
Media_Next & Down::type_in("{Media_Next Down}")
Media_Play_Pause::type_in("{Media_Play_Pause}")
Media_Play_Pause & Up::type_in("{Media_Play_Pause Up}")
Media_Play_Pause & Down::type_in("{Media_Play_Pause Down}")
Media_Prev::type_in("{Media_Prev}")
Media_Prev & Up::type_in("{Media_Prev Up}")
Media_Prev & Down::type_in("{Media_Prev Down}")
Media_Stop::type_in("{Media_Stop}")
Media_Stop & Up::type_in("{Media_Stop Up}")
Media_Stop & Down::type_in("{Media_Stop Down}")
NumLock::type_in("{NumLock}")
NumLock & Up::type_in("{NumLock Up}")
NumLock & Down::type_in("{NumLock Down}")
Numpad0::type_in("{Numpad0}")
Numpad0 & Up::type_in("{Numpad0 Up}")
Numpad0 & Down::type_in("{Numpad0 Down}")
Numpad1::type_in("{Numpad1}")
Numpad1 & Up::type_in("{Numpad1 Up}")
Numpad1 & Down::type_in("{Numpad1 Down}")
Numpad2::type_in("{Numpad2}")
Numpad2 & Up::type_in("{Numpad2 Up}")
Numpad2 & Down::type_in("{Numpad2 Down}")
Numpad3::type_in("{Numpad3}")
Numpad3 & Up::type_in("{Numpad3 Up}")
Numpad3 & Down::type_in("{Numpad3 Down}")
Numpad4::type_in("{Numpad4}")
Numpad4 & Up::type_in("{Numpad4 Up}")
Numpad4 & Down::type_in("{Numpad4 Down}")
Numpad5::type_in("{Numpad5}")
Numpad5 & Up::type_in("{Numpad5 Up}")
Numpad5 & Down::type_in("{Numpad5 Down}")
Numpad6::type_in("{Numpad6}")
Numpad6 & Up::type_in("{Numpad6 Up}")
Numpad6 & Down::type_in("{Numpad6 Down}")
Numpad7::type_in("{Numpad7}")
Numpad7 & Up::type_in("{Numpad7 Up}")
Numpad7 & Down::type_in("{Numpad7 Down}")
Numpad8::type_in("{Numpad8}")
Numpad8 & Up::type_in("{Numpad8 Up}")
Numpad8 & Down::type_in("{Numpad8 Down}")
Numpad9::type_in("{Numpad9}")
Numpad9 & Up::type_in("{Numpad9 Up}")
Numpad9 & Down::type_in("{Numpad9 Down}")
NumpadAdd::type_in("{NumpadAdd}")
NumpadAdd & Up::type_in("{NumpadAdd Up}")
NumpadAdd & Down::type_in("{NumpadAdd Down}")
NumpadClear::type_in("{NumpadClear}")
NumpadClear & Up::type_in("{NumpadClear Up}")
NumpadClear & Down::type_in("{NumpadClear Down}")
NumpadDel::type_in("{NumpadDel}")
NumpadDel & Up::type_in("{NumpadDel Up}")
NumpadDel & Down::type_in("{NumpadDel Down}")
NumpadDiv::type_in("{NumpadDiv}")
NumpadDiv & Up::type_in("{NumpadDiv Up}")
NumpadDiv & Down::type_in("{NumpadDiv Down}")
NumpadDot::type_in("{NumpadDot}")
NumpadDot & Up::type_in("{NumpadDot Up}")
NumpadDot & Down::type_in("{NumpadDot Down}")
NumpadDown::type_in("{NumpadDown}")
NumpadDown & Up::type_in("{NumpadDown Up}")
NumpadDown & Down::type_in("{NumpadDown Down}")
NumpadEnd::type_in("{NumpadEnd}")
NumpadEnd & Up::type_in("{NumpadEnd Up}")
NumpadEnd & Down::type_in("{NumpadEnd Down}")
NumpadEnter::type_in("{NumpadEnter}")
NumpadEnter & Up::type_in("{NumpadEnter Up}")
NumpadEnter & Down::type_in("{NumpadEnter Down}")
NumpadHome::type_in("{NumpadHome}")
NumpadHome & Up::type_in("{NumpadHome Up}")
NumpadHome & Down::type_in("{NumpadHome Down}")
NumpadIns::type_in("{NumpadIns}")
NumpadIns & Up::type_in("{NumpadIns Up}")
NumpadIns & Down::type_in("{NumpadIns Down}")
NumpadLeft::type_in("{NumpadLeft}")
NumpadLeft & Up::type_in("{NumpadLeft Up}")
NumpadLeft & Down::type_in("{NumpadLeft Down}")
NumpadMult::type_in("{NumpadMult}")
NumpadMult & Up::type_in("{NumpadMult Up}")
NumpadMult & Down::type_in("{NumpadMult Down}")
NumpadPgDn::type_in("{NumpadPgDn}")
NumpadPgDn & Up::type_in("{NumpadPgDn Up}")
NumpadPgDn & Down::type_in("{NumpadPgDn Down}")
NumpadPgUp::type_in("{NumpadPgUp}")
NumpadPgUp & Up::type_in("{NumpadPgUp Up}")
NumpadPgUp & Down::type_in("{NumpadPgUp Down}")
NumpadRight::type_in("{NumpadRight}")
NumpadRight & Up::type_in("{NumpadRight Up}")
NumpadRight & Down::type_in("{NumpadRight Down}")
NumpadSub::type_in("{NumpadSub}")
NumpadSub & Up::type_in("{NumpadSub Up}")
NumpadSub & Down::type_in("{NumpadSub Down}")
NumpadUp::type_in("{NumpadUp}")
NumpadUp & Up::type_in("{NumpadUp Up}")
NumpadUp & Down::type_in("{NumpadUp Down}")
Pause::type_in("{Pause}")
Pause & Up::type_in("{Pause Up}")
Pause & Down::type_in("{Pause Down}")
PgDn::type_in("{PgDn}")
PgDn & Up::type_in("{PgDn Up}")
PgDn & Down::type_in("{PgDn Down}")
PgUp::type_in("{PgUp}")
PgUp & Up::type_in("{PgUp Up}")
PgUp & Down::type_in("{PgUp Down}")
PrintScreen::type_in("{PrintScreen}")
PrintScreen & Up::type_in("{PrintScreen Up}")
PrintScreen & Down::type_in("{PrintScreen Down}")
RAlt::type_in("{RAlt}")
RAlt & Up::type_in("{RAlt Up}")
RAlt & Down::type_in("{RAlt Down}")
RButton::type_in("{RButton}")
RButton & Up::type_in("{RButton Up}")
RButton & Down::type_in("{RButton Down}")
RControl::type_in("{RControl}")
RControl & Up::type_in("{RControl Up}")
RControl & Down::type_in("{RControl Down}")
Right::type_in("{Right}")
Right & Up::type_in("{Right Up}")
Right & Down::type_in("{Right Down}")
RShift::type_in("{RShift}")
RShift & Up::type_in("{RShift Up}")
RShift & Down::type_in("{RShift Down}")
RWin::type_in("{RWin}")
RWin & Up::type_in("{RWin Up}")
RWin & Down::type_in("{RWin Down}")
ScrollLock::type_in("{ScrollLock}")
ScrollLock & Up::type_in("{ScrollLock Up}")
ScrollLock & Down::type_in("{ScrollLock Down}")
Shift::type_in("{Shift}")
Shift & Up::type_in("{Shift Up}")
Shift & Down::type_in("{Shift Down}")
Sleep::type_in("{Sleep}")
Sleep & Up::type_in("{Sleep Up}")
Sleep & Down::type_in("{Sleep Down}")
Space::type_in("{Space}")
Space & Up::type_in("{Space Up}")
Space & Down::type_in("{Space Down}")
Tab::type_in("{Tab}")
Tab & Up::type_in("{Tab Up}")
Tab & Down::type_in("{Tab Down}")
Up::type_in("{Up}")
; Up & Up::type_in("{Up Up}")
; Up & Down::type_in("{Up Down}")
Volume_Down::type_in("{Volume_Down}")
Volume_Down & Up::type_in("{Volume_Down Up}")
Volume_Down & Down::type_in("{Volume_Down Down}")
Volume_Mute::type_in("{Volume_Mute}")
Volume_Mute & Up::type_in("{Volume_Mute Up}")
Volume_Mute & Down::type_in("{Volume_Mute Down}")
Volume_Up::type_in("{Volume_Up}")
Volume_Up & Up::type_in("{Volume_Up Up}")
Volume_Up & Down::type_in("{Volume_Up Down}")
WheelDown::type_in("{WheelDown}")
; WheelDown & Up::type_in("{WheelDown Up}")
; WheelDown & Down::type_in("{WheelDown Down}")
WheelLeft::type_in("{WheelLeft}")
; WheelLeft & Up::type_in("{WheelLeft Up}")
; WheelLeft & Down::type_in("{WheelLeft Down}")
WheelRight::type_in("{WheelRight}")
; WheelRight & Up::type_in("{WheelRight Up}")
; WheelRight & Down::type_in("{WheelRight Down}")
WheelUp::type_in("{WheelUp}")
; WheelUp & Up::type_in("{WheelUp Up}")
; WheelUp & Down::type_in("{WheelUp Down}")
; Win::type_in("{Win}")
; Win & Up::type_in("{Win Up}")
; Win & Down::type_in("{Win Down}")
XButton1::type_in("{XButton1}")
XButton1 & Up::type_in("{XButton1 Up}")
XButton1 & Down::type_in("{XButton1 Down}")
XButton2::type_in("{XButton2}")
XButton2 & Up::type_in("{XButton2 Up}")
XButton2 & Down::type_in("{XButton2 Down}")
Return
