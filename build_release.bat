@echo off
cls
echo =========================================
echo   BUILDING MLM2PRO-GSPRO CONNECTOR
echo =========================================

cd /d "%~dp0"

echo Activating virtual environment...
call .venv\Scripts\activate.bat

echo Cleaning old build folders...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist MLM2Pro-GSPro-Connector.spec del /q MLM2Pro-GSPro-Connector.spec

echo Running PyInstaller (one-folder mode)...
pyinstaller ^
 --onedir ^
 --noconsole ^
 --clean ^
 --exclude-module PyQt6 ^
 --exclude-module PyQt6.QtCore ^
 --exclude-module PyQt6.QtGui ^
 --exclude-module PyQt6.QtWidgets ^
 --name "MLM2Pro-GSPro-Connector" ^
 --add-data "appdata;appdata" ^
 --add-data "connector.ini;." ^
 --add-data ".venv\Lib\site-packages\tesserocr;tesserocr" ^
 --add-data "C:\Users\CAUN\AppData\Local\Programs\Tesseract-OCR;Tesseract-OCR" ^
 src\main.py

echo.
echo Creating tessdata folder in dist...
mkdir dist\MLM2Pro-GSPro-Connector\tessdata

for %%f in (*.traineddata) do (
    echo Copying %%f
    copy /Y "%%f" dist\MLM2Pro-GSPro-Connector\tessdata\ >nul
)

echo -----------------------------------------
echo RELEASE BUILD COMPLETE!
echo -----------------------------------------
echo Portable folder ready at:
echo   dist\MLM2Pro-GSPro-Connector
echo.
pause