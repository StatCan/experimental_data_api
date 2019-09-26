FROM node:8-alpine

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global \
  NODE_PATH=/home/node/.npm-global/lib/node_modules

RUN apk add --update --no-cache \
      ca-certificates \
      git \
      wget \
      postgresql-dev \
    && apk add --no-cache --virtual .gyp python make g++ \
    && npm install -g pg-native --unsafe \
    && apk del .gyp

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
