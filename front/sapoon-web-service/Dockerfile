# build stage
FROM node:12 as build-stage
WORKDIR /usr/src/app
COPY package*.json ./
RUN ls -al
RUN npm install -g @vue/cli
RUN npm install 
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]