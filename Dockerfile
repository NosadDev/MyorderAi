FROM node:18.12.1 as build

WORKDIR /build

COPY ./ ./

RUN npm install
RUN npm run build:inline

FROM nginx:1.22.0-alpine
COPY --from=build /build/dist /usr/share/nginx/html