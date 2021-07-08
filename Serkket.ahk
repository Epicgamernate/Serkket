#NoEnv
; #Warn
#SingleInstance Force
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
InputBox, UserInput, Server, Please enter the name of a server you want to run `n Some available servers are: `n %List% `n You can also make a new one by typing its name `n No Spaces! `n Will not work on onedrive folders!, , 640, 480
if ErrorLevel
ExitApp 0
else
if !FileExist(%UserInput%) {
Gui, SelectServers:New, +Resize +MinSize480x240 +HwndSelectServersHwnd, Server Software
Gui, SelectServers:Color, 707070
Gui, Add, Text,, Please enter the version of minecraft you want:
Gui, SelectServers:Add, DropDownList, vServSoft, Paper (Plugins+)||Spigot (Plugins)|Fabric (Mods)
Gui, SelectServers:Add, DropDownList, vServVers, 1.17.1||1.17|1.16.5|1.16.4|1.16.3|1.16.2|1.16.1|1.15.2|1.15.1|1.15|1.14.4|1.14.3|1.14.2|1.14.1|1.14|1.13.2|1.13.1|1.13|1.12.2|1.12.1|1.12|1.11.2|1.11.1|1.11|1.10.2|1.9.4|1.9.2|1.9|1.8.8|1.8.3|1.8
Gui, SelectServers:Add, Button, Default w80 gSelectServersButtonOK, OK
Gui, SelectServers:Show
WinWaitClose, ahk_id %SelectServersHwnd%
}
SetWorkingDir %UserInput%
if (ServSoft = "Spigot (Plugins)") {
Spig:
if !FileExist("spigot-%ServVers%.jar") {
UrlDownloadToFile, https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar, BuildTools.jar
RunWait, cmd.exe /c "java -jar BuildTools.jar --rev %ServVers% && cls && pause"
}
if !FileExist("spigot-%ServVers%.jar") {
Goto, Spig
}
} else  if ( ServSoft = "Fabric (Mods)" ) {
Fabric:
if !FileExist("fabric-server-launch.jar") {
UrlDownloadToFile, https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.7.4/fabric-installer-0.7.4.jar, Installer.jar
RunWait, cmd.exe /c "java -jar installer.jar server -mcversion %ServVers% -downloadMinecraft"
}
if !FileExist("fabric-server-launch.jar") {
Goto, Fabric
}
} else {
paper:
if !FileExist("paper.jar") {
UrlDownloadToFile, https://papermc.io/api/v2/projects/paper/versions/1.17.1/builds/90/downloads/paper-1.17.1-90.jar, paper.jar
}
if !FileExist("paper.jar") {
Goto, paper
}
}
Tunnel:
if !FileExist("Tunnel.exe") {
UrlDownloadToFile, https://playit.gg/downloads/playit-win_64-0.4.4.exe, Tunnel.exe
}
if !FileExist("Tunnel.exe") {
Goto, Tunnel
}
if !FileExist("eula.txt") {
FileAppend, eula=true, eula.txt
}
if ( ServSoft = "Spigot (Plugins)" ) {
if !FileExist("Run.bat") {
FileAppend,
(
@echo off
color 0A
title %UserInput% Server - Serkket ALPHA 6
cls
echo Starting %UserInput% Server...
start Tunnel.exe
java -server -Xmx4G -XX:+UnlockExperimentalVMOptions -jar spigot-%ServVers%.jar nogui
color 04
echo Server stopped
taskkill /f /im Tunnel.exe > nul
pause>nul
exit /B
), Run.Bat
}
} else if ( ServSoft = "Fabric (Mods)" ) {
if !FileExist("Run.bat") {
FileAppend,
(
@echo off
color 0A
title %UserInput% Server - Serkket ALPHA 6
cls
echo Starting %UserInput% Server...
start Tunnel.exe
java -server -Xmx4G -XX:+UnlockExperimentalVMOptions -jar fabric-server-launch.jar nogui
color 04
echo Server stopped
taskkill /f /im Tunnel.exe > nul
pause>nul
exit /B
), Run.Bat
}
} else {
if !FileExist("Run.bat") {
FileAppend,
(
@echo off
color 0A
title %UserInput% Server - Serkket ALPHA 6
cls
echo Starting %UserInput% Server...
start Tunnel.exe
java -server -Xmx4G -XX:+UnlockExperimentalVMOptions -jar paper.jar nogui
color 04
echo Server stopped
taskkill /f /im Tunnel.exe > nul
pause>nul
exit /B
), Run.Bat
}
}
Run, Run.Bat
return
SelectServersButtonOK:
Gui, SelectServers:Submit
MsgBox, 0, Serkket Servers, Server will build files, press ok to continue `n Server will open when done
FileCreateDir, %UserInput%
Gui, SelectServers:Destroy
return
SelectServersGuiClose:
SelectServersGuiEscape:
Gui, SelectServers:Destroy
ExitApp, 0
