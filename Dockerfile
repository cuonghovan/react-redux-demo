# Stage 1 - the build process
FROM node:8.11.3 as build-deps

WORKDIR /usr/src/app

COPY package.json yarn.lock ./

RUN yarn install

COPY . ./

RUN yarn build

# Stage 2 - the production environment
FROM nginx:1.15-alpine

COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
