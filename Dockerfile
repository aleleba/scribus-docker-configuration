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
    perl \
    # Instalar Python 2
    python2 \
    # Crear un enlace simbólico para asegurar que Python 2 sea accesible como 'python'
    && ln -s /usr/bin/python2 /usr/bin/python

# Compilar qtwebkit desde el código fuente
RUN git clone https://github.com/qt/qtwebkit.git \
    && cd qtwebkit \
    # Especificar explícitamente el uso de Python 2 para la configuración
    && cmake . -DPORT=Qt -DPYTHON_EXECUTABLE=/usr/bin/python2 \
    && make \
    && make install

# Descargar e instalar Scribus 1.6.2 desde el código fuente
RUN wget https://sourceforge.net/projects/scribus/files/scribus/1.6.2/scribus-1.6.2.tar.xz \
    && tar -xf scribus-1.6.2.tar.xz \
    && cd scribus-1.6.2 \
    && cmake . \
    && make \
    && make install

# Añadir archivos locales y configurar puertos y volúmenes
COPY /root /
EXPOSE 3000
VOLUME /config