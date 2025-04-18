#SingleInstance, Force
#UseHook

toggle := false
currentTransparency := 255 ; Fully visible (0% transparent)
SetTimer, SpamE, Off
SetTimer, autoclick, Off

; Get screen width
SysGet, screenWidth, 78
xPos := screenWidth - 250  ; Pre-calculate the x-position

; GUI settings
Gui, +AlwaysOnTop -Caption +ToolWindow
Gui, Font, s12 cWhite, Segoe UI
Gui, Color, 202020
Gui, Margin, 20, 20
Gui, Add, Text,, Aming Coffee Macro
Gui, Font, s10
Gui, Add, Text,, F1 to start/pause/stop
Gui, Add, Text,, F2 for autoclick
Gui, Add, Text,, F3 to exit
Gui, Add, Text,, F4 to make gui transparent
Gui, Add, Text,, F5 to reset transparency

; Show GUI in top-right corner
Gui, Show, NoActivate x%xPos% y10, MacroStatus
WinSet, Transparent, %currentTransparency%, MacroStatus

; Add rounded corners (20px radius)
WinGet, hWnd, ID, MacroStatus
DllCall("CreateRoundRectRgn", "int", 0, "int", 0, "int", 300, "int", 120, "int", 20, "int", 20)
    -> region
DllCall("SetWindowRgn", "ptr", hWnd, "ptr", region, "int", true)

~*F1::
if (!toggle) {
    toggle := true
    SetTimer, SpamE, 10
} else {
    toggle := false
    SetTimer, SpamE, Off
    Send, {MButton Up}
}
Return

~*F2::
if (!toggle) {
    toggle := true
    SetTimer, autoclick, 10
} else {
    toggle := false
    SetTimer, autoclick, Off
    Send, {MButton Up}
}
Return

autoclick:
Click
Return

*F3::ExitApp

*F4::  ; Decrease opacity (increase transparency) by 10%
currentTransparency -= 26
if (currentTransparency < 0)
    currentTransparency := 0
WinSet, Transparent, %currentTransparency%, MacroStatus
Return

*F5::  ; Reset transparency to 0% (fully visible)
currentTransparency := 255
WinSet, Transparent, %currentTransparency%, MacroStatus
Return

SpamE:
Send, e
Return

GuiClose:
ExitApp
