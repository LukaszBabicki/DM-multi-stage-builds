#!/bin/bash

clear
echo "🔧 Co chcesz zrobić?"
echo
echo "1) Uruchom wersję deweloperską (port 3000)"
echo "2) Uruchom wersję produkcyjną (port 8082)"
echo "3) Wejdź interaktywnie do buildera"
echo "4) Usuń kontenery zegary-dev, zegary-prod, zegary-builder"
echo "q) Wyjście"
echo
read -p "👉 Twój wybór: " choice

case $choice in
  1)
    echo "🛠️ Uruchamiam wersję deweloperską..."
    docker rm -f zegary-dev 2>/dev/null || true
    docker build --target development -t zegary-dev .
    docker run -d -p 3000:80 --name zegary-dev zegary-dev
    echo "✅ Dev uruchomiony: http://localhost:3000"
    ;;
  2)
    echo "🚀 Uruchamiam wersję produkcyjną..."
    docker rm -f zegary-prod 2>/dev/null || true
    docker build -t zegary-prod .
    docker run -d -p 8082:80 --name zegary-prod zegary-prod
    echo "✅ Prod uruchomiony: http://localhost:8082"
    ;;
  3)
    echo "🔍 Wchodzę do buildera..."
    docker build --target builder -t zegary-builder .
    docker run -it --rm --name zegary-builder zegary-builder sh
    ;;
  4)
    echo "🧹 Usuwam kontenery projektu..."
    docker rm -f zegary-dev zegary-prod zegary-builder 2>/dev/null || true
    echo "✅ Kontenery usunięte."
    ;;
  q|Q)
    echo "👋 Do zobaczenia!"
    exit 0
    ;;
  *)
    echo "⛔ Nieznany wybór."
    exit 1
    ;;
esac
