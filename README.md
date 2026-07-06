SmartLock HIL Automation Pipeline

Projekt to mój proof of concept testów Hardware-in-the-Loop uruchamiany na Raspberry Pi 5. Zbudowałem go, żeby pokazać proces automatyzacji od strony devopsowej dla fizycznego sprzętu.

Z czego to złożyłem i po co:

GitLab CI - automatyzuje proces. Po każdym pushu odpala joby na lokalnym runnerze zainstalowanym na malince, żebym nie musiał klikać tego ręcznie.

Ansible - automatycznie konfiguruje środowisko. Upewnia się, że system ma potrzebne pakiety i nadaje runnerowi uprawnienia do grupy dialout, żeby w ogóle mógł gadać z portem szeregowym.

Docker - odpala testy w izolacji. Gwarantuje, że skrypt nie wysypie się na innej stacji testowej z powodu braku jakiejś biblioteki systemowej.

Bash - uderza bezpośrednio do systemu. Robi twardy reset sprzętu przez piny GPIO i szybko sprawdza w logach, czy urządzenie fizycznie wisi na porcie USB, zanim zacznie właściwy test.

Python - tu jest logika testu przez pytest i pyserial. Wysyła zdefiniowane JSONy przez UART i sprawdza, czy zamek odpowiada poprawnie.

Dlaczego pipeline ma status failed:

Ostatni etap zawsze kończy się u mnie błędem, bo skrypt bashowy nie znajduje fizycznego zamka podpiętego pod /dev/ttyUSB0. Skoro nie mam podpiętego sprzętu na biurku, skrypt robi exit 1. To celowe - w realnych warunkach w ten sposób system wyłapuje awarię lub to, że ktoś odpiął kabel na stanowisku i od razu blokuje cały proces.