from app import create_app
from config import Config

app = create_app()

if __name__ == '__main__':
    print("Iniciando DevBlog...")
    print(f"Servidor corriendo en: http://{Config.HOST}:{Config.PORT}")
    print("Presiona Ctrl+C para detener el servidor")

    app.run(
        host=Config.HOST,
        port=Config.PORT,
        debug=Config.DEBUG
    )