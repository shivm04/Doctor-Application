## Use a lightweight Node.js image for building the app
FROM node:18-alpine AS builder

## Set the working directory
WORKDIR /app

## Copy package.json and package-lock.json to install dependencies
COPY package.json package-lock.json ./
RUN npm install

## Copy the rest of the code
COPY . .


## Create a production build
RUN npm run build

## Use Nginx to serve the static files from the build
FROM nginx:alpine

## Copy the build folder to Nginx's default HTML folder
COPY --from=builder /app/build /usr/share/nginx/html

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf


## Expose port 80
EXPOSE 80

## Start Nginx
CMD ["nginx", "-g", "daemon off;"]

