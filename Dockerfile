FROM python:3.11-slim

LABEL maintainer="tu-email@ejemplo.com" 
LABEL description="DevBlog - Aplicación de blog para aprender DevOps" 
LABEL version="1.0"

ENV PYTHONUNBUFFERED=1 
ENV PYTHONDONTWRITEBYTECODE=1 

#AGREGAR PARA PRODUCCION  
ENV FLASK_ENV=production 
ENV PORT=5000 

WORKDIR /app 

COPY requirements.txt . 

RUN pip install --no-cache-dir --upgrade pip && \     
    pip install --no-cache-dir -r requirements.txt  

COPY . . 

RUN adduser --disabled-password --gecos '' appuser && \
     chown -R appuser:appuser /app 
USER appuser 

CMD ["python", "app.py"] 

#AGREGAR PARA PRODUCCION  
ENV FLASK_ENV=production 
ENV PORT=5000 

RUN apt-get update && apt-get install -y \
     curl \     
     && rm -rf /var/lib/apt/lists/*  
     
COPY requirements.txt . 

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
     CMD curl -f http://localhost:$PORT/api/health || exit 1 

EXPOSE $PORT 