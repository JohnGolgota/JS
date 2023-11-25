@echo off
setlocal EnableDelayedExpansion

rem Parametros direciones
set "resultDir=%1"
set "scripDir=try-params.cmd"

rem Obtén la fecha actual
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set year=!datetime:~0,4!
set month=!datetime:~4,2!
set day=!datetime:~6,2!
set formattedDate=!year!!month!!day!

rem Ejecuta el script y redirige la salida a un archivo de log con la fecha actual
!scripDir!\%base% > !resultDir!\!formattedDate!.log

endlocal