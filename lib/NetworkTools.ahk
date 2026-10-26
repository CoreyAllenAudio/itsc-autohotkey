#Requires AutoHotkey v2.0

; Use Window Spy to get the correct CMD/Terminal name.
OpenTerminal(command) {
    Run("cmd.exe")
    WinWaitActive("ahk_exe cmd.exe")
    SendInput(command)
}

; CMD Ping User. Checking whether a device responds to ICMP.
PingUser() {
    OpenTerminal("ping ")
}

; CMD NSLookup User. Investigating DNS resolution.
NSLookUpUser() {
    OpenTerminal("nslookup ")
}

; CMD Tracert User. Investigating the route without waiting for reverse DNS lookups.
TracertUser() {
    OpenTerminal("tracert -d ")
}
