@echo off
rem $Id: somenv.cmd 2876 2012-09-08 23:12:15Z rogerb $

rem IBM SOM 2.1 NT
if "%SOMBASE%x" == "x" if exist "c:\som21nt" set SOMBASE=c:\som21nt

rem IBM SOM 3.0 NT (hangs with access violation)
rem if "%SOMBASE%x" == "x" if exist "c:\som30nt" set SOMBASE=c:\som30nt

rem somFree
if "%SOMBASE%x" == "x" if exist "%ProgramFiles%\somtk" set SOMBASE=%ProgramFiles%\somtk
if "%SOMBASE%x" == "x" if exist "%ProgramFiles(x86)%\somtk" set SOMBASE=%ProgramFiles(x86)%\somtk

if "%SOMBASE%x" == "x" goto firsttime

set vpbase=c:\vp21
set vpcopt= /E. /ucommon;%vpbase%\units.w32;%vpbase%\source\rtl;%vpbase%\source\w32 /i%vpbase%\source\rtl /l%vpbase%\lib.w32;%vpbase%\units.w32 /r%vpbase%\res.w32 /oout /m

set SOMIR=%SOMBASE%\etc\som.ir;som.ir
set SOMENV=%SOMBASE%\etc\somenv.ini
set SC=%SOMBASE%\bin\sc.exe
set LIB=%SOMBASE%\lib;%LIB%
set INCLUDE=%SOMBASE%\include;%INCLUDE%
set PATH=%SOMBASE%\bin;%PATH%
rem SOM 2.1 NT uses this
set DPATH=%SOMBASE%\msg;%DPATH%
rem SOM 3.0 NT uses this
set NLSPATH=%SOMBASE%\msg\%%N;%NLSPATH%
%vpbase%\bin.w32\vpc %vpcopt% test
test
goto end

:firsttime
echo Edit %0 to set SOMBASE.

:end
