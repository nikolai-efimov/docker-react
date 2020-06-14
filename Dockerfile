FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm config set strict-ssl false
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /var/www/html
CMD ["nginx", "-g", "daemon off;"]
