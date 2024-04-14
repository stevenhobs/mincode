setlocal
set np_list=(nvm node-conf)
for %%t in %np_list% do (
  if "%~2" == "%%~t" (
    set TARGET_FOUND=1
    if "%~3" == "" (
      set target_version=latest
    ) else if "%~3" == "--version" (
      if not "%~4" == "" (
        set target_version=%~4
      ) else (
        echo [WEB] Unknown version info "%~4"
      )
    ) else (
      echo [WEB] Unknown flag "%~3"
    )
    goto web_%~2
  )
)
if not "%TARGET_FOUND%" == "1" (
  echo [WEB] target not found "%~2"
)
goto web_end
:web_nvm
set WEB_NVM_URL=https://github.com/coreybutler/nvm-windows/releases/download/1.1.12/nvm-noinstall.zip
set WEB_NVM_AR=%MCODE_DL%\nvm-ar.zip
setlocal
set NVM_HOME=%SDK_DIR%\nvm
set NVM_SYMLINK=%SDK_DIR%\nodejs
@REM %WGET_EXE% -O %WEB_NVM_AR% %WEB_NVM_URL%
%MKDIR_EXE% -p %NVM_HOME%
@REM %_7Z_EXE% x %WEB_NVM_AR% -o"%NVM_HOME%"
echo > %NVM_HOME%\settings.txt
echo [WEB:NVM] Node version manager has installed.
%MKDIR_EXE% -p %SDK_DIR%\nodejs-versions
set NVM_BIN=%NVM_HOME%\nvm.exe
if exist "%NVM_BIN%" (%NVM_BIN% root %SDK_DIR%\nodejs-versions)
if exist "%NVM_BIN%" (%NVM_BIN% node_mirror https://npmmirror.com/mirrors/node)
if exist "%NVM_BIN%" (%NVM_BIN% npm_mirror https://registry.npmmirror.com)
endlocal
goto web_end

:web_end
endlocal