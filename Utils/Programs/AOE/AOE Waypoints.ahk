/*
template(p_scout_type := "Scout")
{
    Keywait Control
    Keywait Alt
    Keywait Shift
    BlockInput, On
    If (p_scout_type = "Patrol")
        SendInput z        ; patrol
    SendInput ]            ; no attack stance
	SendInput {F3}		   ; pause game
    SetMouseDelay 50


	SendInput {F3}		   ; resume game	 
    BlockInput, Off
    Return
}
*/

/* 
	These waypoints assume a 1280x1024 screen resolution
*/
explore_unexplored_map(p_scout_type := "Scout")
{
    WinActivate, %aoe_wintitle%
    WinWaitActive, %aoe_wintitle%
    Sleep 2000
    Keywait Control
    Keywait Alt
    Keywait Shift
    saved_search_coords := []
    quad := []
    quad[1] := [ 845, 810, 1063,  917, "TL"]  ; top left
    quad[2] := [1063, 810, 1280,  917, "TR"]  ; top right
    quad[3] := [ 845, 917, 1063, 1024, "BL"]  ; bottom left
    quad[4] := [1063, 917, 1280, 1024, "BR"]  ; bottom right
    ; BlockInput, On
    SendInput {F3}      ; Pause Game
    If (p_scout_type = "Patrol")
        SendInput z        ; patrol
    SendInput ]            ; no attack stance
    SetMouseDelay 100
    For q_index, xy_coord in quad
    {
        x1 := xy_coord[1]
        y1 := xy_coord[2]
        x2 := xy_coord[3]
        y2 := xy_coord[4]
        quad_name := xy_coord[5]
SEARCH_AGAIN:
        ImageSearch, x, y, %x1%, %y1%, %x2%, %y2%,*2 Pango 100 - Mini Map Unexplored Square.png
        If (ErrorLevel = 0)
        {
			; ; check if found unexplored square is too close to a previously searched square
			; too_close_flag := False
			; x_too_close := x + 50
			; y_too_close := y + 50
			; For i_ndx, saved_coords in saved_search_coords
			; {
				; If (x between x1 and x_too_close) and (y between y1 and y_too_close)
				; {
					
					; x1 := x_too_close
					; y1 := y_too_close
					; too_close_flag := True
				; }
				; If too_close_flag
				; {
					; OutputDebug, % "Too close searching again..." x "," y  "," x1 "," y1
					; ttip("Too close searching again...")
					; Goto SEARCH_AGAIN
				; }
			; }	 
            saved_search_coords.push([x,y])
            SendInput +{Click, %x%, %y%}                    ; focus visible screen to unexplored area from minimap
            MouseMove, A_ScreenWidth/2, A_ScreenHeight/2    ; focus on unexplored visible screen area on game map
            SendInput +{Click, Right}                       ; send scout to middle of unexplored area on game map
			OutputDebug, % Format("Quad #{:2}: x{:04}, y{:04} ({:4},{:4},{:4},{:4})", quad_name, x, y, x1, y1, x2, y2)
        }
    }
    MouseMove, A_ScreenWidth/2, A_ScreenHeight/2    ; focus on visible screen area on game map
    Click, Right            ; Start scouting
    SendInput {BackSpace}   ; go back to previous view before this function was called
    SendInput {F3}          ; resume game
    BlockInput, Off
    OutputDebug, % "saved_search_coords: "
    for i, j in saved_search_coords
        OutputDebug, % Format("{:02}) {:4}, {:4}", i, j[1], j[2]) 

    Return
}

land_zigzag(p_scout_type := "Scout")
{
    Keywait Control
    Keywait Alt
    Keywait Shift
    BlockInput, On
    If (p_scout_type = "Patrol")
        SendInput z        ; patrol
    SendInput ]            ; no attack stance
	SendInput {F3}		   ; pause game
    SetMouseDelay 50
    Click, Left  ,  872,  914
    SendInput {Shift Down}
    Click, Right ,  151,  162
    Click, Left  ,  962,  958
    Click, Right ,  787,  728
    Click, Left  , 1119,  852
    Click, Right , 1277,  406
    Click, Left  , 1212,  893
    Click, Right , 1158,  603
    Click, Left  , 1019,  983
    Click, Right ,  895,  771
    Click, Left  , 1053, 1008
    Click, Right , 1212,  790
    Click, Left  , 1250,  912
    Click, Right , 1220,  736
    Click, Left  , 1031,  836
    Click, Right ,  635,  307
    Click, Left  , 1054,  892
    Click, Right ,  966,  678
    Click, Left  ,  980,  874
    Click, Right ,  782,  621
    Click, Left  , 1005,  932
    Click, Right ,  788,  631
    Click, Left  , 1133,  909
    SendInput {Shift Up}
    Click, Right , 1061,  686
	SendInput {F3}		   ; resume game
    BlockInput, Off
    Return
}

perimeter(p_scout_type := "Scout")
{
    Keywait Control
    Keywait Alt
    Keywait Shift
    BlockInput, On
    If (p_scout_type = "Patrol")
        SendInput z        ; patrol
    SendInput ]            ; no attack stance
	SendInput {F3}		   ; pause game
    SetMouseDelay 50
    Click, 879, 916 Left    
    SendInput, {LShift Down}
    Click,  100,  109, Right   
    Click, 1064,  827, Left       
    Click, 1255,   54, Right
    Click, 1239,  918, Left
    Click, 1253,  769, Right
    Click, 1067, 1002, Left
    Click, 1036,  756, Right
    Click,  961,  952, Left
    Click,  778,  746, Right
    Click, 1120,  849, Left
    Click, 1137,  697, Right
    Click, 1186,  885, Left
    Click, 1170,  747, Right
    Click, 1004,  961, Left
    SendInput, {LShift Up}
    Click, Right    	   ; start scouting
	SendInput {F3}		   ; resume game
    BlockInput, Off
    Return
} 

perimeter_top(p_scout_type := "Scout")
{
    Keywait Control
    Keywait Alt
    Keywait Shift
    BlockInput, On
    If (p_scout_type = "Patrol")
        SendInput z        ; patrol
    SendInput ]            ; no attack stance
	SendInput {F3}		   ; pause game
    SetMouseDelay 50
    Click, Left  ,  966,  961
    SendInput {Shift Down}
    Click, Right ,   86,  460
    Click, Left  , 1069, 1008
    Click, Right ,  734,  773
    Click, Left  , 1243,  918
    Click, Right , 1258,  776
    Click, Left  , 1200,  892
    Click, Right , 1142,  468
    Click, Left  , 1140,  867
    Click, Right , 1019,  571
    Click, Left  , 1092,  886
    Click, Right ,  997,  694
    Click, Left  , 1157,  924
    Click, Right , 1100,  733
    Click, Left  , 1107,  957
    Click, Right , 1043,  773
    Click, Left  , 1041,  968
    Click, Right ,  984,  720
    Click, Left  ,  986,  953
    SendInput, {LShift Up}
    Click, Right    	   ; start scouting
	SendInput {F3}		   ; resume game
    BlockInput, Off
    Return
} 

perimeter_bottom(p_scout_type := "Scout", p_keep_shift_down := False)
{
    Return
}

perimeter_left(p_scout_type := "Scout", p_keep_shift_down := False)
{
    Keywait Control
    Keywait Alt
    Keywait Shift
    BlockInput, On
    If (p_scout_type = "Patrol")
        SendInput z        ; patrol
    SendInput ]            ; no attack stance
	SendInput {F3}		   ; pause game
    SetMouseDelay 50
    Click, Left  ,  876,  920
    SendInput {Shift Down}
    Click, Right ,    3,   52
    Click, Left  , 1068, 1012
    Click, Right ,   3,  779
    Click, Left  , 1099,  995
    Click, Right , 1055,  745
    Click, Left  ,  917,  902
    SendInput {Shift Up}
    Click, Right ,  394,  392
	SendInput {F3}		   ; resume game	 
    BlockInput, Off
    Return
}

perimeter_right(p_scout_type := "Scout", p_keep_shift_down := False)
{
    Keywait Control
    Keywait Alt
    Keywait Shift
    BlockInput, On
    If (p_scout_type = "Patrol")
        SendInput z        ; patrol
    SendInput ]            ; no attack stance
    Click, Left  , 1243,  920
    SendInput {Shift Down}
    Click, Right , 1279,  779
    Click, Left  , 1159,  872
    Click, Right , 1279,  353
    Click, Left  , 1119,  850
    Click, Right , 1181,  282
    Click, Left  , 1071,  827
    Click, Right , 1236,   94
    Click, Left  , 1029,  839
    Click, Right ,  335,   83
    Click, Left  , 1186,  948
    SendInput {Shift Up}
    Click, Right , 1083,  744
	SendInput {F3}		   ; pause game
    SetMouseDelay 50
	SendInput {F3}		   ; resume game	 
    BlockInput, Off
    Return    
}

visible_screen(p_scout_type := "Scout", p_keep_shift_down := False)
{
    Keywait Control
    Keywait Alt
    Keywait Shift
    BlockInput, On
    If (p_scout_type = "Patrol")
    {
        SendInput z        ; patrol
        ttip("`r`nPatroling visible screen area.`r`n ", 2000,500,500)
    }
    SendInput ]            ; no attack stance
	SendInput {F3}		   ; pause game
    SendInput {Shift Down}
    Click, Right , 1229,   72
    Click, Right , 1258,  792
    Click, Right ,  867,  798
    Click, Right ,  805,   44
    Click, Right ,  484,   42
    Click, Right ,  462,  797
    Click, Right ,  166,  792
    Click, Right ,  245,   38
    Click, Right ,    4,   43
    Click, Right ,  115,  799
    If Not p_keep_shift_down
    {
        SendInput {Shift Up}
        Click, Right ,  365,  316
		SendInput {F3}		   ; resume game
    }
    BlockInput, Off
    Return
}