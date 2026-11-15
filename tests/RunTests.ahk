#Requires AutoHotkey v2.0
#Include "..\lib\Validate.ahk"
#Include "..\lib\Text.ahk"
; RunTests: calls the lib methods with good and bad input.

passed := 0
failures := []

/*
    Passes if actual equals expected. Uses == because in AHK = compares
    text case-insensitively, so "inc" = "INC" is true. That would hide
    uppercasing bugs.
*/
Check(label, fn, expected) {
    global passed
    try {
        actual := fn()
    } catch Error as e {
        failures.Push(label ": threw " Type(e) ": " e.Message)
        return
    }
    if (actual == expected)
        passed++
    else
        failures.Push(label ": got [" actual "] expected [" expected "]")
}

/*
    Verifies that the function throws an error of the expected type.
    If no type is given, ValueError is assumed.
*/
CheckThrows(label, fn, expectedType := ValueError) {
    global passed
    try {
        fn()
    } catch Error as err {
        if err is expectedType {
            passed++
        } else {
            failures.Push(
                label . ": unexpected error type: " . Type(err)
                . " — " . err.Message
            )
        }
        return
    }
    failures.Push(label . ": expected an error, none thrown")
}

; --- Validate.Clean ---
Check("Clean valid", () => Validate.Clean("hello"), "hello")
Check("Clean empty", () => Validate.Clean(""), "")
Check("Clean spaces", () => Validate.Clean("  hi  "), "hi")
Check("Clean tabs", () => Validate.Clean("`thi`t"), "hi")
Check("Clean trailing line break", () => Validate.Clean("hi`r`n"), "hi")
Check("Clean line break in middle kept", () => Validate.Clean("a`nb"), "a`nb")
Check("Clean number", () => Validate.Clean(42), "42")
CheckThrows("Clean object", () => Validate.Clean([1, 2]), TypeError)

; --- Validate.TicketNumber ---
Check("Ticket valid", () => Validate.TicketNumber("INC0012345"), "INC0012345")
CheckThrows("Ticket empty", () => Validate.TicketNumber(""))
Check("Ticket lowercase", () => Validate.TicketNumber("inc0012345"), "INC0012345")
Check("Ticket spaces", () => Validate.TicketNumber("  INC0012345  "), "INC0012345")
Check("Ticket trailing line break", () => Validate.TicketNumber("INC0012345`r`n"), "INC0012345")
CheckThrows("Ticket line break in middle", () => Validate.TicketNumber("INC`n0012345"))
Check("Ticket min length", () => Validate.TicketNumber("AB12345"), "AB12345")
Check("Ticket max length", () => Validate.TicketNumber("ABCDEF1234567890"), "ABCDEF1234567890")
CheckThrows("Ticket 1 letter", () => Validate.TicketNumber("A12345"))
CheckThrows("Ticket 7 letters", () => Validate.TicketNumber("ABCDEFG12345"))
CheckThrows("Ticket 4 digits", () => Validate.TicketNumber("INC1234"))
CheckThrows("Ticket 11 digits", () => Validate.TicketNumber("INC12345678901"))

; --- Validate.IPv4 ---
Check("IPv4 valid", () => Validate.IPv4("10.0.0.1"), "10.0.0.1")
CheckThrows("IPv4 empty", () => Validate.IPv4(""))
Check("IPv4 spaces", () => Validate.IPv4("  192.168.1.1  "), "192.168.1.1")
Check("IPv4 trailing line break", () => Validate.IPv4("192.168.1.1`n"), "192.168.1.1")
CheckThrows("IPv4 line break in middle", () => Validate.IPv4("192.168`n.1.1"))
Check("IPv4 max", () => Validate.IPv4("255.255.255.255"), "255.255.255.255")
CheckThrows("IPv4 256", () => Validate.IPv4("256.1.1.1"))
CheckThrows("IPv4 three parts", () => Validate.IPv4("1.2.3"))
CheckThrows("IPv4 five parts", () => Validate.IPv4("1.2.3.4.5"))
CheckThrows("IPv4 empty part", () => Validate.IPv4("1..2.3"))
CheckThrows("IPv4 leading zero", () => Validate.IPv4("010.0.0.1"))
CheckThrows("IPv4 letters", () => Validate.IPv4("a.b.c.d"))

; --- Validate.Hostname ---
Check("Hostname valid", () => Validate.Hostname("pc-0042.corp.local"), "pc-0042.corp.local")
CheckThrows("Hostname empty", () => Validate.Hostname(""))
Check("Hostname uppercase lowered", () => Validate.Hostname("PC-0042"), "pc-0042")
Check("Hostname spaces", () => Validate.Hostname("  pc-0042  "), "pc-0042")
Check("Hostname trailing line break", () => Validate.Hostname("pc-0042`r`n"), "pc-0042")
CheckThrows("Hostname line break in middle", () => Validate.Hostname("pc`n0042"))
CheckThrows("Hostname underscore", () => Validate.Hostname("pc_0042"))
CheckThrows("Hostname inner space", () => Validate.Hostname("my pc"))
CheckThrows("Hostname leading hyphen", () => Validate.Hostname("-t"))
CheckThrows("Hostname trailing hyphen", () => Validate.Hostname("pc-"))
CheckThrows("Hostname only a dot", () => Validate.Hostname("."))
CheckThrows("Hostname leading dot", () => Validate.Hostname(".pc"))
CheckThrows("Hostname trailing dot", () => Validate.Hostname("pc."))
CheckThrows("Hostname double dot", () => Validate.Hostname("a..b"))
CheckThrows("Hostname label starts with hyphen", () => Validate.Hostname("a.-b.c"))
Check("Hostname single character", () => Validate.Hostname("a"), "a")
long := ""
loop 126
    long .= "a."        ; "a.a.a. ..." = 252 characters
long .= "a"             ; 253, exactly at the limit
Check("Hostname 253 chars", () => Validate.Hostname(long), long)
CheckThrows("Hostname 254 chars", () => Validate.Hostname(long "a"))

; --- Text.Fill ---
Check("Fill one key", () => Text.Fill("Ticket {ticket}", Map("ticket", "INC0012345")), "Ticket INC0012345")
Check("Fill repeated key", () => Text.Fill("{a}-{a}", Map("a", "x")), "x-x")
Check("Fill no placeholders", () => Text.Fill("plain note", Map()), "plain note")
Check("Fill empty template", () => Text.Fill("", Map()), "")
Check("Fill multiline", () => Text.Fill("{a}`n{b}", Map("a", "1", "b", "2")), "1`n2")
Check("Fill number value", () => Text.Fill("{n}", Map("n", 5)), "5")
Check("Fill extra keys ignored", () => Text.Fill("{a}", Map("a", "1", "b", "2")), "1")
Check("Fill braces in value kept", () => Text.Fill("{a}", Map("a", "{b}", "b", "X")), "{b}")
CheckThrows("Fill missing key throws", () => Text.Fill("Ticket {ticket}", Map()))
CheckThrows("Fill key case mismatch throws", () => Text.Fill("{Ticket}", Map("ticket", "x")))
CheckThrows("Fill non-Map throws", () => Text.Fill("{a}", "a"), TypeError)

; --- Text.Timestamp ---
Check("Timestamp format", () => RegExMatch(Text.Timestamp(), "^\d{4}-\d\d-\d\d \d\d:\d\d$"), 1)

; --- Summary ---
total := passed + failures.Length
summary := passed " of " total " passed"
for failure in failures
    summary .= "`n  FAIL " failure

/*
    FileAppend to "*" writes to the terminal (stdout). AutoHotkey64.exe is a
    windowed program, so that only works when the output is piped
    (| Out-String). Without a pipe FileAppend throws; the try with no catch
    ignores the error, printed stays false, and the summary box is shown.
*/
printed := false
if (A_Args.Length && A_Args[1] = "--console") {
    try {
        FileAppend(summary "`n", "*")
        printed := true
    }
}
if !printed
    MsgBox(summary, "Test results", failures.Length ? "Iconx" : "Iconi")

ExitApp(failures.Length ? 1 : 0)    ; Exit code 1 means a test failed, for scripts or CI that check it.
