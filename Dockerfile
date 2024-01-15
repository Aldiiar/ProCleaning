FROM python:3.9

SHELL ["/bin/bash", "-c"]

# Устанавливаем базовые переменные среды
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

EXPOSE 80

RUN pip install --upgrade pip

# Устанавливаем дополнительные зависимости
RUN apt-get update && apt-get -qy install gcc libjpeg-dev \
    libpq-dev libmariadb-dev-compat gettext cron openssh-client flake8 vim && apt-get clean

RUN useradd -rms /bin/bash app && chmod 777 /opt /run

# Создаем и настраиваем рабочую директорию
WORKDIR /app
RUN mkdir /app/static && mkdir /app/media && chown -R app:app /app && chmod 755 /app

COPY --chown=app:app . .

RUN pip install -r requirements.txt

# Копируем остальные файлы проекта
COPY wait-for-it.sh /app/wait-for-it.sh
COPY . /app/

# Собираем статические файлы Django
RUN python manage.py collectstatic --noinput

# Пользователь app переключается на работу внутри контейнера
USER app

CMD ["gunicorn", "-b", "0.0.0.0:80", "ProCleaning.wsgi:application"]