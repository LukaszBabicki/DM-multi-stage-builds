🚀 Multi-stage Docker Build: Aplikacja statyczna + Nginx

Projekt realizowany w ramach kursu **Docker Maestro**.  
Celem jest stworzenie kontenera Dockera zgodnego z najlepszymi praktykami:

- Użycie **multi-stage build** (development, builder, production)
- **Bezpieczeństwo**: użytkownik non-root (`nginx`)
- **Serwowanie plików statycznych** przez Nginx
- **Wersje dev i prod** działające niezależnie

Źródło aplikacji:  
🔗 https://github.com/LukaszBabicki/zegary_daty_suchary

---

## 🗂 Struktura projektu

├── Dockerfile # Trójfazowy: development, builder, production
├── start.sh # Menu CLI – uruchamianie dev, prod, builder, czyszczenie
├── nginx.conf # Konfiguracja Nginx z nagłówkami bezpieczeństwa



---

## 🖥 Jak korzystać

### 1️⃣ Uruchom skrypt menu:

```bash
./start.sh


1) Uruchom wersję deweloperską (port 3000)
2) Uruchom wersję produkcyjną (port 8082)
3) Wejdź interaktywnie do buildera
4) Usuń kontenery zegary-dev, zegary-prod, zegary-builder

---


✅ Wersja deweloperska
Port: 3000

Klonuje repo z GitHuba za każdym razem

Służy do testowania zmian

Adres: http://localhost:3000
---

✅ Wersja produkcyjna
Port: 8082

Statyczny build oparty na warstwie builder

Gotowa do wdrożenia

Adres: http://localhost:8082

---
🧪 Builder
Etap pośredni (np. do rozszerzenia o minifikację lub build JS).
Możesz wejść do niego interaktywnie i podejrzeć pliki:

docker build --target builder -t zegary-builder .
docker run -it --rm zegary-builder sh
---

🔐 Zastosowane dobre praktyki
✅ Multi-stage build
✅ Obraz bazowy nginx:alpine
✅ Użytkownik nginx (non-root)
✅ Własna konfiguracja Nginx (nginx.conf)
✅ Prawidłowe uprawnienia katalogów
✅ Skrypt CLI do wygodnego zarządzania

👤 Autor
Łukasz Babicki
https://github.com/LukaszBabicki



