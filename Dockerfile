FROM nginx:stable-alpine-slim
WORKDIR /usr/share/nginx/html
COPY index.html .   