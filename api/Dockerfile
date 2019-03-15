FROM node:8-alpine

RUN apk add --update --no-cache \
      ca-certificates \
      git \
      wget

USER node

RUN mkdir /home/node/app

COPY package.json *.js /home/node/app/

WORKDIR /home/node/app

ARG NODE_ENV

RUN npm install

COPY endpoints /home/node/app/endpoints

COPY helpers /home/node/app/helpers

ENV PORT=8000

EXPOSE $PORT

CMD ["npm", "start"]
