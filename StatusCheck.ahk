


RuneLiteStatus:
ifWinActive, RuneLite
{
		SetTimer, CombatStatus, 250
		SetTimer, HealthStatus, 250
		SetTimer, PrayerStatus, 250
		GuiControl,, status, Status:Ready
}

ifWinNotActive, RuneLite
{
		GuiControl,, status, Status:RuneLite Client not Active
		SetTimer, CombatStatus, Off
		SetTimer, HealthStatus, Off
		SetTimer, PrayerStatus, Off
}

return

CombatStatus:
cbtstart:=A_TickCount
If(cbtstart<InitStart+5000)
{
	Sleep, 1000
}

GuiControlGet, Cbttext,, cbtstatus
newstatus=
Loop, 5
{
	sleep,200
	PixelSearch, Xcbtstatus, Ycbtstatus, %cbtlocX1%, %cbtlocY1%, %cbtlocX2%, %cbtlocY2%, %CombatAliveColor%, 2, fast
}
if ErrorLevel
{
	CbtDead:= A_TickCount
	{
		if (CbtDead <= CbtLastAlive+3000)
		{
			newstatus = Recently Dead Target.
		}
		if (CbtDead >= CbtLastAlive+3000)
		{
			
			newstatus = Not in combat
		}
		if (CbtDead >= CbtLastAlive+Rand(10000,23000))
		{
			CbtDead=
			CbtLastAlive=
			ResetAgroMiniMap()
		}
	}
}
else
{
	CbtLastAlive:= A_TickCount
	newstatus = Combat Detected.
}
GuiControl,, cbtstatus, %newstatus%
GuiControl,, status, Status:Fighting Sand Crabs
Return



HealthStatus: ; Check HP Status
newhpleveltocheck:= 100hpy2 
GuiControlGet, hptext,, health
newstatushp:=hplvlnum
hplvlnum:=10
invx1=563
invy1=235
invx2=731
invy2=482

PixelSearch, Xcbtstatus, Ycbtstatus, %100hpx1%, %100hpy1%, %100hpx2%, %100hpy2%, %hpcolor%, 5, fast
if ErrorLevel
{
	Loop, 10 {
		newhpleveltocheck:= newhpleveltocheck+hpdiff
		PixelSearch, Xhbstatus, Yhbstatus, %100hpx1%, %newhpleveltocheck%, %100hpx2%, newhpleveltocheck+3, %hpcolor%, 1, fast
		if ErrorLevel
		{
			hplvlnum--
		}
		else
		{
			hplvlnum--
			break	
		}
	}
}

else
{
	newstatushp = 100`%
}						
GuiControlGet, hptext,, health	
If (newstatushp != hplvlnum)		
{
	newhp:= hplvlnum*10
	GuiControl,, health, %newhp%`%
}
GuiControlGet, areyoueating
if (areyoueating=1)
{				
	If(hplvlnum<6)
	{
		SetTimer, AntiBan, Off
		Lookingfood :=true
		GuiControl,, status, Status:Eating
		for i, foods in listoffood
		{
			WinActivate, RuneLite
			While Lookingfood
			{
				PixelSearch, XFoodcolor, YFoodcolor, %invx1%, %invy1%, %invx2%, %invx2%, foods, 1, fast	
				if ErrorLevel
				{
					FileAppend Out of food
				}
				else
				{
										;msgbox, found color %i% at %Xc% and %Yc%
					FileAppend found food %foods% at %XFoodcolor% and %YFoodcolor%`n, *
					RandomBezier(0,0,XFoodcolor, YFoodcolor+Rand(5,10), "T600 RO" )
					sleep, Rand(80,200)
					MouseClick Left
					Lookingfood :=False
					sleep, Rand(3700,5500)
				}
			}
		}
	}
	SetTimer, AntiBan, 500
}
return




PrayerStatus: ; Check Prayer Status
newpleveltocheck:= 100py2 
GuiControlGet, ptext,, prayer
newstatusp:=plvlnum
plvlnum:=10
PixelSearch, Xpstatus, Ypstatus, %100px1%, %100py1%, %100px2%, %100py2%, %pcolor%, 5, fast
if ErrorLevel
{
	Loop, 10 {
		newpleveltocheck:= newpleveltocheck+pdiff
		PixelSearch, Xcbtstatus, Ycbtstatus, %100px1%, %newpleveltocheck%, %100px2%, newpleveltocheck+3, %pcolor%, 1, fast
		
		if ErrorLevel
		{
			plvlnum--
		}
		else
		{
			plvlnum--
			break	
		}
	}
}

else
{
	newstatusp = 100`%
}

GuiControlGet, ptext,, health	
If (newstatusp != plvlnum)		
{
	newp:= plvlnum*10
	GuiControl,, prayer, %newp%`%
}
return

FoodStatus: ; Check Inventory for food
Foodinvx1=567
Foodinvy1=242
Foodinvx2=725
Foodinvy2=481
GuiControlGet, foodtext,, vfoodinv
Lookingfood :=true
for i, foods in listoffood
{
	WinActivate, RuneLite
						;While Lookingfood
	{
		PixelSearch, XFoodcolor, YFoodcolor, %Foodinvx1%, %Foodinvy1%, %Foodinvx2%, %Foodinvy2%, foods, 1, fast	
		if ErrorLevel
		{
			GuiControlGet, areyoueating
			
			if (areyoueating=1)
			{	
				GuiControl,, foodinv, Food Detected: No! Logging!
				Loop, 3
				{
					RandomBezier(0,0,southx1+Rand(10,40), southy1+Rand(2,31), "T600 RO")
					sleep, Rand(50,175)
					MouseClick, Left
					sleep, Rand(4250,5100)
				}
				RandomBezier(0,0,635+Rand(5,20), 498+Rand(3,20), "T600 RO" )
				sleep, Rand(100,3000)
				MouseClick, Left
				sleep, Rand(100,1300)
				RandomBezier(0,0,596+Rand(10,50), 447+Rand(5,20), "T600 RO" )
				sleep, Rand(100,3000)
				MouseClick, Left
			}
			
		}
		else
		{
			GuiControl,, foodinv, Food Detected: Yes
		}
	}
}

return
