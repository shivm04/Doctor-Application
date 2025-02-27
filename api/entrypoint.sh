#!/bin/sh

# Run Prisma migrations
npx prisma migrate dev

# Start the app
npm run start

