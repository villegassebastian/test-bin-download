#!/bin/bash
#set -e

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

# ========== INSTALAR GOOGLE CHROME ==========
echo "📦 Instalando Google Chrome..."
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Intentar instalar Chrome
if ! dpkg -i google-chrome-stable_current_amd64.deb 2>/dev/null; then
    echo "⚠️ Instalando dependencias faltantes de Chrome..."
    apt -f install -y
    if ! dpkg -i google-chrome-stable_current_amd64.deb; then
        echo "❌ Error: No se pudo instalar Chrome"
        exit 1
    fi
fi

# Verificar instalación
echo "✅ Google Chrome $(google-chrome --version) instalado"


# Configurar zona horaria
timedatectl set-timezone America/Bogota


# ========== ARREGLAR DEPENDENCIAS DE CHROME PARA UBUNTU DESKTOP ==========
echo "🔧 Arreglando dependencias de Chrome..."

# Instalar dependencias faltantes
apt install -y \
    xdg-utils \
    libu2f-udev \
    libvulkan1 \
    libxshmfence1 \
    libxcb1 \
    libx11-6 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    libxrender1 \
    libxtst6 \
    libgbm1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdrm2 \
    libnss3 \
    libnspr4

# Instalar dbus si no está (necesario para KDE Wallet)
apt install -y dbus

# Crear el directorio de configuración de Chrome
mkdir -p /root/.config/google-chrome

# Dar permisos a Chrome
sudo chmod 4755 /usr/bin/google-chrome-stable || true


echo "=========================================="
echo "✅ Instalación base completada"
echo "=========================================="

