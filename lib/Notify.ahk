#Requires AutoHotkey v2.0

; Notify: one place to show messages to the user.
class Notify {

    ; MsgBox(Text, Title, Options): "Iconi" shows the info icon.
    static Info(message) {
        MsgBox(message, "Info", "Iconi")
    }

    ; "Iconx" shows the red error icon.
    static Error(message) {
        MsgBox(message, "Error", "Iconx")
    }

}
