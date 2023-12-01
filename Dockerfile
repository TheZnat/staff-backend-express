FROM node:20

# Папка приложения
ARG APP_DIR=app
RUN mkdir -p ${APP_DIR}
WORKDIR ${APP_DIR}


# Установка зависимостей
COPY package*.json ./


RUN npm install
RUN npx prisma generate
RUN npx prisma migrate dev --name init
RUN npm run server

# Копирование файлов проекта
COPY . .

# Уведомление о порте, который будет прослушивать работающее приложение
EXPOSE 8000

# Запускаем сервер
CMD [ "npm", "run","start" ]