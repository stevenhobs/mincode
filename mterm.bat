@echo off
setlocal
set MCODE_HOME=%~dp0
echo %PATH% | findstr /C:"%MCODE_HOME%" > nul
if errorlevel 1 (
  echo [MTERM] init environments
) else (
  goto exec_cmd
)
set PATH=E:\mincode;%PATH%;
call %MCODE_HOME%\module\core.bat
set PATH=%MCODE_HOME%;%PATH%
:exec_cmd
@REM %~dp0tool\bash.exe
cmd.exe /k prompt [MTERM]$S$E[92m$P$E[0m$S$$