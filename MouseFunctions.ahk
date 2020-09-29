#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


/*
	RandomBezier.ahk
	Copyright (C) 2012,2013 Antonio França
	This script is free software: you can redistribute it and/or modify
	it under the terms of the GNU Affero General Public License as
	published by the Free Software Foundation, either version 3 of the
	License, or (at your option) any later version.
	This script is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU Affero General Public License for more details.
	You should have received a copy of the GNU Affero General Public License
	along with this script.  If not, see <http://www.gnu.org/licenses/>.
*/
 
;========================================================================
; 
; Function:     RandomBezier
; Description:  Moves the mouse through a random Bézier path
; URL (+info):  --------------------
;
; Last Update:  30/May/2013 03:00h BRT
;
; Created by MasterFocus
; - https://github.com/MasterFocus
; - http://masterfocus.ahk4.net
; - http://autohotkey.com/community/viewtopic.php?f=2&t=88198
;
;========================================================================
MouseGetPos, X0s, Y0s



;~ F10::
;~ {
;~ asda=400
;~ dfgfd=300
;ToolTip, % "Points: " RandomBezier(0,0, asda+Rand(5,40), dfgfd+Rand(3,31), "T600 RO" )
;~ RandomBezier(0,0,Floor(asda / 3), Floor(dfgfd / 3), "T600 RO" )
;~ }

;~ F11:: ToolTip, % "Points: " RandomBezier( 0, 0, 400, 300, "T600 RO" )




RandomBezier( X0, Y0, Xf, Yf, O="" ) {
    Time := RegExMatch(O,"i)T(\d+)",M)&&(M1>0)? M1: 200
    RO := InStr(O,"RO",0) , RD := InStr(O,"RD",0)
    N:=!RegExMatch(O,"i)P(\d+)(-(\d+))?",M)||(M1<2)? 2: (M1>19)? 19: M1
    If ((M:=(M3!="")? ((M3<2)? 2: ((M3>19)? 19: M3)): ((M1=="")? 5: ""))!="")
        Random, N, %N%, %M%
    OfT:=RegExMatch(O,"i)OT(-?\d+)",M)? M1: 100, OfB:=RegExMatch(O,"i)OB(-?\d+)",M)? M1: 100
    OfL:=RegExMatch(O,"i)OL(-?\d+)",M)? M1: 100, OfR:=RegExMatch(O,"i)OR(-?\d+)",M)? M1: 100
    MouseGetPos, XM, YM
    If ( RO )
        X0 += XM, Y0 += YM
    If ( RD )
        Xf += XM, Yf += YM
    If ( X0 < Xf )
        sX := X0-OfL, bX := Xf+OfR
    Else
        sX := Xf-OfL, bX := X0+OfR
    If ( Y0 < Yf )
        sY := Y0-OfT, bY := Yf+OfB
    Else
        sY := Yf-OfT, bY := Y0+OfB
    Loop, % (--N)-1 {
        Random, X%A_Index%, %sX%, %bX%
        Random, Y%A_Index%, %sY%, %bY%
    }
    X%N% := Xf, Y%N% := Yf, E := ( I := A_TickCount ) + Time
    While ( A_TickCount < E ) {
        U := 1 - (T := (A_TickCount-I)/Time)
        Loop, % N + 1 + (X := Y := 0) {
            Loop, % Idx := A_Index - (F1 := F2 := F3 := 1)
                F2 *= A_Index, F1 *= A_Index
            Loop, % D := N-Idx
                F3 *= A_Index, F1 *= A_Index+Idx
            M:=(F1/(F2*F3))*((T+0.000001)**Idx)*((U-0.000001)**D), X+=M*X%Idx%, Y+=M*Y%Idx%
        }
        MouseMove, %X%, %Y%, 0
        Sleep, 1
    }
    MouseMove, X%N%, Y%N%, 0
    Return N+1
}





MoveMouse(X, Y, Speed=25) {
	
	T := A_MouseDelay
	
	SetMouseDelay, -1
	
	MouseGetPos, CX, CY
	
	Pts := Round(Sqrt((X - CX)**2 + (Y - CY)**2) / Rand(0,3) ,0)
	
	Loop %Pts% {
		
		Random, NX, % CX - ((CX - X) / Pts) * (A_Index - 1)
		
                , % CX - ((CX - X) / Pts) * A_Index
		
		Random, NY, % CY - ((CY - Y) / Pts) * (A_Index - 1)
		
                , % CY - ((CY - Y) / Pts) * A_Index
		
		MouseMove, % NX, % NY, % Speed
		
	}
	
	MouseMove, % X, % Y, % Speed
	
	SetMouseDelay, % T
	
}

Rand(x,y) {
	Random, rand, %x%, %y%
	Return rand
}