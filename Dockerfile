FROM node:lts-alpine

WORKDIR /app

RUN apk add --no-cache openssl libgcc zlib bash

COPY package*.json ./
RUN npm ci

COPY . .

RUN npx prisma generate

RUN npm run build

EXPOSE 3000

CMD sh -c "npm ci && \
           npx prisma migrate deploy && \
           node dist/api/main.js"
