@echo off

set SYS_FILE_NAME=vioscsi

for %%A in (Win7 Wlh Wnet) do for %%B in (32 64) do call :%%A_%%B
goto :eof 

:buildsys
call buildOne.bat %1 %2
goto :eof

:packsys
call packOne.bat %1 %2 %SYS_FILE_NAME%
goto :eof

:buildpack
call :buildsys %1 %2
call :packsys %1 %2
set BUILD_OS=
set BUILD_ARC=
goto :eof

:WIN7_32
set BUILD_OS=Win7
set BUILD_ARC=x86
call :buildpack %BUILD_OS% %BUILD_ARC%
goto :eof

:WIN7_64
set BUILD_OS=Win7
set BUILD_ARC=x64
call :buildpack %BUILD_OS% %BUILD_ARC%
goto :eof

:WLH_32
set BUILD_OS=Wlh
set BUILD_ARC=x86
call :buildpack %BUILD_OS% %BUILD_ARC%
goto :eof

:WLH_64
set BUILD_OS=Wlh
set BUILD_ARC=x64
call :buildpack %BUILD_OS% %BUILD_ARC%
goto :eof

:WNET_32
set BUILD_OS=Wnet
set BUILD_ARC=x86
call :buildpack %BUILD_OS% %BUILD_ARC%
goto :eof

:WNET_64
set BUILD_OS=Wnet
set BUILD_ARC=x64
call :buildpack %BUILD_OS% %BUILD_ARC%
goto :eof
