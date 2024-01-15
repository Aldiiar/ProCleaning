FROM nginx:latest

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d

# Копируем статические файлы из контейнера с Django
COPY --from=procleaning-web /app/static_root /app/static_root