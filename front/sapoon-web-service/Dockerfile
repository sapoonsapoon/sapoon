# build stage
FROM node:12 as build-stage
WORKDIR /usr/src/app
COPY package*.json ./
COPY nginx_default.conf ./
RUN ls -al
RUN npm install -g @vue/cli
RUN npm install 
COPY . .
RUN npm run build
RUN ls -al dist/
RUN pwd


# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html
COPY --from=build-stage /usr/src/app/nginx_default.conf /etc/nginx/conf.d/default.conf
RUN ls -al
WORKDIR /usr/share/nginx/html
RUN ls -al
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]