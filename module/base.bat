setlocal
set np_list=(git bash)

for %%t in %np_list% do (
  if "%~2" == "%%~t" (
    set TARGET_FOUND=1
    goto base_%~2
  )
)
if not "%TARGET_FOUND%"=="1" (
  echo [BASE] Unknown Target "%~2"
  goto base_end
)
:base_git
set BASE_GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/MinGit-2.44.0-64-bit.zip
set BASE_GIT_AR=%MCODE_DL%\git-ar.zip
%WGET_EXE% -O %BASE_GIT_AR% %BASE_GIT_URL%
%RM_EXE% -rf %SDK_DIR%\git
%MKDIR_EXE% -p %SDK_DIR%\git
%UNZIP_EXE% -q %BASE_GIT_AR% -d %SDK_DIR%\git
echo [BASE:GIT] Git install OK
:base_bash
%CP_EXE% %TOOL_DIR%\busybox.exe %SDK_BIN_DIR%
%CP_EXE% %TOOL_DIR%\bash.exe %SDK_BIN_DIR%
echo [BASE:BASH] Bash on busybox install OK
:base_end
endlocal