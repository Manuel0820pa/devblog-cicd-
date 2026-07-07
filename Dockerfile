FROM python:3.11-slim

LABEL maintainer="tu-email@ejemplo.com" 
LABEL description="DevBlog - Aplicación de blog para aprender DevOps" 
LABEL version="1.0"

ENV PYTHONUNBUFFERED=1 
ENV PYTHONDONTWRITEBYTECODE=1 

WORKDIR /app 

COPY requirements.txt . 

RUN pip install --no-cache-dir --upgrade pip && \     
    pip install --no-cache-dir -r requirements.txt  

COPY . . 

RUN adduser --disabled-password --gecos '' appuser && \
     chown -R appuser:appuser /app 
USER appuser 

EXPOSE 5000 

CMD ["python", "app.py"] 