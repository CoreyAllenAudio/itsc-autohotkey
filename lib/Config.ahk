#Requires AutoHotkey v2.0

class Config {

    static _Path => A_ScriptDir "\config.ini"

    static Get(section, key, fallback) {
        return IniRead(this._Path, section, key, fallback)
    }

}
