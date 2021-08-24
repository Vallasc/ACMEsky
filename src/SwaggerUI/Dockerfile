FROM node:15

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . .
EXPOSE 80

CMD npx http-server --port 80 