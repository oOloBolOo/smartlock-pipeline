#!/bin/bash
echo "Rozpoczynam twardy reset zamka przez GPIO..."
# Symulacja wysłania sygnału resetu na pin
echo "0" > /sys/class/gpio/gpio17/value
sleep 1
echo "1" > /sys/class/gpio/gpio17/value

# Czekamy na uruchomienie urządzenia
sleep 5

# Przeszukujemy logi systemowe za pomocą grep
if grep -q "ttyUSB0" /var/log/syslog; then
    echo "Sukces: Zamek podłączony i widoczny w systemie."
    exit 0
else
    echo "Błąd: Zamek nie podniósł się po restarcie!"
    exit 1
fi