@echo on

IF "%1"=="SD-run" GOTO sd_run

echo "Install Python 3.10 Environment"
winget install -e --id=Python.Python.3.10
winget install -e --id=Microsoft.VCRedist.2015+.x64

set PATH=%PATH%;%HOMEDRIVE%%HOMEPATH%\AppData\Local\Programs\Python\Python310\;
set PYTHON=%HOMEDRIVE%%HOMEPATH%\AppData\Local\Programs\Python\Python310\python.exe

cd %HOMEDRIVE%%HOMEPATH%
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui

set outfile=webui-user.bat

@echo off
IF "%1"=="no-GPU" (
    echo @echo off>%outfile%
    echo. >>%outfile%
    echo set PYTHON=>>%outfile%
    echo set GIT=>>%outfile%
    echo set VENV_DIR=>>%outfile%
    echo set COMMANDLINE_ARGS=--skip-torch-cuda-test --no-half>>%outfile%
    echo. >>%outfile%
    echo call webui.bat>>%outfile%

) ELSE (
    REM turn off --skip-torch-cuda-test, if left in COMMANDLINE_ARGS (default)
    git checkout %outfile%
)

call webui-user.bat
GOTO ExitBat


:sd_run
cd %HOMEDRIVE%%HOMEPATH%
cd stable-diffusion-webui
call webui-user.bat

:ExitBat
