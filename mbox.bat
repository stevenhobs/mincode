@echo off
setlocal enabledelayedexpansion
REM PROXY
set HTTP_PROXY=localhost:7890
set HTTPS_PROXY=%HTTP_PROXY%
REM tool exe init
set TOOL_DIR=%~dp0tool
set WGET_EXE=%~dp0tool\wget.exe
set UNZIP_EXE=%~dp0tool\unzip.exe
set _7Z_EXE=%~dp0tool\7z.exe
set MKDIR_EXE=%~dp0tool\mkdir.exe
set MV_EXE=%~dp0tool\mv.exe
set CP_EXE=%~dp0tool\cp.exe
set LINK_EXE=%~dp0tool\ln.exe
set RM_EXE=%~dp0tool\rm.exe
set JJ_EXE=%~dp0tool\jj.exe
set MCODE=%~dp0mcode.bat
REM dir init
set M_ROOT=%~dp0.
set CACHE=%~dp0cache
set TEMP=%CACHE%\temp
set TMP=%TEMP%
set MCODE_DL=%CACHE%\mcode
set SDK_DIR=%~dp0sdk
set SDK_BIN_DIR=%~dp0sdk\bin
if not exist "%TEMP%" (
  %MKDIR_EXE% -p "%TEMP%"
  echo [MCODE] Temp dir is created for temp files.
)
if not exist "%MCODE_DL%" (
  %MKDIR_EXE% -p "%MCODE_DL%"
  echo [MCODE] mcode download dir is created for cache files.
)
if not exist "%SDK_BIN_DIR%" (
  %MKDIR_EXE% -p "%SDK_BIN_DIR%"
  echo [MCODE] sdk dir is created for software develop kits.
)
REM args parse
if "%~1"=="" (
  echo MinCode-Box: VSCode Portable DIY ToolBox
  echo
  echo Usage:  mcode-box ^<operation^> ^<namespace:target^> [--flag]
  echo Example:"
  echo   install,in code:app [--version 1.72]      Install VSCode/Sdk/Tool
  echo   update,up  cc:cmake                       Update VSCode/Sdk
  echo   remove,rm  code:app                       Remove the target^(VSCode/Sdk^)
  echo Target List:
  echo   code -^> app,ext,conf
  echo   base -^> git
  echo   cc   -^> w64devkit,mingw,cmake,ninja
  echo   web  -^> nvm
  goto end
) else if "%~1"=="in" (
  goto install
) else if "%~1"=="install" (
:install
  if "%~2"=="" (
    echo [MCODE] Plz set the target. For example `install code:app`
    goto end
  ) else (
    set BOX_OP=op_install
    goto op_install
  )
) else if "%~1"=="clean" (
  %RM_EXE% -rf %CACHE%
  echo [MCODE] cache dir has removed.
  goto end
) else (
  echo [MCODE] Unknown Operation %~1
  goto end
)

:target_div
for /f "tokens=1 delims=:" %%p in ("%~2") do (
    set "prefix=%%p"
)
for /f "tokens=2 delims=:" %%a in ("%~2") do (
    set "target=%%a"
)

set namesp=(code base cc web)
for %%n in %namesp% do (
    if "%prefix%" == "%%~n" (
      set NS_FOUND=1
      goto %BOX_OP%
    )
)
if "%NS_FOUND%"=="" (
  echo [MCODE] Unknown namespace %prefix%
)
goto end

:op_install
if not "%NS_FOUND%"=="1" (
  goto target_div
) else (
  call %~dp0module\%prefix%.bat install %target% %~3 %~4
)
:end
endlocal