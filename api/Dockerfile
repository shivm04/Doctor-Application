# Use Alpine Node.js image
FROM node:18-alpine

# Install OpenSSL (required for Prisma)
RUN apk add --no-cache openssl

# Set working directory
WORKDIR /app

# Copy package files first for layer caching
COPY package*.json ./

# Install dependencies (including Prisma)
RUN npm install

# Copy the rest of the app (including .env, schema.prisma, and migrations)
COPY . .

# Generate the Prisma Client (MUST happen after copying the schema)
RUN npx prisma generate

# Create an entrypoint script to run migrations before starting the app
RUN echo "#!/bin/sh" > /app/entrypoint.sh && \
    echo "npx prisma migrate deploy" >> /app/entrypoint.sh && \
    echo "npm run start" >> /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh

# Expose the app port
EXPOSE 5050

# Run migrations and start the app via the entrypoint script
ENTRYPOINT ["/app/entrypoint.sh"]
