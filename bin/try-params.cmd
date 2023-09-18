@echo off
@REM setlocal
@REM set "params=%*"
@REM if "%params%"=="help" (

@REM 	set "params=none"

@REM 	echo %params%

@REM 	echo "no se... bueno si se"

@REM 	exit /b 0

@REM )
@REM if "%params%"=="exit" (
@REM 	set "params=none"
@REM 	echo %params%
@REM 	echo "no se que hago"
@REM 	exit /b 0
@REM )
@REM if "%params%"=="none" (
@REM 	set "params=none_none"
@REM 	echo %params%
@REM 	echo "diablos"
@REM 	exit /b 0
@REM )
@REM echo %params%
@REM echo %VS%
@REM endlocal

setlocal
set respuest=%1
echo %respuest%

set "res=%*"
echo %res%

if "%respuest%"=="hola" (
	echo "hola"
	set "respuest=adios"
	echo %respuest%
) else if "%respuest%"=="adios" (
	echo "adios"
	set "respuest=none"
	echo %respuest%
) else if "%respuest%"=="none" (
	echo "none"
	set "respuest=none_none"
	echo %respuest%
) else (
	echo "no se"
	set "respuest=none"
	echo %respuest%
)
endlocal
