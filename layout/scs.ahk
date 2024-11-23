
; SCS Software
; Euro Truck Simulator 2
; American Truck Simulator

; do not replace running instance because status for funstions would reset
#SingleInstance Ignore

; 'Console'
toggleConsole := "{^}"

; disable default console key
#InputLevel 1
^::return
#InputLevel 0

; true or false status for many functions
statusMap := Map()

#HotIf WinActive("Euro Truck Simulator 2") or WinActive("American Truck Simulator")

; 'Console'
^^::SendInput "{^}"

; 'Hazard Warning'
NumpadEnter::toggle("lights_hazard", "{NumpadEnter}", 1)
; 'Beacon'
o::toggle("lights_beacon", "{o}", 2)

; 'Suspension Reset'
r::activate("suspension_reset", "{r}", 1)


#HotIf

; activate a function
; function
; name of the function, used for audio file
; input
; this input is send to activate the function
; sound := 0
; do not play audio
; sound := 1
; play audio
activate(function, input, sound) {
    if(sound >= 1) {
        SoundPlay "..\audio\scs\" function ".mp3"
    }
    SendInput input
}

; toggle a function
; function
; name of the function, used for audio file
; input
; this input is send to toggle a function
; sound := 0
; do not play audio
; sound := 1
; play audio only on activation
; sound := 2
; play audio on activation and deactivation
toggle(function, input, sound) {
    if(status(function) and sound >= 1) {
        SoundPlay "..\audio\scs\" function "_activate.mp3"
    }
    else if(sound >= 2) {
        SoundPlay "..\audio\scs\" function "_deactivate.mp3"
    }
    SendInput input
}

; invert and return status
status(function) {
    if !statusMap.Has(function) {
        statusMap.Set(function, true)
        return true
    }
    statusMap.Set(function, !statusMap.Get(function))
    return statusMap.Get(function)
}

#Include ..\exit\exit.ahk
