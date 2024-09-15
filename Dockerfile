# Use the official Node image as the base
FROM node:20-alpine

# Set environment variables
ENV PORT=3000
ENV HOST=0.0.0.0
ENV FLOWISE_USERNAME=flowiseUserName
ENV FLOWISE_PASSWORD=strongFlowisePassword
ENV FLOWISE_SECRETKEY_OVERWRITE=longandStrongSecretKey
ENV DATABASE_PATH=/opt/flowise/.flowise
ENV APIKEY_PATH=/opt/flowise/.flowise
ENV SECRETKEY_PATH=/opt/flowise/.flowise
ENV LOG_PATH=/opt/flowise/.flowise/logs
ENV BLOB_STORAGE_PATH=/opt/flowise/.flowise/storage

# Install required dependencies
RUN apk add --update libc6-compat python3 make g++ \
    build-base cairo-dev pango-dev \
    chromium && \
    npm install -g pnpm

# Set Puppeteer config
ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Memory management
ENV NODE_OPTIONS=--max-old-space-size=8192

WORKDIR /usr/src

# Copy dependency files first
COPY pnpm-lock.yaml ./
RUN pnpm install

# Copy app source
COPY . .

# Build app
RUN pnpm build

# Expose port
EXPOSE 3000

# Start app
CMD [ "pnpm", "start" ]

# Optional: Add health check
#HEALTHCHECK CMD curl --fail http://localhost:3000/health || exit 1
