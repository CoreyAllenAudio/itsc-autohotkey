#Requires AutoHotkey v2.0
#SingleInstance Force
#Include <Config>
#Include <Notify>

^!1:: { ; Ctrl + Alt + 1
    name := Config.Get("User", "name", "Default Name")
    Notify.Info("Hello, " name "!")
}
