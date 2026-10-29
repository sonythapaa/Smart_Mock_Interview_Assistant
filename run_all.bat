@echo off
title SMART Mock Interview - Launcher
set "ROOT=%~dp0"

cd /d "%ROOT%"

if not exist ".venv\Scripts\activate.bat" (
    echo Creating virtual environment...
    python -m venv .venv
    if errorlevel 1 (
        echo Failed to create virtual environment.
        pause
        exit /b 1
    )
)

call ".venv\Scripts\activate.bat"

echo Installing/updating Python requirements...
pip install -r requirements.txt
if errorlevel 1 (
    echo Failed to install requirements.
    pause
    exit /b 1
)

echo Starting main app and compare app in separate windows...
echo.

start "Main App - http://localhost:5000" cmd /k "cd /d ""%ROOT%"" && call "".venv\Scripts\activate.bat"" && python main\app.py"
start "Compare App - http://localhost:5050" cmd /k "cd /d ""%ROOT%"" && call "".venv\Scripts\activate.bat"" && python compare\app.py"

echo Main app:     http://localhost:5000
echo Compare app:  http://localhost:5050/topic-compare
echo.
pause
