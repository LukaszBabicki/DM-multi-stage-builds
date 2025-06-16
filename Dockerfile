# Etap 1: Development
FROM nginx:alpine AS development

# Instalowanie git
RUN apk add --no-cache git

# Ustawienie katalogu roboczego
WORKDIR /app

# Klonowanie repozytorium
RUN git clone https://github.com/LukaszBabicki/zegary_daty_suchary.git .

# Kopiowanie plików do katalogu serwowanego przez nginx
RUN rm -rf /usr/share/nginx/html/* \
    && cp -r /app/* /usr/share/nginx/html/

# Usunięcie domyślnej konfiguracji i dodanie własnej (jeśli masz)
RUN rm /etc/nginx/conf.d/default.conf || true

# Użyj tej linii, jeśli masz własny nginx.conf (opcjonalnie)
COPY nginx.conf /etc/nginx/conf.d/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# -----------------------------------------------

# Etap 2: Builder
FROM alpine AS builder

WORKDIR /app
COPY --from=development /app /app

# -----------------------------------------------

# Etap 3: Production
FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d

COPY --from=builder /app /usr/share/nginx/html

RUN mkdir -p /var/cache/nginx/client_temp \
    && chown -R nginx:nginx /var/cache/nginx \
    && touch /var/run/nginx.pid \
    && chown -R nginx:nginx /var/run/nginx.pid

RUN chown -R nginx:nginx /usr/share/nginx/html \
    && chmod -R 755 /usr/share/nginx/html

USER nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
