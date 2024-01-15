# Используем базовый образ Python 3.9
FROM python:3.9

# Устанавливаем Certbot и Nginx
RUN apt-get update && \
    apt-get install -y nginx certbot python3-certbot-nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Создаем системного пользователя app
RUN addgroup --system app && adduser --disabled-password --system --no-create-home --ingroup app app

# Копируем файл .env и устанавливаем права доступа
COPY .env /app/.env
RUN chown app:app /app/.env
USER app

# Устанавливаем базовые переменные среды
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Экспозируем порт 80
EXPOSE 80

# Создаем и настраиваем рабочую директорию
WORKDIR /app
RUN mkdir /app/static && mkdir /app/media && chown -R app:app /app

# Копируем файл зависимостей и устанавливаем их
COPY ./requirements.txt /app/
RUN pip install --no-cache-dir -r /app/requirements.txt

# Устанавливаем дополнительные зависимости
RUN apt-get update && apt-get -qy install gcc libjpeg-dev \
    libpq-dev libmariadb-dev-compat gettext cron openssh-client flake8 vim && apt-get clean

# Копируем остальные файлы проекта
COPY wait-for-it.sh /app/wait-for-it.sh
COPY . /app/

# Собираем статические файлы Django
RUN python manage.py collectstatic --noinput

# Запускаем Gunicorn для обслуживания Django приложения
CMD ["gunicorn", "ProCleaning.wsgi:application", "-b", "0.0.0.0:80", "--chdir", "/app"]
