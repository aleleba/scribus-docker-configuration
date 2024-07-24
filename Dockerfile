FROM ghcr.io/linuxserver/baseimage-kasmvnc:alpine320

# Instalar dependencias básicas y herramientas de compilación
RUN apk add --no-cache \
    g++ \
    cmake \
    make \
    qt5-qtbase-dev \
    qt5-qtscript-dev \
    qt5-qtsvg-dev \
    qt5-qtwebkit-dev \
    qt5-qtxmlpatterns-dev \
    poppler-dev \
    cairo-dev \
    cups-dev \
    python3-dev \
    git \
    wget

# Descargar e instalar Scribus 1.6.2 desde el código fuente
# Este es un ejemplo hipotético; necesitarás ajustar los comandos según la ubicación actual del código fuente y las instrucciones de compilación
RUN wget https://sourceforge.net/projects/scribus/files/scribus/1.6.2/scribus-1.6.2.tar.xz \
    && tar -xf scribus-1.6.2.tar.xz \
    && cd scribus-1.6.2 \
    && cmake . \
    && make \
    && make install

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config