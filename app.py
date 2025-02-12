from flask import Flask, request, jsonify
from flask_cors import CORS  # Importe o CORS
from PIL import Image
import pytesseract
import io

app = Flask(__name__)

# Configuração do CORS para permitir o domínio do frontend
CORS(app, resources={
    r"/upload": {
        "origins": ["https://frontend-scantxt.onrender.com"],
        "methods": ["POST"],
        "allow_headers": ["Content-Type"]
    }
})

@app.route('/upload', methods=['POST'])
def upload_image():
    if 'file' not in request.files:
        return jsonify({'error': 'Nenhum arquivo enviado'}), 400
    
    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'Nome de arquivo vazio'}), 400
    
    # Lê a imagem diretamente da requisição
    img = Image.open(io.BytesIO(file.read()))
    
    # Extrai o texto da imagem
    text = pytesseract.image_to_string(img, lang='por')  # 'por' para português
    
    return jsonify({'text': text})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)