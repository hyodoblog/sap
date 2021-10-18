# -------------------
# build

FROM node:14.15.4-alpine3.10 as build

WORKDIR /build

COPY package.json ./package.json
COPY package-lock.json ./package-lock.json

RUN npm i

COPY . .

RUN npm run build

# -------------------
# production

FROM node:14.15.4-alpine3.10

WORKDIR /app

COPY package.json ./package.json
COPY package-lock.json ./package-lock.json

RUN npm i --production

COPY . .

COPY --from=build /build/.nuxt /app/.nuxt

ENV PORT 8080
ENV HOST 0.0.0.0

CMD ["npm", "start"]

EXPOSE 8080
