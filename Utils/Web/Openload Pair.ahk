ol_wintitle = Openload.co Pair - Google Chrome ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe

If Not WinExist(ol_wintitle)
    Run, https://olpair.com

countx = 0
While Not WinActive(ol_wintitle) and countx < 1000
{
    WinActivate, %ol_wintitle%
    Sleep 1
    countx++
}
OutputDebug, % "countx: " countx
If Not WinActive(ol_wintitle)
{
    MsgBox, 48,, % "Could not navigate to Openload pairing", 10
    ExitApp
}
WinMaximize, %ol_wintitle%
WinGetPos, x, y, w, h, %ol_wintitle%
OutputDebug, %  x "," y "," w "," h
; captcha checkbox click
x := (w/2) - 130
y := h/2 + 35
; OutputDebug, %  x "," y "," w "," h
Sleep 5000
MouseMove, x, y
Click
; pair button click
x := x + 130
y := y + 80
Sleep 3000
MouseMove, x, y
Click
; OutputDebug, %  x "," y "," w "," h

ExitApp