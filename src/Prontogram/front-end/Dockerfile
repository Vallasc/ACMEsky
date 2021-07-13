FROM node:15

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY /static/ .

EXPOSE 80
CMD npx http-server -c-1 --proxy --port 80 