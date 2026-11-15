#Requires AutoHotkey v2.0

; Config: reads settings from config.ini.
class Config {

    ; _Path is a property, not a variable: "=>"
    static _Path => A_ScriptDir "\config.ini"

    ; Returns the value of key under [section]
    static Get(section, key, fallback) {
        return IniRead(this._Path, section, key, fallback)
    }

}
