FROM node:14.15.4-alpine3.10

WORKDIR /app

COPY . .

ENV PORT 8080
ENV HOST 0.0.0.0

RUN yarn install --only=production --cache /tmp/empty-cache && rm -rf /tmp/empty-cache
RUN yarn build

CMD ["yarn", "start"]

EXPOSE 8080
