FROM node:18.12.1 as build

ENV VITE_SHORTURL_LINK=shu-vue.nosad.dev
ENV VITE_API_ENDPOINT_SCHEME=https
ENV VITE_API_ENDPOINT=shu-vue.nosad.dev/api/v1/shorten

WORKDIR /build

COPY ./ ./

RUN npm install
RUN npm run build:inline

FROM nginx:1.22.0-alpine
COPY --from=build /build/dist /usr/share/nginx/html