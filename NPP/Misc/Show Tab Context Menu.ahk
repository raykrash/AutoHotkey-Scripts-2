; Displays the context menu when you click on a document tab in Notepad++.
; The way it is being used is as a Notepad++ context menu item added to
; Notepad++'s C:\Users\Mark\Google Drive\Misc Backups\Notepad++\contextMenu.xml.
; You can rightclick anywhere in the active document and access the tab context
; context menu for that document (copy filepath, open explorer, clone....) 
; See also Notepad++'s menu Run/Show Tab Context Menu 
#NoEnv
#NoTrayIcon
#SingleInstance Force
ControlClick, SysTabControl325, A,,Right
ExitApp
