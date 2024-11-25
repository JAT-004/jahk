
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

; KEY DEFINITION

; load original key definition
#Include ..\scs\key_original.ahk
; load remapped key definition
#Include ..\scs\key_remap.ahk
; load user configuration file
#Include ..\scs\config.ahk

_wipersAutomatic() {
    audioIf("wipers_automatic", wipersAudio)
    loopKey(wipers_back, 3, 5)
    sendKeys([wipers])
}

_suspensionFrontUp() {
    suspension([suspension_front_up], "suspension_front_up")
}
_suspensionFrontDown() {
    suspension([suspension_front_down], "suspension_front_down")
}

_suspensionRearUp() {
    suspension([suspension_rear_up], "suspension_rear_up")
}
_suspensionRearDown() {
    suspension([suspension_rear_down], "suspension_rear_down")
}

_suspensionUp() {
    suspension([suspension_rear_up, suspension_front_up], "suspension_up")
}
_suspensionDown() {
    suspension([suspension_rear_down, suspension_front_down], "suspension_down")
}

_suspensionReset() {
    audioIf("suspension_reset", suspensionAudio)
    sendKeys([suspension_reset])
}

#HotIf

; END KEY DEFINITION

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

; FUNCTION

; play audio if name is not an empty string
; audioName
; name of the audio file, or empty string
audio(audioName) {
    if(audioName) {
        SoundPlay "..\audio\scs\" audioName ".mp3"
    }
}

; play audio if the status is true
; audioName
; name of the audio file, or empty string
; status
; true when audio should play
audioIf(audioName, status) {
    if(status) {
        audio(audioName)
    }
}

; hold one or more keys for a specific time
; inputArray
; list of inputs that should be hold at the same time
; duration
; duration in ms
holdKeys(inputArray, duration) {
    for key in inputArray {
        keyDown := "{" key " down}"
        keyUp := "{" key " up}"

        Send keyUp
        Send keyDown
    }
    Sleep duration

    for key in inputArray {
        keyUp := "{" key " up}"
        Send keyUp
    }
}

; send one or more keys
; inputArray
; list of inputs that should be send
sendKeys(inputArray) {
    for key in inputArray {
        inputKey := "{" key "}"
        Send inputKey
    }
}

; repeat a key several times
; input
; the input key
; count
; number of repetitions
; delay
; delay in ms between keys
loopKey(input, count, delay) {
    loop count {
        Sleep delay
        sendKeys([input])
    }
    Sleep delay
}

; adjust suspension by holding relevant keys automatically
; inputArray
; list of inputs that should be hold at the same time
; audioName
; name of the audio file
suspension(inputArray, audioName) {
    audioIf(audioName, suspensionAudio)
    holdKeys(inputArray, suspensionDuration)
}

; END FUNCTION

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
