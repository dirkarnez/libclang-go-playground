@REM run as Administrator
@echo off

set DOWNLOADS_DIR=%USERPROFILE%\Downloads

set SEVENZIP=C:\"Program Files"\7-Zip\7z.exe
set LLVM_DIR=%~dp0lib\LLVM-21.1.2-win64
set LIBCLANG_DLL=%LLVM_DIR%\bin\libclang.dll


if not exist %LIBCLANG_DLL% (
cd /d "%TEMP%" &&^
%SystemRoot%\System32\curl.exe "https://github.com/llvm/llvm-project/releases/download/llvmorg-21.1.2/LLVM-21.1.2-win64.exe" -L -O  &&^
%SEVENZIP% e LLVM-21.1.2-win64.exe -o"%LLVM_DIR%"  &&^
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

cd /d "%~dp0"