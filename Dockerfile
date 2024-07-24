FROM ghcr.io/linuxserver/baseimage-kasmvnc:alpine320

# Instalar dependencias básicas y herramientas de compilación
RUN apk add --no-cache \
    g++ \
    cmake \
    make \
    qt5-qtbase-dev \
    qt5-qtscript-dev \
    qt5-qtsvg-dev \
    # qt5-qtwebkit-dev se compilará desde el código fuente, así que se omite aquí
    qt5-qtxmlpatterns-dev \
    poppler-dev \
    cairo-dev \
    cups-dev \
    python3-dev \
    git \
    wget \
    # Agregar dependencias adicionales necesarias para la compilación de qtwebkit
    flex \
    bison \
    gperf \
    ruby \
    perl

# Compilar qtwebkit desde el código fuente
RUN git clone https://github.com/qt/qtwebkit.git \
    && cd qtwebkit \
    && cmake . \
    && make \
    && make install

# Descargar e instalar Scribus 1.6.2 desde el código fuente
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