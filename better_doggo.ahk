#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

global comboNames := ["PAT", "MULTIPAT", "OVERPAT", "PATTING SPREE", "PATTACULAR", "PATTING FRENZY", "PATTASTIC", "PATTING PALOOZA", "PATPOCALYPSE", "PATATHON"]
global currentCombo := 0
global highestCombo := 0
global totalPats := 0
global timeSpent := 0

Gui, Combo: Color, 0x010101
Gui, Combo: +E0x20 -caption +AlwaysOnTop +ToolWindow
Gui, Combo: Font, s30 cWhite, Impact
Gui, Combo: Add, Text, x8 y8 w281 h70 +0x200 +Center vComboNumber
Gui, Combo: Font, s30  cRed, Impact
Gui, Combo: Add, Text, x8 y72 w281 h70 +0x200 +Center vComboName

Gui, HighCombo: Color, 0x010101
Gui, HighCombo: +E0x20 -caption +AlwaysOnTop +ToolWindow
Gui, HighCombo: Font, s30 cWhite, Impact
Gui, HighCombo: Add, Text, x8 y8 w433 h105 +0x200 vHighestComboGUI

Gui, NumPats: Color, 0x010101
Gui, NumPats: +E0x20 -caption +AlwaysOnTop +ToolWindow
Gui, NumPats: Font, s30 cBlue, Impact
Gui, NumPats: Add, Text, x8 y8 w433 h130 +0x200 vPatNum

Gui, PatTimer: Color, 0x010101
Gui, PatTimer: +E0x20 -caption +AlwaysOnTop +ToolWindow
Gui, PatTimer: Font, s45 cWhite, Impact
Gui, PatTimer: Add, Text, x8 y8 w433 h105 +0x200 +Center vPatTime
Gui, PatTimer: Font, s20, Impact
Gui, PatTimer: Add, Text, x8 y120 w433 h45 +0x200 +Center vOneTimeThing
Return

7::
    Gui, NumPats: Show , x200 y150 NoActivate, NumPats
    WinSet, Transparent, 255, NumPats
    WinSet, TransColor, 010101, NumPats

    Gui, PatTimer: Show, % "xCenter " "y" A_ScreenHeight-300 " NoActivate", PatTimer
    WinSet, Transparent, 255, PatTimer
    WinSet, TransColor, 010101, PatTimer

    Gui, Combo: Show, NoActivate, Combo
    WinSet, Transparent, 255, Combo
    WinSet, TransColor, 010101, Combo

    Gui, HighCombo: Show, % "x"A_ScreenWidth-500 " y"300 " NoActivate", HighCombo
    WinSet, Transparent, 255, HighCombo
    WinSet, TransColor, 010101, HighCombo

    SetTimer, patDog, 1300
    SetTimer, timePatting, 100
    GuiControl PatTimer:, OneTimeThing, TIME SPENT PATTING
    Gosub, patDog
Return

patDog:
    Send, {e down}
    Sleep 400
    Send, {e up}
    send, s
    totalPats += 1
    GuiControl NumPats:, PatNum, PATS GIVEN: %totalPats%
    Random, rand, 1, 100
    if (rand >= 20)
        succesfulPat()
    Else 
        failedPat()
Return

succesfulPat() 
{
    currentCombo += 1
    GuiControl Combo:, ComboNumber, COMBO X%currentCombo%
    if (currentCombo >= 10)
        GuiControl Combo:, ComboName, % comboNames[10]
    else 
        GuiControl Combo:, ComboName, % comboNames[currentCombo]
    if (currentCombo > highestCombo)
    {
        highestCombo := currentCombo
        GuiControl HighCombo:, HighestComboGUI, Highest Combo X%highestCombo%
    }
}

failedPat() 
{
    currentCombo := 0
    GuiControl Combo:, ComboNumber, COMBO X%currentCombo%
    GuiControl Combo:, ComboName
}

timePatting:
    timeSpent += 1
    currentTime := formatTime(timeSpent)
    GuiControl PatTimer:, PatTime, %currentTime%
return 

formatTime(numberOfTenthsOfSeconds)
{
    numSeconds := Floor(numberOfTenthsOfSeconds/10)
    numHours := Floor(numSeconds/3600)
    numMinutes := Mod((Floor(numSeconds/60)), 60)
    numSeconds := Mod(numSeconds, 60)
    numMS := Mod(numberOfTenthsOfSeconds, 10)
    numHours := Format("{:03}", numHours)
    numMinutes := Format("{:02}", numMinutes)
    numSeconds := Format("{:02}", numSeconds)
    returnVal = %numHours%:%numMinutes%:%numSeconds%.%numMS%
    return returnVal
}

8::Reload