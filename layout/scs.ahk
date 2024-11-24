
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

; 'Rear Suspension Up'
q::holdKey(["q"], 3500, "suspension_up_rear")
; 'Rear Suspension Down'
a::holdKey(["a"], 3500, "suspension_down_rear")
; 'Rear Suspension Up' and 'Front Suspension Up'
w::holdKey(["q", "w"], 3500, "suspension_up")
; 'Rear Suspension Down' and 'Front Suspension Down'
s::holdKey(["a", "s"], 3500, "suspension_down")

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

; hold a key for a specific time
; inputArray
; list of inputs that should be hold at the same time
; time
; duration in ms
; sound
; name of the function used for playing sound, or empty string
holdKey(inputArray, time, function) {
    if(function) {
        SoundPlay "..\audio\scs\" function ".mp3"
    }

    for key in inputArray {
        keyDown := "{" key " down}"
        Send keyDown
    }
    Sleep time

    for key in inputArray {
        keyUp := "{" key " up}"
        Send keyUp
    }
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
