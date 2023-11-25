setlocal
cd C:/
set "base=C:\test"
set "userinput=%1"
set "currentdate=%date:~-10,2%-%date:~-7,2%-%date:~-4,4%"
echo start backup %base% %currentdate%
if "%userinput%" == "form" (
    echo backup
    mysqldump -u root database >"%base%\database(%currentdate%).sql"
    echo end backup
    exit /b 0
)
mysqldump -u root database >"%base%\database(%currentdate%).sql"
echo end backup
exit /b 0
endlocal
