@echo off
: Param1 - Win7 | Wlh | Wnet | XP
: Param2 - x86|x64
: Param3 - sys name
 
if "%2"=="x64" set %%2=amd64

if /i "%1"=="Win7" goto :checkarch
if /i "%1"=="Wlh" goto :checkarch
if /i "%1"=="Wnet" goto :checkarch
if /i "%1"=="WXp" goto :checkarch
goto :printerr
:checkarch
if /i "%2"=="x86" goto :makeinstall
if /i "%2"=="x64" goto :makeinstall
:printerr
echo wrong parameters (1)%1 (2)%2 (3)%3
pause
goto :eof

:makeinstall
if "%DDKVER%"=="" set DDKVER=7600.16385.0
set BUILDROOT=C:\WINDDK\%DDKVER%

set INST_OS=%1
set INST_ARC=%2
set SYS_NAME=%3
rem set INST_EXT=INST_ARC

if /i "%INST_ARC%"=="x64" goto :set_x64

set INST_EXT=i386
goto :startcopy

:set_x64
set INST_ARC=amd64
set INST_EXT=amd64

:startcopy
set SYS_PATH_AND_NAME=objfre_%INST_OS%_%INST_ARC%\%INST_EXT%\%SYS_NAME%.sys
set PDB_PATH_AND_NAME=objfre_%INST_OS%_%INST_ARC%\%INST_EXT%\%SYS_NAME%.pdb
set INF_PATH_AND_NAME=objfre_%INST_OS%_%INST_ARC%\%INST_EXT%\%SYS_NAME%.inf

rem echo makeinstall %1 %2 %3
mkdir .\Install\%INST_OS%\%INST_ARC%
del /Q .\Install\%INST_OS%\%INST_ARC%\%FILE_NAME%.*
copy /Y %SYS_PATH_AND_NAME% .\Install\%INST_OS%\%INST_ARC%
copy /Y %PDB_PATH_AND_NAME% .\Install\%INST_OS%\%INST_ARC%
copy /Y %INF_PATH_AND_NAME% .\Install\%INST_OS%\%INST_ARC%\%SYS_NAME%.inf

:create_cat
echo "Setting OS mask for:" %1 %2

if /i "%1"=="wlh" goto create_vista
if /i "%1"=="win7" goto create_vista
if /i "%1"=="wnet" goto create_xp
if /i "%1"=="wxp" goto create_xp
goto error_cat2inf

:create_xp
if /i "%2"=="x86" set _OSMASK_=XP_X86,Server2003_X86
if /i "%2"=="x64" set _OSMASK_=XP_X64,Server2003_X64
goto run_cat2inf

:create_vista
if /i "%2"=="x86" set _OSMASK_=Vista_X86,Server2008_X86,7_X86
if /i "%2"=="x64" set _OSMASK_=Vista_X64,Server2008_X64,7_X64,Server2008R2_X64
goto run_cat2inf

:error_cat2inf 
echo "Error setting OS mask for inf2cat"
goto after_cat2inf

:run_cat2inf
inf2cat /driver:Install\%INST_OS%\%INST_ARC% /os:%_OSMASK_%

:after_cat2inf

set INST_OS=
set INST_ARC=
set SYS_NAME=
set SYS_PATH_AND_NAME=
set PDB_PATH_AND_NAME=
set INF_PATH_AND_NAME=
set DDKVER=
set BUILDROOT=