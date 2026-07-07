import os

class Config:
    
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'dev-secret-key-change-in-production'

    DEBUG = os.environ.get('FLASK_DEBUG') or True

    PORT = int(os.environ.get('PORT', 5000))

    HOST = os.environ.get('HOST', '0.0.0.0')