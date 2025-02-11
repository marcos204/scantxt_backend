#!/bin/bash
# Instala o Tesseract e os pacotes de idiomas
sudo apt-get update
sudo apt-get install -y tesseract-ocr
sudo apt-get install -y libtesseract-dev
sudo apt-get install -y tesseract-ocr-por  # Pacote para português