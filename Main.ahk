#Requires AutoHotkey v2.0
#SingleInstance Force ; Re-running the script replaces the old copy instead of asking.
#Include <Config>
#Include <Notify> ; <Name> (angle brackets) loads a library file from the Lib folder

; Hotkeys: ^ = Ctrl, ! = Alt, + = Shift, # = Win.
^!1:: { ; Ctrl + Alt + 1
    name := Config.Get("User", "name", "Default Name")
    Notify.Info("Hello, " name "!")
}
