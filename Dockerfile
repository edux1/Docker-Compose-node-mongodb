FROM node:22-alpine AS build
WORKDIR /usr/src/app
COPY package.json /usr/src/app
RUN npm install
COPY target/. .
EXPOSE 3000


FROM node:22-alpine
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/package*.json ./
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app ./
EXPOSE 3000
CMD ["node", "app.js"]