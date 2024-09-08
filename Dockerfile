# Базовый образ Ubuntu 20.04
FROM ubuntu:20.04

# Обновление системы и установка необходимых инструментов
RUN apt-get update && \
    apt-get install -y qemu qemu-kvm libvirt-clients libvirt-daemon-system sudo python3 wget curl

# Создание пользователя
RUN useradd -m -s /bin/bash daniel && \
    echo 'daniel:17021983' | chpasswd && \
    adduser daniel sudo

# Скачивание ISO-образа Ubuntu Server 20.04 LTS
RUN mkdir -p /iso && \
    wget -O /iso/ubuntu-20.04-server.iso https://releases.ubuntu.com/20.04/ubuntu-20.04-live-server-amd64.iso

# Открытие порта для SSH
EXPOSE 22

# Добавление Python-скрипта в контейнер
COPY create_vm.py /usr/local/bin/create_vm.py

# Команда для запуска скрипта
CMD ["python3", "/usr/local/bin/create_vm.py"]
