@echo off

color 2
mkdir "C:\sigil_filedump" 2>nul
cd "C:\sigil_filedump"
Reg.exe add "HKCU\CONSOLE" /v "VirtualTerminalLevel" /t REG_DWORD /d "1" /f  > nul
cls
echo. %b% 
echo =========================================
echo         Loading Sigil's Tweaks...
echo      This may take a moment to load.
echo =========================================
echo.

curl -g -k -L -# -o "C:\sigil_filedump\autoruns.exe" "https://cdn.discordapp.com/attachments/1198488853519011850/1201013714405572638/autoruns.exe?ex=65c8462f&is=65b5d12f&hm=90f23e8601cc1abc3961bc4b2d2fd169b33ed3954e0b9b2dd15c590c87b1e58a&"
timeout /t 1 /nobreak > NUL


curl -g -k -L -# -o "C:\sigil_filedump\SigilsPowerPlan.pow" "https://cdn.discordapp.com/attachments/848936967998799913/1207837824779427850/SigilsPowerPlan.pow?ex=65e119a1&is=65cea4a1&hm=5a061efb497398b9aa2d3098091f2f95684966996489257648019a9e09439f8e&"

curl -g -k -L -# -o "C:\sigil_filedump\Update_Blocker.exe" "https://cdn.discordapp.com/attachments/1198488853519011850/1201013733963600054/Update_Blocker.exe?ex=65c84633&is=65b5d133&hm=50e37ca7618f3b6de630f308853a9897aa9c841b83791719398e2daad41eb549&"
timeout /t 1 /nobreak > NUL

cls

powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force"

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f >> APB_Log.txt
cls

setlocal EnableDelayedExpansion > nul
cls
title Sigil's Tweaks v1.0.0

:: Disable UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f >> APB_Log.txt
<nul set /p ".=%ESC%[4m" & set "ESC=%ESC:~0,-1%" <nul set /p ".=%ESC%[0m"

:MainMenu
color 2
cls
echo   ###### ####  ######   #### ##       ####  ######     ######## ##      ## ########    ###    ##    ##  ######  
echo ##    ##  ##  ##    ##   ##  ##       #### ##    ##       ##    ##  ##  ## ##         ## ##   ##   ##  ##    ## 
echo ##        ##  ##         ##  ##        ##  ##             ##    ##  ##  ## ##        ##   ##  ##  ##   ##       
echo  ######   ##  ##   ####  ##  ##       ##    ######        ##    ##  ##  ## ######   ##     ## #####     ######  
echo       ##  ##  ##    ##   ##  ##                  ##       ##    ##  ##  ## ##       ######### ##  ##         ## 
echo ##    ##  ##  ##    ##   ##  ##            ##    ##       ##    ##  ##  ## ##       ##     ## ##   ##  ##    ## 
echo  ######  ####  ######   #### ########       ######        ##     ###  ###  ######## ##     ## ##    ##  ######  v1.1.0

echo.
echo                          1. Delete Log Files / 2. Delete Temp Files / 3. Empty Recycle Bin
echo                          ===================================================================
echo                          4. Import Power Plan / 5. Autoruns / 6. Update Blocker / 7. Visuals
echo                          ===================================================================
echo                          8. Defragment Drives / 9. Disable Unnessecary Startup / 10. Debloat
echo.
echo                                                  E. Exit / S. Socials
echo.
echo                                                                                                 made by sigil / sigilic
echo.

set /p choice=Enter your choice (1-10): 

if "%choice%"=="1" goto Option1
if "%choice%"=="2" goto Option2
if "%choice%"=="3" goto Option3
if "%choice%"=="4" goto Option4
if "%choice%"=="5" goto Option5
if "%choice%"=="6" goto Option6
if "%choice%"=="7" goto Option7
if "%choice%"=="8" goto Option8
if "%choice%"=="9" goto Option9
if "%choice%"=="10" goto Option10
if "%choice%"=="E" goto :EOF
if "%choice%"=="e" goto :EOF
if "%choice%"=="S" goto OptionS
if "%choice%"=="s" goto OptionS

echo Invalid choice. Please type a number!
timeout /t 2 >nul
goto MainMenu

:Option1
cls
echo Option 1 Selected!
echo.
cd /D C:\
echo Deleting .log files...
del /s /q /f *.log
pause
goto MainMenu

:Option2
cls
echo Option 2 Selected!
echo.
echo Deleting Log Files...
del /s /q /f *.log
echo Log files deleted successfully.
pause
goto MainMenu

:Option3
cls
echo Option 3 Selected!
echo.
echo Emptying the Recycle Bin...
echo.
rd /s /q C:\$Recycle.Bin
echo.
echo Recycle Bin emptied successfully.
pause
goto MainMenu

:Option4
echo Option 4 Selected!
cls
@echo off
setlocal enabledelayedexpansion


:: Read the GUID from the downloaded power plan file
for /f "tokens=2 delims==" %%G in ('findstr "Power Setting Index" "C:\sigil_filedump\SigilsPowerPlan.pow"') do (
    set "PowerSchemeGUID=%%G"
    set "PowerSchemeGUID=!PowerSchemeGUID:~-36!"
)

:: Import the downloaded Power Plan
set "PowerPlanFile=%CD%\SigilsPowerPlan.pow"
set "PowerPlanDescription=Sigil's Ultimate Performance Power Plan"

:: Import the power plan
powercfg /import "%PowerPlanFile%" %PowerSchemeGUID%

powercfg /changedescription %PowerSchemeGUID% "Sigil's Ultimate Performance"
powercfg /changename 910622f1-b067-49b6-80ab-3ead5489b574 "Sigil's Ultimate Performance"
:: Activate the imported power plan
powercfg /setactive %PowerSchemeGUID%

cls

echo Power plan imported successfully! 
pause
goto MainMenu

:Option5
cls
start C:\sigil_filedump\autoruns.exe
goto MainMenu

:Option6
color 09
echo Option 6 Selected!
cls


start C:\sigil_filedump\Update_Blocker.exe

pause
goto MainMenu

:Option7
color 09
echo Option 7 Selected!
cls

%windir%\system32\SystemPropertiesPerformance.exe

goto MainMenu



:Option8
echo Option 8 Selected!
cls
echo Defragmenting Drives

POWERSHELL "Optimize-Volume -DriveLetter C -ReTrim"

pause

goto MainMenu

:Option9
echo Option 9 Selected!
cls
:: Disable unnecessary startup programs
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v UnnecessaryProgram /t REG_SZ /d "C:\Path\To\UnnecessaryProgram.exe" /f


:: Adjust visual effects for best performance
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search]
"AllowCortana"=dword:00000000
"DisableWebSearch"=dword:00000001



pause
goto MainMenu

:Option10
echo Option 10 Selected!
cls
color 06
@echo off
echo Debloating Script...

@echo off
setlocal enabledelayedexpansion



REM Disable telemetry and data collection
echo Disabling telemetry and data collection...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f

REM Disable Cortana
echo Disabling Cortana...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f

REM Disable Windows tips
echo Disabling Windows tips...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f

REM Disable OneDrive
echo Disabling OneDrive...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSync" /t REG_DWORD /d 1 /f



reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v "DisableExternalDMAUnderLock" /t REG_DWORD /d "0" /f >> APB_Log.txt
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f >> APB_Log.txt
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "0" /f >> APB_Log.txt
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f >> APB_Log.txt
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d "0" /f >> APB_Log.txt
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f >> APB_Log.txt
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d "0" /f >> APB_Log.txt
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f >> APB_Log.txt
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f >> APB_Log.txt
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f >> APB_Log.txt



echo Removing Unnecessary Powershell Packages
PowerShell -Command "Get-AppxPackage -allusers *3DBuilder* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *bing* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *bingfinance* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *bingsports* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *BingWeather* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *CommsPhone* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Drawboard PDF* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Facebook* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Getstarted* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.Messaging* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *MicrosoftOfficeHub* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Office.OneNote* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *OneNote* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *people* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *SkypeApp* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *solit* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Sway* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Twitter* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsAlarms* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsMaps* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsFeedbackHub* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsSoundRecorder* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *windowscommunicationsapps* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *zune* | Remove-AppxPackage" 
timeout /t 1 /nobreak > NUL

pause
goto MainMenu

:OptionS
cls

start https://feds.lol/sigils

goto MainMenu