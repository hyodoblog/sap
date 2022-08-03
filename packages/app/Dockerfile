# -------------------
# build

FROM node:16-bullseye as build

WORKDIR /build

COPY package.json ./package.json
COPY package-lock.json ./package-lock.json

RUN yarn install

COPY . .

RUN yarn build

# -------------------
# production

FROM node:16-bullseye

WORKDIR /app

COPY package.json ./package.json
COPY package-lock.json ./package-lock.json

ENV NODE_ENV production
RUN yarn install

COPY . .

COPY --from=build /build/.nuxt /app/.nuxt

ENV PORT 8080
ENV HOST 0.0.0.0

CMD ["yarn", "start"]

EXPOSE 8080
