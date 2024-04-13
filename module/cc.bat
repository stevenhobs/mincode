setlocal
set np_list=(w64devkit mingw64 cmake xmake ninja llvm-mingw)
for %%t in %np_list% do (
  if "%~2" == "%%~t" (
    set TARGET_FOUND=1
    if "%~3" == "" (
      set target_version=latest
    ) else if "%~3" == "--version" (
      if not "%~4" == "" (
        set target_version=%~4
      ) else (
        echo [CC] Unknown version info "%~4"
      )
    ) else (
      echo [CC] Unknown flag "%~3"
    )
    goto cc_%~2
  )
)
if not "%TARGET_FOUND%" == "1" (
  echo [CC] target not found "%~2"
)
goto cc_end

:cc_w64devkit
set CC_W64DEVKIT_URL=https://github.com/skeeto/w64devkit/releases/download/v1.22.0/w64devkit-1.22.0.zip
set CC_W64DEVKIT_AR=%MCODE_DL%\w64devkit-ar.zip
%WGET_EXE% -O %CC_W64DEVKIT_AR% %CC_W64DEVKIT_URL%
echo [CC:W64DEVKIT] w64devkit Archive Download over.
%RM_EXE% -rf %SDK_DIR%\w64devkit
%UNZIP_EXE% "%CC_W64DEVKIT_AR%" -d "%SDK_DIR%"
goto cc_end

:cc_mingw64
set CC_MINGW64_URL=https://github.com/niXman/mingw-builds-binaries/releases/download/13.2.0-rt_v11-rev0/x86_64-13.2.0-release-win32-seh-ucrt-rt_v11-rev0.7z
set CC_MINGW64_AR=%MCODE_DL%\mingw64-ar.7z
%WGET_EXE% -O %CC_MINGW64_AR% %CC_MINGW64_URL%
echo [CC:MINGW64] Mingw Archive Download over.
%RM_EXE% -rf %SDK_DIR%\mingw64
%_7Z_EXE% x "%CC_MINGW64_AR%" -o"%SDK_DIR%"
goto cc_end

:cc_cmake
set CC_CMAKE_URL=https://github.com/Kitware/CMake/releases/download/v3.28.4/cmake-3.28.4-windows-x86_64.zip
set CC_CMAKE_AR=%MCODE_DL%\cmake-ar.zip
%WGET_EXE% -O %CC_CMAKE_AR% %CC_CMAKE_URL%
echo [CC:CMAKE] Archive Download Over.
%RM_EXE% -rf %SDK_DIR%\cmake
%UNZIP_EXE% -q %CC_CMAKE_AR% -d %TEMP%
for /d %%D in ("%TEMP%\cmake*") do (
    %MV_EXE% "%%~D" "%SDK_DIR%\cmake"
)
if exist "%SDK_DIR%\cmake" (
  echo [CC:CMAKE] Install OK
) else (
  echo [CC:CMAKE] Install Fail
)
goto cc_end

:cc_ninja
set CC_NINJA_URL=https://github.com/ninja-build/ninja/releases/download/v1.12.0/ninja-win.zip
set CC_NINJA_AR=%MCODE_DL%\ninja-ar.zip
%WGET_EXE% -O %CC_NINJA_AR% %CC_NINJA_URL%
echo [CC:NINJA] Archive Download Over.
%UNZIP_EXE% -q %CC_NINJA_AR% -d %SDK_BIN_DIR%
echo [CC:NINJA] ninja-build installed.
:cc_end
endlocal