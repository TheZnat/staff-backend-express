FROM node:20

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

# Переходим в директорию /app/client
WORKDIR /app/client

# Собираем клиентскую часть приложения
RUN npm run build

# Возвращаемся в корневую директорию /app
WORKDIR /app

# Устанавливаем значение переменной окружения
ENV NODE_ENV=production

# Открываем порт 8000 в нашем контейнере
EXPOSE 8000

# Запускаем сервер
CMD [ "npm", "start" ]