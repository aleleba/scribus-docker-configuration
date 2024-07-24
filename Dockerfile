FROM ghcr.io/linuxserver/baseimage-kasmvnc:alpine320

# Habilitar el repositorio "community" y actualizar los índices de los paquetes
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update

# Instalar Scribus desde el repositorio "community"
RUN apk add scribus@community

# Añadir archivos locales y configurar puertos y volúmenes
COPY /root /
EXPOSE 3000
VOLUME /config