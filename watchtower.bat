@echo off
:MONITOR
setlocal enableextensions
if "%~3"=="" (
    echo Usage: %~nx0 PROCESS_NAME APP_LOCATION WATCH_DIRECTORY
    exit /b 1
)
set "PROCESS_NAME=%~1"
set "APP_LOCATION=%~2"
set "WATCH_DIRECTORY=%~3"
set /a count=0
for /f %%i in ('dir /b /a-d "%WATCH_DIRECTORY%" ^| find /c /v ""') do set /a count=%%i
if %count% LSS 1 goto DEATH
if %count% GEQ 10 goto BIRTH

:DEATH
tasklist /FI "IMAGENAME eq %PROCESS_NAME%" 2>NUL | find /I "%PROCESS_NAME%" >NUL
if %ERRORLEVEL% equ 0 (
    echo Process %PROCESS_NAME% is running unnecessarily. Stopping it...
    taskkill /F /IM %PROCESS_NAME%
    echo Process %PROCESS_NAME% stopped successfully.
) else (
    echo Process %PROCESS_NAME% is not running.
)
:BIRTH
echo Starting %APP_LOCATION%\%PROCESS_NAME%
cd %APP_LOCATION%
start %PROCESS_NAME%
endlocal
