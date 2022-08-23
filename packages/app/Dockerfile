# -------------------
# build

FROM node:14.15.4-alpine3.10 as build

WORKDIR /build

COPY package.json ./package.json
COPY yarn.lock ./yarn.lock

RUN yarn install

COPY . .

RUN yarn build

# -------------------
# production

FROM node:14.15.4-alpine3.10

WORKDIR /app

COPY package.json ./package.json
COPY yarn.lock ./yarn.lock

ENV NODE_ENV production
RUN yarn install

COPY . .

COPY --from=build /build/.nuxt /app/.nuxt

ENV PORT 8080
ENV HOST 0.0.0.0

CMD ["yarn", "start"]

EXPOSE 8080
