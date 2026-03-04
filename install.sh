#!/data/data/com.termux/files/usr/bin/sh

echo "Обновление списка пакетов..."
pkg upgrade -y

echo "Подключение репозитория x11-repo..."
pkg install x11-repo -y

echo "Установка termux-x11-nightly..."
pkg install termux-x11-nightly -y

echo "Установка окружения Xfce..."
pkg install xfce4 -y

echo "Установка proot-distro..."
pkg install proot-distro -y

echo "Установка ubuntu..."
proot-distro install ubuntu

echo "Создание скрипта запуска startgui..."
cat > ~/startgui << 'EOF'
#!/data/data/com.termux/files/usr/bin/sh
termux-x11 :1 -xstartup "dbus-launch --exit-with-session xfce4-session"
EOF

chmod +x ~/startgui

echo "Перемещение startgui в $PREFIX/bin..."
mv ~/startgui "$PREFIX/bin/"

echo "Создание скрипта запуска startubu..."
cat > ~/startubu << 'EOF'
#!/data/data/com.termux/files/usr/bin/sh
proot-distro login ubuntu --shared-tmp
EOF

chmod +x ~/startubu

echo "Перемещение startubu в $PREFIX/bin..."
mv ~/startubu "$PREFIX/bin/"

echo "Создание скрипта установки зависимостей..."
cat > ~/installenv << 'EOF'
#!/data/data/com.termux/files/usr/bin/sh
apt update
apt install -y \
  build-essential \
  scons \
  pkg-config \
  libx11-dev \
  libxcursor-dev \
  libxinerama-dev \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  libasound2-dev \
  libpulse-dev \
  libudev-dev \
  libxi-dev \
  libxrandr-dev \
  libwayland-dev \
  firefox
EOF

chmod +x ~/installenv

echo "Перемещение installenv в $PREFIX/bin..."
mv ~/installenv "$PREFIX/bin/"

echo "Готово! Теперь можно ввести startgui для графики, и startubu для включения ubuntu, введите startubu а затем startgui чтобы включить ubuntu с графикой! чтобы установить все зависимости для приложений внутри ubuntu введите installenv"
