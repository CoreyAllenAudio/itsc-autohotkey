#Requires AutoHotkey v2.0
#Include <Greetings>
#Include <NetworkTools>

; This script includes the Greetings library for testing.
; CTRL + ALT + 1 will trigger the SayHello function from the Greetings library.
^!1:: SayHello(A_UserName)

; CTRL + ALT + 2 will trigger the PingUser function from the NetworkTools library.
^!2:: PingUser()

; CTRL + ALT + 3 will trigger the NSLookUpUser function from the NetworkTools library.
^!4:: NSLookUpUser()

; CTRL + ALT + 4 will trigger the TracertUser function from the NetworkTools library.
^!5:: TracertUser()
