@echo on

echo "Install Python 3.10 Environment"
winget install -e --id=Python.Python.3.10
winget install -e --id=Microsoft.VCRedist.2015+.x64

set PATH=%PATH%;%HOMEDRIVE%%HOMEPATH%\AppData\Local\Programs\Python\Python310\;
set PYTHON=%HOMEDRIVE%%HOMEPATH%\AppData\Local\Programs\Python\Python310\python.exe

cd %HOMEDRIVE%%HOMEPATH%
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui

if %noGPU% == "y" (
    set infile=webui-user.bat
    set find=set COMMANDLINE_ARGS=
    set replace=set COMMANDLINE_ARGS=--skip-torch-cuda-test
    for /F "tokens=* delims=," %%n in (!infile!) do (
        set LINE=%%n
        set TMPR=!LINE:%find%=%replace%!
        echo !TMPR!>>TMP.TXT
    )
    move TMP.TXT %infile%
)

call webui-user.bat
