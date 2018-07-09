;----------------------------------------------------
; hex2dec(p_hex_num)
;
; Converts hexadecimal number to a decimal number
; p_hex_num: is a hex number which can be either
;            the number itself or prefixed with 0x.
;            hex2dec("2F4E") is the same as hex2dec("0x2F4E")
;
; Returns a decimal number or 0 if p_hex_num is not a valid hex number.
;
;----------------------------------------------------
hex2dec(p_hex_num)
{
    if SubStr(p_hex_num, 1, 2) = "0x"
        p_hex_num := SubStr(p_hex_num, 3)
        
    Loop, Parse, p_hex_num
        reversed_hex_num := A_LoopField . reversed_hex_num

    hex_power_pos := StrSplit(reversed_hex_num)

    dec_num := 0
    for power_index, hex_digit in hex_power_pos
    {
        if (hex_digit = "A")
            dec_equivalent := 10
        else if (hex_digit = "B")
            dec_equivalent := 11
        else if (hex_digit = "C")
            dec_equivalent := 12
        else if (hex_digit = "D")
            dec_equivalent := 13
        else if (hex_digit = "E")
            dec_equivalent := 14
        else if (hex_digit = "F")
            dec_equivalent := 15
        else if (hex_digit >= "0") and (hex_digit <= "9")
            dec_equivalent := hex_digit 
        else
        {
            result := 0
            Goto EXIT_NOW
        }
        result += dec_equivalent * 16**(power_index - 1)
    }
EXIT_NOW:
    Return %result%
}
;----------------------------------------------------
; Returns Registry's default browser exe path
;----------------------------------------------------
default_browser() 
{
	; Find the Registry key name for the default browser
	RegRead, BrowserKeyName, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice, Progid

	; Find the executable command associated with the above Registry key
	RegRead, BrowserFullCommand, HKEY_CLASSES_ROOT, %BrowserKeyName%\shell\open\command

	; The above RegRead will return the path and executable name of the brower contained within quotes and optional parameters
	; We only want the text contained inside the first set of quotes which is the path and executable
	; Find closing quote position - second occurance of quote_char. 
	; StringGetPos, pos, BrowserFullCommand, ",,1
    quote_char := chr(34)
    pos := InStr(BrowserFullCommand, quote_char, false,,2)
  
	; Decrement the found position by two, to work correctly with the StringMid function
	pos := pos -2
    
	; Extract and return the path and executable of the browser
	; StringMid, BrowserPathandEXE, BrowserFullCommand, 2, %pos%
	BrowserPathandEXE := SubStr(BrowserFullCommand, 2, pos)
	Return BrowserPathandEXE
}
;----------------------------------------------------
;   OutputDebug wrapper for command to start DbgView.exe if necessary.
;   This is much easier to use than print(p_msg).
;----------------------------------------------------
output_debug(p_msg)
{
    msg_size := StrLen(p_msg)
    if (msg_size > 32766)
    {
        msgbox 48, OutputDebug, % "Can't display more than 32,766 characters (Short Int-1) `n`nYour message is " msg_size " characters."
        Return
    }
    Process, Exist, Dbgview.exe
    If ErrorLevel = 0
    {   
        WinGetTitle, win_title, A
        WinGetClass, win_class, A
        i_win_title := win_title . " ahk_class " . win_class
        Run, C:\Program Files (x86)\SysInternals\Dbgview.exe
        Sleep 1
        countx:= 0
        While Not WinActive(i_win_title) and (countx < 10)
        {
            OutputDebug, %i_win_title%
            WinActivate, %i_win_title%
            WinWait, %i_win_title%
            countx++
        }
    }
    OutputDebug, %p_msg%
    Return 
}
;----------------------------------------------------
; #Persistent & Return (Not ExitAppp)
;  ............or...........   
; Print("`n`n`Hit {Escape} to exit....")
; Input, UserInput, I L10, {Escape}.{Esc}
;
; to keep console open
;----------------------------------------------------
print(p_msg)
{
    WinGetTitle, active_window_title, A
    WinGetClass, active_window_class, A
    SetTitleMatchMode 1 ; exact match
    If !WinExist(A_ScriptName "ahk_class ConsoleWindowClass")
    {
        ; Initialiaze the console window.
        ; two calls to open, no error check (it's debug, so you know what you are doing)
        x := DllCall("AttachConsole", int, -1, int)
        y := DllCall("AllocConsole", int) 
        Dllcall("SetConsoleTitle", "p_msg", A_ScriptName)  
        h_Print := DllCall("GetStdHandle", "int", -11) 
    }
    
    ; Write to Console
    FileAppend, %p_msg%`n, *           
    ; set focus back to caller's window
    countx := 0
    win_title := active_window_title . " ahk_class " . active_window_class
    While !WinActive(win_title) and countx < 50
    {
        WinActivate, %win_title%
        countx++
    }
    Return
}
;----------------------------------------------------
; p_HHhh: 1 = 12 hour format
;         2 = 24 hour format
;
; p_seconds: True - displays seconds. False - don't display seconds.
;----------------------------------------------------
get_time(p_HHhh:=2, p_seconds:=True)
{
    hour_format := if p_HHhh = 1 ? "hh" : "HH"
    if p_seconds
        FormatTime, timex,, %hour_format%:mm:ss
    else
        FormatTime, timex,, %hour_format%:mm
    Return timex
}
;----------------------------------------------------
; p_HHhh: 1 = 12 hour format
;         2 = 24 hour format
;
; p_style: 1 = log style ie: 2018/06/08 16:18:40         
;          2 = diary style ie:  08-Jun-2018 16:18
;----------------------------------------------------
timestamp(p_HHhh:=2, p_style:=1)
{
    hour_format := if p_HHhh = 1 ? "hh" : "HH"

    if (p_style == 1)
        FormatTime, timex,, yyyy/MM/dd %hour_format%:mm:ss
    else if (p_style == 2)
        FormatTime, timex,, dd-MMM-yyyy %hour_format%:mm
    
    Return timex
}
;----------------------------------------------------
; Returns an array of all the subdirectories for a given path
; Access the subdirectory your interested in by it's index....
; Example: 
;        ResultArray := []
;        FullFilename = C:\Users\John\AppData\Local\Temp\7zBF42C9E0\AutoHotkeyU32.exe
;        resultarray := get_parent_directories(FullFilename)
;        for index, element in resultarray
;        {
;            msgbox % "(" index "} " element 
;        }
;        msgbox % resultarray[3]
;----------------------------------------------------
get_parent_directories(p_filepath)
{
    oresult := []
    odir := "dummy"
    odrive := "smart"
    While odir != odrive
    {
        SplitPath, p_filepath,,odir,,,odrive
        oresult.push(odir)
        p_filepath := odir
    }
    Return oresult 
}
;----------------------------------------------------
; Returns the full path for a given subdirectory.
; The subdirectory must be an exact match except for case.
; If there is more than 1 matching subdirectory in the path 
; the last one is returned.
;----------------------------------------------------
get_path(p_subdir, p_fullpath)
{
    path := p_fullpath
    root_dir := p_subdir
    len_root_dir := StrLen(root_dir)
    len_path := StrLen(path)
    
    ; Find first occurance from the end (ie: reverse search)
    last_occurance_pos := Instr(path, root_dir, false, 0)
   
    ; Extract the path to root_dir including backslash
    path_len := last_occurance_pos + len_root_dir 
    found_path := SubStr(path, 1, path_len)
    if SubStr(found_path, StrLen(found_path)) != "\"
        found_path := ""
    Return found_path
}
;----------------------------------------------------
; Delete taskbar icon, ordered left to right                                                       
; Author: Dev-X                                                                                    
; Refresh was c++ converted and converted to                                                       ///
; AHK from http://malwareanalysis.com/CommunityServer/blogs/geffner/archive/2008/02/15/985.aspx  
;----------------------------------------------------
delete_taskbar_icon(p_icon_number)
{
    eee := DllCall( "FindWindowEx", "uint", 0, "uint", 0, "str", "Shell_TrayWnd", "str", "")
    ddd := DllCall( "FindWindowEx", "uint", eee, "uint", 0, "str", "TrayNotifyWnd", "str", "")
    ccc := DllCall( "FindWindowEx", "uint", ddd, "uint", 0, "str", "SysPager", "str", "")
    hNotificationArea := DllCall( "FindWindowEx", "uint", ccc, "uint", 0, "str", "ToolbarWindow32", "str", "Notification Area")

    SendMessage, 0x416, %p_icon_number%, , , ahk_id %hNotificationArea%
}
;----------------------------------------------------
;
;----------------------------------------------------
refresh_taskbar_icons()
{
    eee := DllCall( "FindWindowEx", "uint", 0, "uint", 0, "str", "Shell_TrayWnd", "str", "")
    ddd := DllCall( "FindWindowEx", "uint", eee, "uint", 0, "str", "TrayNotifyWnd", "str", "")
    ccc := DllCall( "FindWindowEx", "uint", ddd, "uint", 0, "str", "SysPager", "str", "")
    hNotificationArea := DllCall( "FindWindowEx", "uint", ccc, "uint", 0, "str", "ToolbarWindow32", "str", "Notification Area")

    xx = 3
    yy = 5
    Transform, yyx, BitShiftLeft, yy, 16
    loop, 6 ;152
    {
        xx += 15
        SendMessage, 0x200, , yyx + xx, , ahk_id %hNotificationArea%
    }
}
;----------------------------------------------------
; Debugging tool useful for blocking keyboard input and stopping console from closing
;----------------------------------------------------
wait_for_escape(p_text:="")
{
    if (p_text <> "")
        p_text .= "`n"
    p_text .= "hit escape to continue..." 
    If WinExist("ahk_class ConsoleWindowClass")
        Print("`n`nHit escape to continue...")

    SetTimer, DISPLAY_TOOLTIP, 500
    Input, ov,,{Escape}  
    SetTimer, DISPLAY_TOOLTIP, Off
    ToolTip
    Return

    DISPLAY_TOOLTIP:
        MouseGetPos, x, y
        ToolTip,%p_text%, (x + 20), (y + 20), 1
        Return
}
;----------------------------------------------------
; is_ahk_script: returns either 1 or 0 if the file
; has an .ahk extension. If no filename is passed 
; A_ScriptName is used.
;----------------------------------------------------
is_ahk_script(p_filename:="")
{
    p_filename := (p_filename == "") ? A_ScriptName : p_filename
    x := SubStr(p_filename,-3)
    StringLower, file_type, x
    Return (file_type == ".ahk")
}