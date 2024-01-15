FROM python:3.9

# Установка Certbot и Nginx
RUN apt-get update && \
    apt-get install -y nginx certbot python3-certbot-nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN addgroup --system app && adduser --disabled-password --system --no-create-home --ingroup app app

COPY .env /app/.env
RUN chown app:app /app/.env


# Устанавливаем базовые переменные среды
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

EXPOSE 80

# Создаем и настраиваем рабочую директорию
WORKDIR /app
RUN mkdir /app/static && mkdir /app/media && chown -R app:app /app

# Копируем файл зависимостей и устанавливаем их
COPY ./requirements.txt /app/
RUN pip install -r /app/requirements.txt

# Устанавливаем дополнительные зависимости
RUN apt-get update && apt-get -qy install gcc libjpeg-dev \
    libpq-dev libmariadb-dev-compat gettext cron openssh-client flake8 vim && apt-get clean

# Копируем остальные файлы проекта
COPY wait-for-it.sh /app/wait-for-it.sh
COPY . /app/

# Собираем статические файлы Django
RUN python manage.py collectstatic --noinput

# Устанавливаем права доступа для пользователя app
RUN chown -R app:app /app
RUN chmod 755 /app

# Пользователь app переключается на работу внутри контейнера
USER app
