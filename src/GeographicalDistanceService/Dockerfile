FROM node:15

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .

EXPOSE $PORT

CMD node index.js -p $PORT -k $API_KEY