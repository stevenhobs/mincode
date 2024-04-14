@echo off
setlocal
REM PROXY
set HTTP_PROXY=
set HTTPS_PROXY=%HTTP_PROXY%
if not "%M_HOME%" == "" goto exec_cmd
REM init
set M_HOME=%~dp0
call %M_HOME%\module\core.bat
set PATH=%M_HOME%;%PATH%
:exec_cmd
cmd.exe /k prompt [MTERM]$S$E[92m$P$E[0m$S$$