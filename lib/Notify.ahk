#Requires AutoHotkey v2.0

class Notify {

    static Info(message) {
        MsgBox(message, "Info", "Iconi")
    }

    static Error(message) {
        MsgBox(message, "Error", "Iconx")
    }

}
