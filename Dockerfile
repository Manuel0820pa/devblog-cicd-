FROM python:3.11-slim

LABEL maintainer="tu-email@ejemplo.com"
LABEL description="DevBlog - Aplicación de blog para aprender DevOps"
LABEL version="1.0"

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Configuración para producción
ENV FLASK_ENV=production
ENV PORT=5000

WORKDIR /app

# Instalar dependencias del sistema (como root, antes de cambiar de usuario)
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Instalar dependencias de Python
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copiar el resto del código
COPY . .

# Crear usuario sin privilegios y ceder permisos
RUN adduser --disabled-password --gecos '' appuser && \
    chown -R appuser:appuser /app
USER appuser

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:$PORT/api/health || exit 1

EXPOSE $PORT

CMD ["python", "app.py"]