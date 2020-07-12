# build stage
FROM node:12
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install -g @vue/cli
RUN npm install 
COPY . .
EXPOSE 8080
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]