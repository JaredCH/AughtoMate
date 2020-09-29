#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Gui, Add, Tab2, x2 y-1 w480 h380 , Sand Crab|Misc ; done
Gui, Add, CheckBox, x22 y59 w120 h20 vareyoueating gareyoueatingthough, Eat? ; done
Gui, Add, ListBox, x362 y49 w60 h70 vlistfoodcolor, ; done
Gui, Add, Button, x362 y29 w100 h20 vsetcolors gsetfoodcolor, Set Food Colors ; add clear hotkey/button
Gui, Add, GroupBox, x12 y39 w210 h130 , Food ; done
Gui, Add, Radio, x42 y89 w100 h20 veatoptionLogout , Logout if no food ; done
Gui, Add, Text, x42 y117 w190 h20 vfoodinv, Food Detected: No ;done
Gui, Add, CheckBox, x12 y179 w210 h20 vantban, Extra AntiBan ; done
Gui, Add, Button, x362 y329 w100 h30 gBeginSandCrab vbeginbuttonlabel, Start ; done
Gui, Add, GroupBox, x252 y119 w210 h200 , Metrics ; done
Gui, Add, Text, x262 y139 w190 h20 vstatus, Status:Duration ; done
Gui, Add, Text, x262 y169 w190 h20 vcbtstatus, Not in combat ;done
Gui, Add, Text, x262 y199 w190 h20 vhealth, Health: ;done
Gui, Add, Text, x262 y229 w190 h20 vprayer, Prayer: ;done
Gui, Add, Text, x262 y259 w190 h20 veatlabel, Eating OFF ;done
Gui, Add, Text, x262 y289 w200 h20 vantbanlabel, AntiBan Status: Idle ; in progress
Gui, Show, w479 h379, AughtoMate


WinGetPos, RSWINX1, RSWINY1, RSWINX2, RSWINY2, RuneLite

GuiControl,Disable, setcolors
GuiControl,Disable, eatandbank
GuiControl,Disable, eattilllog