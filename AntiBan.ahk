AntiBan:
Skillx1=569
Skilly1=197
Skillx2=20 ;589
Skilly2=41 ;220
Asdx1=555
Asdy1=235
Asdx2=52 ;607
Asdy2=88 ;323
cbttx1=539
cbtty1=204
cbttx2=12 ;551
cbtty2=17 ;221
Invx1=637
Invy1=200
Invx2=18 ;655
Invy2=23 ;223
setx1=670
sety1=501
setx2=16 ;686
sety2=14 ;515.
Foodinvx1=567
Foodinvy1=242
Foodinvx2=725
Foodinvy2=481
GuiControlGet, antban
if (antban=1)
{	
	Randomnum:=Rand(1,2000000)
			;FileAppend Random number %Randomnum% `n, *
			;just click skills tab
			;~ if(Randomnum<1000)
			;~ {
				;~ SetTimer, FoodStatus, Off
				;~ FileAppend Random number %Randomnum% skill tab`n, *
				;~ GuiControl,,antbanlabel, Skills Tab
				;~ MoveMouse(Skillx1+Rand(1,20), Skilly1+Rand(1,25), 2)
				;~ MouseClick, Left
				;~ sleep, Rand(2000,13000)
				;~ ;return to inv screen
				;~ MoveMouse(637+Rand(3,18), 200+Rand(3,23), 2)
				;~ MouseClick, Left
				;~ sleep, Rand(1000,2000)
				;~ MoveMouse(Foodinvx1+Rand(40,200), Foodinvy1+Rand(30,200), 2)
				;~ ;end return to inv screen
				;~ GuiControl,,antbanlabel, Idle, - Last task - Skills Tab
				;~ SetTimer, FoodStatus, 1000
				;~ sleep, 5000
			;~ } 
	
			;~ ;click skills tab / mouse over A S or D
	
	if(Randomnum>1000) && (Randomnum<2000)
	{
		SetTimer, FoodStatus, Off
		FileAppend Random number %Randomnum% skill tab asd`n, *
		GuiControl,,antbanlabel, Skills Tab and skill
		RandomBezier(0,0,Skillx1+Rand(1,Skillx2), Skilly1+Rand(1,Skilly2), "T600 RO" )
		MouseClick, Left
		sleep, Rand(800,1200)
		RandomBezier(0,0,Asdx1+Rand(1,Asdx2), Asdy1+Rand(1,Asdy2), "T600 RO" )
		sleep, Rand(1000,7000)
				;return to inv screen
		RandomBezier(0,0,637+Rand(3,18), 200+Rand(3,23), "T600 RO" )
		MouseClick, Left
		sleep, Rand(1000,2000)
		RandomBezier(0,0,Foodinvx1+Rand(40,200), Foodinvy1+Rand(30,200), "T600 RO" )
				;end return to inv screen
		GuiControl,,antbanlabel, Idle - Last task - Skills tab & Skill
		SetTimer, FoodStatus, 1000
	}
	
	
			;Click Cbt Style Tab
	if(Randomnum>2000) && (Randomnum<2500)
	{
		SetTimer, FoodStatus, Off
		FileAppend Random number %Randomnum% cbt tab`n, *
		GuiControl,,antbanlabel, Combat Tab
		RandomBezier(0,0,cbttx1+Rand(1,cbttx2), cbtty1+Rand(1,cbtty2), "T600 RO" )
		MouseClick, Left
		sleep, Rand(2000,13000)
				;return to inv screen
		RandomBezier(0,0,637+Rand(3,18), 200+Rand(3,23), "T600 RO" )
		MouseClick, Left
		sleep, Rand(1000,2000)
		RandomBezier(0,0,Foodinvx1+Rand(40,200), Foodinvy1+Rand(30,200), "T600 RO" )
				;end return to inv screen
		GuiControl,,antbanlabel, Idle, - Last task - Combat Tab
		SetTimer, FoodStatus, 1000				
	}
	
			;Click settings Tab
	if(Randomnum>2500) && (Randomnum<3000)
	{
		SetTimer, FoodStatus, Off
		FileAppend Random number %Randomnum% set tab`n, *
		GuiControl,,antbanlabel, Settings Tab
		RandomBezier(0,0,setx1+Rand(1,setx2), sety1+Rand(1,sety2), "T600 RO" )
		MouseClick, Left
		sleep, Rand(2000,5000)
				;return to inv screen
		RandomBezier(0,0,637+Rand(3,18), 200+Rand(3,23), "T600 RO" )
		MouseClick, Left
		sleep, Rand(1000,2000)
		RandomBezier(0,0,Foodinvx1+Rand(40,200), Foodinvy1+Rand(30,200), "T600 RO" )
				;end return to inv screen
		GuiControl,,antbanlabel, Idle, - Last task - Settings Tab
		SetTimer, FoodStatus, 1000
	}
	
			;Right Click
	if(Randomnum>3000) && (Randomnum<5000)
	{
		FileAppend Random number %Randomnum% Right Click`n, *
		GuiControl,,antbanlabel, Right Click
		MouseGetPos, xpos, ypos
		Mouseclick, Right
		sleep, Rand(300,500)
		RandomBezier(0,0,xpos+Rand(30,50), ypos-Rand(30,75), "T600 RO" )
		GuiControl,,antbanlabel, Idle, - Last task - Right Click
	}
			;~ ;Click equipment Tab
	if(Randomnum>5000) && (Randomnum<6000)
	{
		SetTimer, FoodStatus, Off
		FileAppend Random number %Randomnum% set tab`n, *
		GuiControl,,antbanlabel, Settings Tab
		RandomBezier(0,0,669+Rand(1,20), 202+Rand(1,20), "T600 RO" )
		MouseClick, Left
		sleep, Rand(2000,7000)
				;return to inv screen
		RandomBezier(0,0,637+Rand(3,18), 200+Rand(3,23), "T600 RO" )
		MouseClick, Left
		sleep, Rand(1000,2000)
		RandomBezier(0,0,Foodinvx1+Rand(40,200), Foodinvy1+Rand(30,200), "T600 RO" )
				;end return to inv screen
		GuiControl,,antbanlabel, Idle, - Last task - Equipment Tab
		SetTimer, FoodStatus, 1000
	}
	
}
return