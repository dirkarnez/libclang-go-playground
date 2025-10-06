@REM run as Administrator
@echo off

set DOWNLOADS_DIR=%USERPROFILE%\Downloads

set SEVENZIP=C:\"Program Files"\7-Zip\7z.exe
set LLVM_DIR=%~dp0lib\LLVM-21.1.2-win64
set LIBCLANG_DLL=%LLVM_DIR%\bin\libclang.dll


if not exist %LIBCLANG_DLL% (
cd /d "%TEMP%" &&^
%SystemRoot%\System32\curl.exe "https://github.com/llvm/llvm-project/releases/download/llvmorg-21.1.2/LLVM-21.1.2-win64.exe" -L -O  &&^
%SEVENZIP% e LLVM-21.1.2-win64.exe -o"%LLVM_DIR%" -y &&^
del LLVM-21.1.2-win64.exe
)

if exist %LIBCLANG_DLL% (
    echo libclang.dll %LIBCLANG_DLL% found
)

set GO_DIR=%DOWNLOADS_DIR%\go1.25.0.windows-amd64
set GOROOT=%GO_DIR%\go
set GO_EXE=%GOROOT%\bin\go.exe

if not exist %GO_EXE% (
cd /d "%TEMP%" &&^
%SystemRoot%\System32\curl.exe "https://go.dev/dl/go1.25.0.windows-amd64.zip" -L -O  &&^
%SEVENZIP% x go1.25.0.windows-amd64.zip -o"%GO_DIR%"  &&^
del go1.25.0.windows-amd64.zip
)

if exist %GO_EXE% (
    echo go %GO_EXE% found
)

set GCC_DIR=%DOWNLOADS_DIR%\winlibs-x86_64-posix-seh-gcc-11.2.0-mingw-w64-9.0.0-r1
set GCC_EXE=%GCC_DIR%\mingw64\bin\gcc.exe

if not exist %GCC_EXE% (
cd /d "%TEMP%" &&^
%SystemRoot%\System32\curl.exe "https://github.com/brechtsanders/winlibs_mingw/releases/download/11.2.0-12.0.1-9.0.0-r1/winlibs-x86_64-posix-seh-gcc-11.2.0-mingw-w64-9.0.0-r1.zip" -L -O &&^
%SEVENZIP% x winlibs-x86_64-posix-seh-gcc-11.2.0-mingw-w64-9.0.0-r1.zip -o"%GCC_DIR%" -y &&^
del winlibs-x86_64-posix-seh-gcc-11.2.0-mingw-w64-9.0.0-r1.zip
)

if exist %GCC_EXE% (
    echo gcc %GCC_EXE% found
)

cd /d "%~dp0"
