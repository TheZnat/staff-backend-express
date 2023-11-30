FROM node:20

# Папка приложения
ARG APP_DIR=app
RUN mkdir -p ${APP_DIR}
WORKDIR ${APP_DIR}


# Установка зависимостей
COPY package*.json ./

ENV PORT = ${{ vars.PORT }}
ENV JWT_SECRET = ${{ JWT_SECRET }}
ENV JWT_SECRET = ${{ DATABASE_UR}}
RUN npm install
RUN npx prisma generate
RUN npx prisma migrate dev
RUN npm run server

# Копирование файлов проекта
COPY . .

# Уведомление о порте, который будет прослушивать работающее приложение
EXPOSE 8000

# Запускаем сервер
CMD [ "npm", "run","start" ]