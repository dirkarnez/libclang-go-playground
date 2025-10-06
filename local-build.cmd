@echo off

set DOWNLOADS_DIR=%USERPROFILE%\Downloads

set GOROOT=%DOWNLOADS_DIR%\go1.25.0.windows-amd64\go
set GOPATH=%DOWNLOADS_DIR%\gopath
set GOBIN=%GOROOT%\bin

set PATH=^
%WINDIR%\System32;^
%GOBIN%;

SET PATH=^
%PATH%;^
%DOWNLOADS_DIR%\PortableGit\bin;^
%DOWNLOADS_DIR%\winlibs-x86_64-posix-seh-gcc-11.2.0-mingw-w64-9.0.0-r1\mingw64;^
%DOWNLOADS_DIR%\winlibs-x86_64-posix-seh-gcc-11.2.0-mingw-w64-9.0.0-r1\mingw64\bin;

go build &&^
xcopy /H /Y /C "%~dp0lib\LLVM-21.1.2-win64\bin\libclang.dll"
