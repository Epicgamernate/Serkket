@echo off
if not exist Servers (
md Servers
)
cd Servers
Title Serkket Server Builder v1.2
::It's pronounced "Circut" not "sEErket"
color 03
cls
set A=Server
echo Some Servers are:
echo.
dir /B /A:D
echo.
echo You can create a new one by typing the name of the one you want to create
set /p A=Server: 
if not exist .\"%A%" (
mkdir .\"%A%"
echo Downloading Server files... please wait
)
cd "%A%"
if not exist spigot-1.16.5.jar (
curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
java -jar BuildTools.jar --rev 1.16.5
del /F BuildTools.jar
)
if not exist Tunnel.exe (
curl -o Tunnel.exe -s -S --url https://playit.gg/downloads/playit-win_64-0.4.2-rc1.exe
)
cls
echo Building Other files... Please wait
if not exist eula.txt (
echo eula=true>eula.txt
)
Title %A% 1.16.5 - Serkket
start Tunnel.exe
java -Xmx4G -XX:+UnlockExperimentalVMOptions -jar spigot-1.16.5.jar nogui
taskkill /F /IM Tunnel.exe
pause