@echo off
setlocal
REM PROXY
set HTTP_PROXY=
set "HTTPS_PROXY=%HTTP_PROXY%"
if not "%MCODE_HOME%" == "" (goto exec_cmd)
REM init
echo Welcome!
set "MCODE_HOME=%~dp0"
call %MCODE_HOME%\module\core.bat
set "PATH=%MCODE_HOME%;%PATH%"
:exec_cmd
cmd.exe /k prompt [MTERM]$S$E[92m$P$E[0m$S