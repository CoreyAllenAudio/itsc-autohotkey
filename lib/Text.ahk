#Requires AutoHotkey v2.0

; Text: builds note text from templates.
class Text {

    ; Replaces each {key} in template with values[key].
    static Fill(template, values) {
        if !(values is Map)    ; Verify that values is a Map.
            throw TypeError("Text.Fill expects a Map of values")

        result := ""
        pos := 1    ; AHK strings start at position 1, not 0.

        ; \{([^{}\s]+)\} matches {key}.
        while RegExMatch(template, "\{([^{}\s]+)\}", &m, pos) {
            key := m[1]
            if !values.Has(key)
                throw ValueError("Unfilled placeholder: {" key "}")

            ; Keep the text before the placeholder, then add the value.
            result .= SubStr(template, pos, m.Pos - pos) values[key]
            pos := m.Pos + m.Len
        }
        return result SubStr(template, pos)    ; Whatever is left after the last placeholder.
    }

    ; Current date and time, like 2026-11-14 15:30.
    static Timestamp() {
        return FormatTime(, "yyyy-MM-dd HH:mm")
    }

}
