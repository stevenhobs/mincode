setlocal
set VSC_APP=%M_ROOT%\ide\code\app
set VSC_DATA=%M_ROOT%\ide\code\data

set np_list=(app ext conf)
for %%t in %np_list% do (
  if "%~2" == "%%~t" (
    set TARGET_FOUND=1
    if "%~3" == "" (
      set target_version=latest
    ) else if "%~3" == "--version" (
      if not "%~4" == "" (
        set target_version=%~4
      ) else (
        echo [CODE] Unknown version info "%~4"
      )
    ) else (
      echo [CODE] Unknown flag "%~3"
    )
    goto code_%~2
  )
)
if not "%TARGET_FOUND%" == "1" (
  goto code_end
)
:code_app
if not exist "%VSC_APP%" (
  %MKDIR_EXE% -p "%VSC_APP%"
  echo [CODE:APP] VSCode app install dir is created.
)
if not exist "%VSC_DATA%" (
  %MKDIR_EXE% -p "%VSC_DATA%"
  echo [CODE:APP] VSCode data dir is created.
)
set CODE_VERSION=%target_version%
set CODE_DL_URL=https://update.code.visualstudio.com/%CODE_VERSION%/win32-x64-archive/stable
set CODE_ARCHIVE_FILE=%MCODE_DL%\vscode-win-x64-archive-%CODE_VERSION%.zip

if not exist "%CODE_ARCHIVE_FILE%" (
  goto code_app_ar_wget
)
echo [CODE:APP] VS Code installer file is found at %CODE_ARCHIVE_FILE%
set /p input="[CODE:CHOOSE] Will use the local file for install? (yes/no) "
  if "%input%"=="yes" (
    echo [CODE:APP] Mcode will use local cache file for the install.
    goto code_app_ar_extract
  ) else (
    echo [CODE:APP] Mcode will download installer file by network.
    goto code_app_ar_wget
  )

:code_app_ar_wget
  echo [CODE:APP] Start to download installer file.
  %WGET_EXE% -O %CODE_ARCHIVE_FILE% %CODE_DL_URL%
  echo [CODE:APP] Wget download over.
)
:code_app_ar_extract
%RM_EXE% -rf %VSC_APP%/*
%_7Z_EXE% x %CODE_ARCHIVE_FILE% -o"%VSC_APP%"
%LINK_EXE% -s %VSC_DATA% %VSC_APP%/data
echo [CODE:APP] vscode app has installed!
goto code_end
:code_ext
echo [CODE:EXT] vscode init basic extensions
call %MCODE% --install-extension "MS-CEINTL.vscode-language-pack-zh-hans"
call %MCODE% --install-extension "PKief.material-icon-theme"
call %MCODE% --install-extension "fisheva.eva-theme"
call %MCODE% --install-extension "oderwat.indent-rainbow"
call %MCODE% --install-extension "christian-kohler.path-intellisense"
call %MCODE% --install-extension "mikeburgh.xml-format"
goto code_end
:code_conf
set "VSC_APP_CONF=%VSC_DATA%\user-data\User\settings.json"
if not exist "%VSC_APP_CONF%" (
  %MKDIR_EXE% -p "%VSC_DATA%\user-data\User"
  echo {} > %VSC_APP_CONF%
)
rem workbench settings
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "workbench\.iconTheme" -v "material-icon-theme"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "workbench\.colorTheme" -v "Eva Light"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "workbench\.editor\.enablePreview" -v false
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "workbench\.startupEditor" -v "none"
rem editor settings
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "editor\.fontFamily" -v "'Cascadia Code', 'Microsoft YaHei'"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "editor\.renderControlCharacters" -v false
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "editor\.fontLigatures" -v true
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "editor\.suggestSelection" -v "first"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "editor\.cursorSmoothCaretAnimation" -v "on"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "editor\.cursorBlinking" -v "smooth"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "editor\.linkedEditing" -v true
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "editor\.matchBrackets" -v "never"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "editor\.minimap\.enabled" -v false
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "editor\.fontSize" -v 13
rem terminal settings
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "terminal\.integrated\.cursorBlinking" -v true
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "terminal\.integrated\.cursorStyle" -v "line"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "terminal\.integrated\.cursorWidth" -v 2
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "terminal\.integrated\.defaultProfile\.windows" -v "Command Prompt"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "terminal\.integrated\.fontSize" -v 12
rem other props
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "update\.mode" -v "none"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "debug\.console\.fontSize" -v 10
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "extensions\.ignoreRecommendations" -v true
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "material-icon-theme\.hidesExplorerArrows" -v "true"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "material-icon-theme\.activeIconPack" -v "react_redux"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "window\.commandCenter" -v false
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "git\.openRepositoryInParentFolders" -v "never"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% "files\.eol" -v "auto"
%JJ_EXE% -i %VSC_APP_CONF% -o %VSC_APP_CONF% -p
echo [VSCODE:CONF] basic settings have been writed.

:code_end
endlocal
