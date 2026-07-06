import serial
import json
import pytest

# Konfiguracja połączenia
ser = serial.Serial('/dev/ttyUSB0', baudrate=115200, timeout=2)

def test_unlock_mechanism():
    # Przygotowujemy payload (paczka danych)
    payload = json.dumps({"action": "unlock", "token": "test_123"})
    
    # Wysyłamy dane na zamek
    ser.write(payload.encode('utf-8'))
    
    # Oczekujemy na odpowiedź
    response = ser.readline().decode('utf-8')
    response_data = json.loads(response)
    
    # Asertywność (wymuszamy wynik testu)
    assert response_data["status"] == "success", "Zamek nie otworzył się poprawnie!"