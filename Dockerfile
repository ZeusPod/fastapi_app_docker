# Usa una imagen base de Python
FROM python:3.9-slim

# Establece el directorio de trabajo
WORKDIR /code

# Copia el archivo de requisitos
COPY ./requirements.txt /code/requirements.txt

# Instala dependencias del sistema necesarias para WeasyPrint
RUN apt-get update && apt-get install -y \
    libpango1.0-0 \
    libcairo2 \
    libffi-dev \
    libgdk-pixbuf2.0-0 \
    libpangoft2-1.0-0 \
    libpangocairo-1.0-0 \
    libjpeg62-turbo \
    libopenjp2-7 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-tools \
    gstreamer1.0-x \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instala las dependencias de Python
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Copia el código de la aplicación
COPY ./app /code/app

# Expone el puerto de la aplicación
EXPOSE 8000

# Comando para correr la aplicación usando uvicorn
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
