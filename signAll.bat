@echo off
: Param1=version in x.x.x.x form

set VERSION=%1

for %%A in ( Balloon vioserial viostor VirtIO ) do call :signDriver %%A
goto :eof

:signDriver
if not exist %1\Install goto :eof
dir /s /b %1\Install | find ".inf" > inf_files.txt
for /F %%B in (inf_files.txt) do call :signInf %%B
del /q inf_files.txt
goto :eof

:signInf
if %1 == "" goto :eof
call :osArchLoop %1
call Tools\signing.cmd sign%BUILD_OS% %BUILD_ARCH% %1 %VERSION%
goto :eof

:osArchLoop
for /F "tokens=1* delims=\ " %%i in ("%1") do (
  call :setOsAndArch %%i
  if not "%%j" == "" call :osArchLoop %%j
)
goto :eof

:setOsAndArch
if "%1" == "Win7" set BUILD_OS=Win7
if "%1" == "Wnet" set BUILD_OS=Wnet
if "%1" == "Wlh" set BUILD_OS=Wlh
if "%1" == "WXp" set BUILD_OS=WXp

if "%1" == "x86" set BUILD_ARCH=x86
if "%1" == "x64" set BUILD_ARCH=x64
goto :eof

