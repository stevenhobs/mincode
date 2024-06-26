set "HOMEPATH=%MCODE_HOME%store"
set "USERPROFILE=%HOMEPATH%"
set "APPDATA=%USERPROFILE%\APPDATA\Roaming"
set "LOCALAPPDATA=%USERPROFILE%\APPDATA\Local"
set "LOCALDATA=%LOCALAPPDATA%"
set "XDG_CONFIG_HOME=%USERPROFILE%\config"
set "XDG_CACHE_HOME=%MCODE_HOME%cache"
set "TEMP=%XDG_CACHE_HOME%\temp"
set "TMP=%TEMP%"

if not exist "%APPDATA%" (mkdir "%APPDATA%")
if not exist "%LOCALDATA%" (mkdir "%LOCALDATA%")
if not exist "%XDG_CONFIG_HOME%" (mkdir "%XDG_CONFIG_HOME%")
if not exist "%TEMP%" (mkdir "%TEMP%")

set "m=%MCODE_HOME%sdk"
if exist "%m%\bin" set "PATH=%m%\bin;%PATH%"
if exist "%m%\git\cmd" set "PATH=%m%\git\cmd;%PATH%"
if exist "%m%\cmake\bin" set "PATH=%m%\cmake\bin;%PATH%"
if exist "%m%\mingw64\bin" set "PATH=%m%\mingw64\bin;%PATH%"
if exist "%m%\w64devkit\bin" set "PATH=%m%\w64devkit\bin;%PATH%"
if exist "%m%\nvm\nvm.exe" (
    set "NVMCODE_HOME=%m%\nvm"
    set "NVM_SYMLINK=%m%\nodejs"
    set "PATH=%m%\nodejs;%m%\nvm;%PATH%"
)
set "m="
