# Wybieramy lekki obraz z Pythonem
FROM python:3.10-slim

# Instalujemy tylko to, co niezbędne do walidacji kodu
RUN pip install pytest flake8 requests pyserial

# Kopiujemy nasz kod do kontenera
COPY . /app
WORKDIR /app