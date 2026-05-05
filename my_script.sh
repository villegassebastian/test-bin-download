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


echo "=========================================="
echo "✅ Instalación base completada"
echo "=========================================="

