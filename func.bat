@echo on

REM echo "Install Python 3.10 Environment"
REM winget install -e --id=Python.Python.3.10
REM winget install -e --id=Microsoft.VCRedist.2015+.x86
REM cmd
REM set PATH=%PATH%;C:\Users\Admin\AppData\Local\Programs\Python\Python310\;

cd %HOMEDRIVE%%HOMEPATH%
REM git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui
.\webui.bat

