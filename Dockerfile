# Use uma imagem base do Python
FROM python:3.9-slim

# Instale o Tesseract e as dependências necessárias
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-por \
    libtesseract-dev \
    libleptonica-dev \
    && rm -rf /var/lib/apt/lists/*

# Crie um diretório personalizado para os arquivos de idioma
RUN mkdir -p /app/tessdata

# Copie os arquivos de idioma para o diretório personalizado
RUN cp /usr/share/tesseract-ocr/tessdata/por.traineddata /app/tessdata/

# Defina a variável de ambiente TESSDATA_PREFIX
ENV TESSDATA_PREFIX=/app/tessdata

# Defina o diretório de trabalho
WORKDIR /app

# Copie os arquivos do projeto para o contêiner
COPY . .

# Instale as dependências do Python
RUN pip install --no-cache-dir -r requirements.txt

# Exponha a porta 5000
EXPOSE 5000

# Comando para rodar o aplicativo
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:5000"]