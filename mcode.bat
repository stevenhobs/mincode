@echo off
setlocal
set MCODE_HOME=%~dp0
call %MCODE_HOME%\module\core.bat
set PATH=%MCODE_HOME%;%PATH%
set VSCODE_DEV=
set ELECTRON_RUN_AS_NODE=1
start /B "%~dp0ide\code\app\Code.exe" "%~dp0ide\code\app\resources\app\out\cli.js" %*
IF %ERRORLEVEL% NEQ 0 EXIT /b %ERRORLEVEL%
endlocal