
; Euro Truck Simulator 2

; replace already running instance
#SingleInstance Force
; run main script
Run "scs.ahk"

; 'Cruise Control Speed Increase'
cruiseControl_increase := "{Numpad1}"
; 'Cruise Control Speed Decrease'
cruiseControl_decrase := "{Numpad0}"

; on true use cruise control sound
cruiseControl_sound := true
; time between key presses in ms
cruiseControl_delay := 5

#HotIf WinActive("Euro Truck Simulator 2")

; cruise control
3::cruiseControl(30)
4::cruiseControl(35)
5::cruiseControl(40)
6::cruiseControl(45)
7::cruiseControl(50)
8::cruiseControl(55)
9::cruiseControl(60)
0::cruiseControl(65)

#HotIf

cruiseControl(kmh) {
    if(cruiseControl_sound) {
        SoundPlay "..\audio\scs\speed_" kmh ".mp3"
    }

    ; increase to maximum 90 km/h
    loopKey(13, cruiseControl_delay, cruiseControl_increase)
    ; decrease to desired speed
    loopKey(18 - kmh / 5, cruiseControl_delay, cruiseControl_decrase)
}

; custom loop
loopKey(count, delay, key) {
    loop count {
        Sleep delay
        SendInput key
    }
}

#Include ..\exit\exit.ahk
