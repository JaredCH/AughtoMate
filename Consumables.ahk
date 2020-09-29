;Set food colors when eating.
setfoodcolor:
Msgbox, Please mouse over the food in your inventory and press F1 to save the color`n`nPLEASE SET 3 COLORS.`n`nIf you Mess up, press F2 to clear the list.
foodlabelid=1
foodyco=50
return

F1::
if(listoffood.MaxIndex() >= 3 )
{
	Msgbox, Only 3 colors are supported at this time
	return
}
MouseGetPos, MouseX, MouseY
PixelGetColor, color, %MouseX%, %MouseY%
sleep, 100
;GuiControl,, listfoodcolor,%color%
listoffood.push(color)
GuiControl,, listfoodcolor,%color%
stringmid, R, color ,3 , 2
stringmid, G, color,5,2
stringmid, B, color,7,2
Gui Add, Text, vfood%foodlabelid% x425 y%foodyco% c%B%%G%%R%, ||||||||||||||||||			
foodyco:=foodyco+14
foodlabelid++
sleep, 200
return

F2::
reload
return


areyoueatingthough:
GuiControlGet, areyoueating
{
	if (areyoueating=1)
	{
		GuiControl,Enable, setcolors
		GuiControl,, eatlabel, Eating ON
		GuiControl,Enable, eatandbank
		GuiControl,Enable, eattilllog
		GuiControl,,eatoptionLogout, 1
		
	}
	if (areyoueating=0)
	{
		GuiControl,Disable, setcolors
		;GuiControl,Disable, eatandbank
		GuiControl,Enable, eattilllog
		GuiControl,, eatlabel, Eating OFF
		;GuiControl,,eatoptionbank, 1
	}
}
return