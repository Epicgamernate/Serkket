#NoEnv
; #Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
if !FileExist("Servers") {
FileCreateDir, Servers
}
SetWorkingDir Servers
; It's pronounced "Circut" not "sEErket"
RunWait cmd.exe /c "dir /B /A:D>List.txt"
FileRead, List, List.txt
FileDelete, List.txt
InputBox, UserInput, Server, Please enter the name of a server you want to run `n Some available servers are: `n %List% `n You can also make a new one by typing its name, , 640, 480
if ErrorLevel
ExitApp 0
else
MsgBox, 0, Serkket Servers, Server will build files, press ok to continue
if !FileExist(%UserInput%) {
FileCreateDir, %UserInput%
}
SetWorkingDir %UserInput%
if !FileExist("spigot-1.16.5.jar") {
UrlDownloadToFile, https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar, BuildTools.jar
RunWait, BuildTools.jar --rev 1.16.5
}
if !FileExist("Tunnel.exe") {
UrlDownloadToFile, https://playit.gg/downloads/playit-win_64-0.4.3-rc2.exe, Tunnel.exe
}
if !FileExist("eula.txt") {
FileAppend, eula=true, eula.txt
}
if !FileExist("Run.bat") {
FileAppend,
(
@echo off
color 0A
title %UserInput% Server - Spigot ALPHA 1.3.1
cls
echo Starting %UserInput% Server...
start Tunnel.exe
java -server -Xmx1G -XX:+UnlockExperimentalVMOptions -jar spigot-1.16.5.jar nogui
color 04
echo Server stopped
pause>nul
taskkill /f /im Tunnel.exe
exit /B
), Run.Bat
}
Run, Run.Bat

