#FROM node:20-alpine
#WORKDIR /app
#COPY . .
#RUN apk add --no-cache openssl1.1-dev
#RUN yarn add copyfiles
#RUN yarn install
#COPY . .
#RUN yarn build
#EXPOSE 5050

#RUN ["chmod", "+x", "./entrypoint.sh"]
#ENTRYPOINT [ "sh", "./entrypoint.sh" ]

# Use Node.js base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker caching
COPY package*.json ./

# Install dependencies
RUN npm install -g prisma
RUN npm install

# Copy the entire backend code
COPY . .

# Generate Prisma client
RUN npx prisma generate

# Expose the port (change according to your backend)
EXPOSE 5050

# Command to run migrations and start the server
#CMD npx prisma migrate dev && npm run start

CMD ["sh", "-c", "npx prisma migrate deploy && npm run start"]




