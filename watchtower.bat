rem Pass the name of the managed process, the location to start it in, and the directory to watch as 
rem arguments when starting this script.
rem 

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
if %count% LSS 1 goto KILLAPP
if %count% GEQ 10 goto STARTAPP

:KILLAPP
tasklist /FI "IMAGENAME eq %PROCESS_NAME%" 2>NUL | find /I "%PROCESS_NAME%" >NUL
if %ERRORLEVEL% equ 0 (
    echo Process %PROCESS_NAME% is running unnecessarily. Stopping it...
    taskkill /F /IM %PROCESS_NAME%
    echo Process %PROCESS_NAME% stopped successfully.
) else (
    echo Process %PROCESS_NAME% is not running.
)
:STARTAPP
echo Starting %APP_LOCATION%\%PROCESS_NAME%
cd %APP_LOCATION%
start %PROCESS_NAME%
endlocal

rem MIT License
rem
rem Copyright (c) 2024 Madeline Williams
rem 
rem Permission is hereby granted, free of charge, to any person obtaining a copy
rem of this software and associated documentation files (the "Software"), to deal
rem in the Software without restriction, including without limitation the rights
rem to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
rem copies of the Software, and to permit persons to whom the Software is
rem furnished to do so, subject to the following conditions:
rem 
rem The above copyright notice and this permission notice shall be included in all
rem copies or substantial portions of the Software.
rem 
rem THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
rem IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
rem FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
rem AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
rem LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
rem OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
rem SOFTWARE.
