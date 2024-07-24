FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

# Actualizar los índices de los paquetes y instalar Scribus
RUN apt-get update && \
    apt-get install -y scribus

# Añadir archivos locales y configurar puertos y volúmenes
COPY /root /
EXPOSE 3000
VOLUME /config