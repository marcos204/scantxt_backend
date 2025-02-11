# Use uma imagem base do Python
FROM python:3.9-slim

# Instale o Tesseract e as dependências necessárias
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    libtesseract-dev \
    libleptonica-dev \
    tesseract-ocr-por \
    && rm -rf /var/lib/apt/lists/*

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