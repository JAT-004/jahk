
; American Truck Simulator

; replace already running instance
#SingleInstance Force
; run main script
Run "scs.ahk"

#HotIf WinActive("American Truck Simulator")

#HotIf
#Include ..\exit\exit.ahk
