# Используем образ дистрибутив линукс Alpine с версией Node -20 Node.js
FROM node:20-alpine

# Указываем нашу рабочую дерикторию
WORKDIR /app

# Копируем package.json и package-lock.json внутрь контейнера
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем оставшееся приложение в контейнер
COPY . .

# Устанавливаем Prisma
RUN npm install prisma

# Генерируем Prisma client
RUN npx prisma generate

# Создаем базу данных и делаем миграцию
RUN npx prisma migrate dev

# Копируем Prisma schema и URL базы данных в контейнер
COPY prisma/schema.prisma ./prisma/

# Уведомление о порте, который будет прослушивать работающее приложение
EXPOSE 8000

# Запускаем сервер
CMD [ "npm", "run","start" ]