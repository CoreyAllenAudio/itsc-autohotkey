#Requires AutoHotkey v2.0

; Validate: checks and normalizes text pasted in from tickets and tools.
class Validate {

    ; Accepts anything. Strips spaces, tabs and line breaks from both ends.
    static Clean(text) {
        if IsObject(text)
            throw TypeError("Validate.Clean expects a string or number, not an object")
        return Trim(text, " `t`r`n")
    }

    ; 2-6 letters then 5-10 digits, like INC0012345. Returned uppercased.
    static TicketNumber(text) {
        text := this.Clean(text)
        if !RegExMatch(text, "i)^[a-z]{2,6}\d{5,10}\z")
            throw ValueError("Invalid ticket number")
        return StrUpper(text)
    }

    ; Four numbers 0-255 separated by dots. Returned as given (after Clean).
    static IPv4(text) {
        text := this.Clean(text)
        octet := "(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)"
        if !RegExMatch(text, "^(?:" octet "\.){3}" octet "\z")
            throw ValueError("Invalid IPv4 address")
        return text
    }

    ; Letters, digits, hyphens and dots. Prevents option injection. Returned lowercased.
    static Hostname(text) {
        text := this.Clean(text)
        if StrLen(text) > 253
            throw ValueError("Hostname too long")
        label := "[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?"
        if !RegExMatch(text, "i)^" label "(?:\." label ")*\z")
            throw ValueError("Invalid hostname")
        return StrLower(text)
    }

}
