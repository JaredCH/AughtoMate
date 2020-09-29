return
CombatRoutine:
Msgbox, The bot will begin when you click ok.
InitStart:= A_TickCount
CheckLocation()
SetTitleMatchMode 2
WinActivate, RuneLite
WinGetPos, RSWINX1, RSWINY1, RSWINX2, RSWINY2, RuneLite
SetTimer, CombatStatus, 250
SetTimer, HealthStatus, 1000
SetTimer, PrayerStatus, 250
SetTimer, FoodStatus, 1000
SetTimer, AntiBan, 500

GuiControl,, status, Status:Ready
Loop
{
	CheckLocation()
	sleep, 5000  ; fix this. false positive, remove msgbox
}
return


BeginSandCrab:
Gui, submit, NoHide
GuiControl,,beginbuttonlabel, Stop(F12)
GuiControlGet, foodlistcolor,, listfoodcolor

if (toggle := !toggle) {
	goto, CombatRoutine
} else {
	GuiControl,,beginbuttonlabel, Start
}
return

Isyoueating:
Gui, submit, NoHide
If (eatoptionLogout=1) 
{
	GuiControl,, eatlabel, Eating ON; Logging off When out
}
return
;testing


CheckLocation()
{
	SetTitleMatchMode 2
	WinActivate, RuneLite	
	CenterX1=257
	CenterY1=192
	CenterX2=273
	CenterY2=206
	HomeGroundTile=0x00DFDF
	
	PixelSearch, Xhometile, Yhometile, %CenterX1%, %CenterY1%, %CenterX2%, %CenterY2%, %HomeGroundTile%, 5, fast
	if ErrorLevel
	{
		PixelSearch, Xhometilea, Yhometilea, 9, 33, 518, 364, %HomeGroundTile%, 5, fast
		if ErrorLevel
		{
												;msgbox, cant find color
		}
		else
		{
												;Msgbox, Moving to HomeBase found color at %Xhometilea% and %Yhometilea% for %HomeGroundTile%
			
												;~ mousemove, %Xhometilea%+3, Yhometilea+3, 10
												;~ sleep, 300
												;~ Mouseclick, Left
												;~ GuiControl,, status, Status:Returning to Home Tile
												;~ sleep, Rand(5250,8000)
			ReturnHome()
			
		}
	}
	else
	{
		GuiControl,, status, Status:Fighting Sand Crabs
	}
	
}
Return


ResetAgroMiniMap()
{
	GuiControl,, status, Status:Resetting Agro
	SetTitleMatchMode 2
	WinActivate, RuneLite
	northx1=616
	northy1=41
	northx2=667
	northy2=83
	southx1=616
	southy1=146
	southx2=667
	southy2=177
	Loop, 3
	{
		RandomBezier(0,0, northx1+Rand(5,40), northy1+Rand(3,31),  "T600 RO" )
		sleep, Rand(50,175)
		MouseClick, Left
		sleep, Rand(4250,5100)
	}
	
	Loop, 3
	{
		RandomBezier(0,0, southx1+Rand(10,40), southy1+Rand(2,31), "T600 RO" )
		sleep, Rand(50,175)
		MouseClick, Left
		sleep, Rand(4250,5100)
	}
	GuiControl,, status, Status:Agro Reset		
	sleep, Rand(3500,5500)
	CheckLocation()
}


ReturnHome()
{
	SetTitleMatchMode 2
	WinActivate, RuneLite	
	GuiControl,, status, Status:Returning to Home Tile
	SetTimer, CombatStatus, Off
	CenterX1=257
	CenterY1=192
	CenterX2=273
	CenterY2=206
	HomeGroundTile=0x00DFDF
	xArray := []
	yArray := []
	xavg:=
	yavg:=
	toggle:= True
	Totalx=0
	Totaly=0
	count =0
	
	PixelSearch, Xhometilea, Yhometilea, 9, 33, 518, 364, %HomeGroundTile%, 5, fast
	if ErrorLevel
	{
	}
	else
	{
		xsearch= %Xhometilea%
		ysearch= %Yhometilea%
		While toggle
		{
			PixelSearch, Xhometilea, Yhometilea, xsearch-1, ysearch+1, 518, 364, %HomeGroundTile%, 5, fast		
			if ErrorLevel
			{
				xsearch = %xsearch%-2
				ysearch = %ysearch%-10
			}
			else
			{
				xArray.Push(Xhometilea)
				yArray.Push(yhometilea)
				xsearch=%Xhometilea%
				ysearch=%Yhometilea%
				count++
			}
			
			
			if (count=3)
			{
				toggle:=False
			}
		}
		
		Loop, 3
		{
			Totalx += xArray[A_Index]
			Totaly += yArray[A_Index]
		}
		newx=%Totalx%
		newy=%Totaly%
		RandomBezier(0,0,Floor(Totalx / 3), Floor(Totaly / 3), "T600 RO" )
		sleep, Rand(10,100)
		MouseClick, Left
		sleep, Rand(5250,8000)
	}
	GuiControl,, status, Status:Fighting Sand Crabs
	SetTimer, CombatStatus, 250
}

Return


ResetAgro()
{
	SetTimer, AntiBan, Off
	GuiControl,, status, Status:Resetting Agro
	SetTitleMatchMode 2
	WinActivate, RuneLite
	RSgameinx1=9
	RSgameiny1=33
	RSgameinx2=518
	RSgameiny2=364
;		ahkcolor-runelitecolor
;hometile=0x00FFFF-FFFFFF00
;walktile1=0x0000FF-FFFF0000
;walktile2=0xFF0026-FF2600FF  
;walktile3=0xE700FF-FFFF00E7
;walktile4=0xE7FF00-FF00FFE7
;walktile5=0xCD0093-FFB700FF
	ColorArrayaway := ["0x0000FF", "0xFF0026", "0xE700FF", "0xE7FF00", "0xCD0093"]
	ColorArrayreturn := ["0xE7FF00", "0xE700FF", "0xFF0026","0x0000FF", "0x00FFFF"]
	for i, coloraway in ColorArrayaway
	{
		WinActivate, RuneLite
		
		PixelSearch, Xwalkcolor, Ywalkcolor, %RSgameinx1%, %RSgameiny1%, %RSgameinx2%, %RSgameiny2%, coloraway, 1, fast	
		if ErrorLevel
		{
			FileAppend cant find walk tile
		}
		else
		{
			
						;msgbox, found color %i% at %Xc% and %Yc%
			FileAppend found color %coloraway% at %Xwalkcolor% and %Xwalkcolor%`n, *
			RandomBezier(0,0,Xwalkcolor-Rand(5,10), Ywalkcolor-Rand(5,10),  "T600 RO" )
			sleep, Rand(80,200)
			MouseClick Left
			sleep, Rand(3500,4000)
			
		}
	}
	for i, colorreturn in ColorArrayreturn
	{
		WinActivate, RuneLite
		
		PixelSearch, Xwalkcolorreturn, Ywalkcolorreturn, %RSgameinx1%, %RSgameiny1%, %RSgameinx2%, %RSgameiny2%, colorreturn, 1, fast	
		if ErrorLevel
		{
			FileAppend cant find walk tile
		}
		else
		{
						;msgbox, found color %i% at %Xc% and %Yc%
			FileAppend found colorreturn %color% at %Xwalkcolorreturn% and %Ywalkcolorreturn%`n, *
			RandomBezier(0,0,Xwalkcolorreturn-5, Ywalkcolorreturn, "T600 RO" )
			sleep, Rand(80,200)
			MouseClick Left
			sleep, Rand(3500,4500)
		}
	}
	GuiControl,, status, Status:Agro Reset		
	sleep, 5000		
	SetTimer, AntiBan, 500
}