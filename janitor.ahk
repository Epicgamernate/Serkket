#NoEnv
; #Warn
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%
; JANITOR (Used for autoupdate)
; Use for ur own programs at will
; Start
FileDelete, %A_ScriptDir%\Serkket.exe ; Delete old version of software
Progdwnld: ; Label, in case of download fail
UrlDownloadToFile, https://github.com/Epicgamernate/Serkket/releases/latest/download/Serkket.exe, Serkket.exe ; Download new version of software
; Check if download failed, if it did, redownload
if !FileExist("Serkket.exe") { 
Goto, Progdwnld
}
; End of check
FileDelete, %A_ScriptDir%\*.sver ; Get rid of temporary files downloaded from program
Run, Serkket.exe ; Open new version of program
ExitApp, 0 ; Exit