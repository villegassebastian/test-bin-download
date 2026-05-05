#!/bin/bash
set -e

echo "=========================================="
echo "🚀 Iniciando instalación del Bot (Binario)"
echo "=========================================="

apt update
apt install -y wget curl

# Crear directorios
mkdir -p /root/bot_files
mkdir -p /root/bot_files/storage
mkdir -p /root/storage
mkdir -p /root/bot_files/logs
mkdir -p /root/bot_files/screenshots
cd /root/bot_files

# ========== INSTALAR GOOGLE CHROME (desde repositorio oficial) ==========
echo "📦 Instalando Google Chrome desde repositorio oficial..."

# Agregar clave GPG y repositorio de Google
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-chrome.gpg
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

# Actualizar e instalar Chrome
apt update
apt install -y google-chrome-stable

# Verificar instalación
echo "✅ Google Chrome $(google-chrome --version) instalado"

# ========== INSTALAR XVFB Y LIBRERÍAS GRÁFICAS ==========
echo "🎨 Instalando Xvfb y librerías gráficas..."
apt install -y \
    xvfb \
    libxss1 \
    libappindicator1 \
    libindicator7 \
    libgbm1 \
    libasound2 \
    fonts-liberation \
    libu2f-udev \
    libvulkan1 \
    xdg-utils \
    libxtst6 \
    libnss3 \
    libnspr4 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libxshmfence1

# Configurar zona horaria
timedatectl set-timezone America/Bogota

# ========== CONFIGURAR DISPLAY VIRTUAL ==========
echo "🖥️ Configurando Xvfb como servicio systemd..."

cat > /etc/systemd/system/xvfb.service << 'EOF'
[Unit]
Description=X Virtual Frame Buffer Service
After=network.target
Before=betting-bot.service

[Service]
ExecStart=/usr/bin/Xvfb :99 -screen 0 1280x1024x24 -ac +extension GLX +render -noreset
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

# Habilitar e iniciar Xvfb
systemctl daemon-reload
systemctl enable xvfb.service
systemctl start xvfb.service

# Esperar a que Xvfb esté listo
sleep 2

echo "=========================================="
echo "✅ Instalación base completada"
echo "=========================================="
