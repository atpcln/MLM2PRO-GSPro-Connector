@echo off
cls
echo ==============================
echo  GSPro Connector Build Script
echo ==============================
echo.

REM ---- Navigate to script directory ----
cd /d "%~dp0"

REM ---- Activate virtual environment ----
if exist ".venv\Scripts\activate.bat" (
    echo Activating virtual environment...
    call .venv\Scripts\activate.bat
) else (
    echo ERROR: .venv not found!
    echo Make sure you are using the correct project directory.
    pause
    exit /b 1
)

echo.
echo Using Python:
python --version
echo.

REM ---- Clean old build folders ----
echo Cleaning previous build artifacts...
if exist build (rmdir /s /q build)
if exist dist (rmdir /s /q dist)

echo.
echo Starting PyInstaller build...
echo Output will be logged in build.log
echo.

REM ---- BUILD EXECUTABLE ----
pyinstaller ^
 --noconsole ^
 --name "GSProConnector" ^
 --icon=icon.ico ^
 --add-data "train;train" ^
 --add-data "mevo;mevo" ^
 --add-data "exputt;exputt" ^
 --add-data ".venv\Lib\site-packages\tesserocr;tesserocr" ^
 src\main.py > build.log 2>&1

echo.
echo ==============================
echo  Build finish
echo  Check dist\GSProConnector\
echo  See build.log for details
echo ==============================
echo.

pause