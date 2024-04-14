setlocal
set np_list=(nvm npmrc yarnrc nvm-reg)
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
%WGET_EXE% -O %WEB_NVM_AR% %WEB_NVM_URL%
%MKDIR_EXE% -p %NVM_HOME%
%_7Z_EXE% x %WEB_NVM_AR% -o"%NVM_HOME%"
echo > %NVM_HOME%\settings.txt
echo [WEB:NVM] Node version manager has installed.
%MKDIR_EXE% -p %SDK_DIR%\nodejs-versions
set NVM_BIN=%NVM_HOME%\nvm.exe
if exist "%NVM_BIN%" (%NVM_BIN% root %SDK_DIR%\nodejs-versions)
if exist "%NVM_BIN%" (%NVM_BIN% node_mirror https://npmmirror.com/mirrors/node)
if exist "%NVM_BIN%" (%NVM_BIN% npm_mirror https://registry.npmmirror.com)
endlocal
goto web_end

:web_nvm-reg
if not exist "%SDK_DIR%\nvm\nvm.exe" (
  echo [OS-^>WEB:NVM] node versions manager has config into windows system.  
)
echo TODO
echo [OS:NVM] nvm has applyed into system.
goto web_end

:web_npmrc
if not exist "%SDK_DIR%\nodejs\node.exe" (
  echo [WEB:NPM] Not found Nodejs loaded. Try "nvm use version_num"
  goto web_end
)
set NPM_BIN=%SDK_DIR%\nodejs\npm.cmd
%NPM_BIN% config set registry https://registry.npmmirror.com
%NPM_BIN% config set cache %CACHE%\npm-cache
echo [WEB:NPM] npm config over.
goto web_end

:web_yarnrc
if not exist "SDK_DIR%\nodejs\yarn.cmd" (
  echo [WEB:YARN] Not found yarn loaded. Try "corepack prepare yarn@latest --avtivate"
  goto web_end
)
set YARN_MGR=%SDK_DIR%\nodejs\yarn.cmd%
%YARN_MGR% config set registry https://registry.npmmirror.com
%YARN_MGR% config set cache %CACHE%\yarn-cache
echo [WB:YARN] yarn config over.

:web_end
endlocal