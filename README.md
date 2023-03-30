Интеграция запуска скриптов через кнопки панели состояния VSCode
================================================================


### Скрипты предназначены для установки и запуска Stable Diffusion по нажатию одной кнопки

Примечание: Как по мне, так это сильно упрощает процесс установки для пользователей, не сильно
знакомых с консолью и ручным вводом команд. Конечно если в процессе установки что то пойдет не
так, то разбираться все равно придется, ну или похерить установку (вам решать).

Stable Diffusion можно запускать и без наличия мощной графической видеокарты, даже если
у вас нет 4G байт видео памяти, вы все равно можете запустить Stable Diffusion на своем
компьютере и посмотреть одним глазком что же это такое, только ждать придется сильно долго.

Для сравнения время генерации одной картинки размером 512x512 только на процессоре Intel Core i5-10400
у меня заняло 4 минуты, а после подключения графического ускорителя GeForce RTX 3060 - 6 секунд,
т.е. время генерации сокращается в 40 раз.

#### 1. Установка sd-ide-helper

1.1 Установка sd-ide-helper в Linux (Ubuntu-22.04)

```sh
sudo apt install -y git snap
sudo snap install --classic code
code --install-extension seunlanlege.action-buttons

mkdir ~/sd-ide-helper; cd ~/sd-ide-helper;
git clone https://github.com/berserktv/sd-ide-helper .vscode
code .
```

1.2 Установка sd-ide-helper в Windows 10

Установите менеджер пакетов WinGet с сайта Microsoft (там он называется App Installer):

https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1#activetab=pivot:overviewtab

альтернативный вариант установки:

https://github.com/microsoft/winget-cli/releases/latest,
загрузив и установив пакет Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

запустите в терминале (cmd) команды:

```sh
winget install -e --id Git.Git
winget install -e --id Microsoft.VisualStudioCode
```

перезапустите терминал (cmd)
```sh
code --install-extension seunlanlege.action-buttons
cd %HOMEDRIVE%%HOMEPATH%
mkdir sd-ide-helper & cd sd-ide-helper
git clone https://github.com/berserktv/sd-ide-helper .vscode
code .
```


#### 2. Установка Stable Diffusion c использованием мощного графического ускорителя Nvidia

Последовательность действий для Ubuntu-22.04 следующая (buttons):

- GPU-install-and-reboot
- SD-install

  Примечание: для установки видеодрайвера требуется ввести пароль администратора (sudo)
              и далее необходима перезагрузка системы, для запуска SD используется Python 3
              дистрибутив Anaconda (Miniconda3-latest-Linux-x86_64), который устанавливается
              в интерактивном режиме, т.е. в консоле требуется ответить на несколько вопросов.

Последовательность действий для Windows 10:

- WinGPU-install
- WinSD-install

  Примечание: В Windows 10 драйвер для видео карт Nvidia обычно устанавливается
              в автоматическом режиме, вначале проверьте установку с помощью кнопки WinSD-install.


#### 3. Установка Stable Diffusion без использования GPU

Последовательность действий для Ubuntu-22.04 следующая (buttons):

- SD-install-without-GPU

Последовательность действий для Windows 10:

- WinSD-install-without-GPU


#### 4. Запуск Stable Diffusion и открытие Web интерфейса (buttons)

для Ubuntu-22.04:

- SD-run
- Browser

для Windows 10:

- WinSD-run
- WinBrowser

#### 5. Исходный Manual c подробным описанием

https://ivonblog.com/en-us/posts/linux-stable-diffusion-webui
