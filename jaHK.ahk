
; jaHK

; replace already running instance
#SingleInstance Force

; include send exit command function
#Include exit\send.ahk

; true
; load all scripts, no manual switching required
; false
; switch manually between layouts
loadAll := false

; only relevant when loadAll is set to false
; true
; script starts with layout selection mode running
; false
; script starts with layout default
selectionMode := true

; only relevant when loadAll is set to false
; true
; play sound when layout is selected
; false
; do not play sound when layout is selected
playSound := true

if(loadAll) {

    ; American Truck Simulator
    Run "layout\ats.ahk"
    ; Euro Truck Simulator 2
    Run "layout\ets.ahk"

} else if(!selectionMode) {
    selectLayout("default")
}

; enable manual layout switching
#HotIf !loadAll

; key to exit current layout and enter selection mode
^NumpadEnter::exitLayout()

; define keys for selection of a specific layout
#HotIf !loadAll and selectionMode

a::selectLayout("ats")
e::selectLayout("ets")

d::selectLayout("default")

#HotIf

; enter selection mode
exitLayout() {
    global selectionMode := true

    ; close current layout
    sendExit()
}

; exit selection mode and enter activates layout
selectLayout(layoutName) {
    global selectionMode := false

    ; play sound
    SoundPlay "audio\layout\" layoutName ".mp3"
    ; open layout
    Run "layout\" layoutName ".ahk"
}
