# -------------------
# build

FROM node:16-bullseye-slim as build

WORKDIR /build

COPY package.json ./package.json
COPY yarn.lock ./yarn.lock

RUN yarn install

COPY . .

RUN yarn build

# -------------------
# production

FROM node:16-bullseye-slim

WORKDIR /app

COPY package.json ./package.json
COPY yarn.lock ./yarn.lock

RUN yarn install --production

COPY . .
COPY --from=build /build/.nuxt /app/.nuxt

ENV PORT 8080
ENV HOST 0.0.0.0
ENV NODE_ENV production

CMD ["yarn", "start"]

EXPOSE 8080
