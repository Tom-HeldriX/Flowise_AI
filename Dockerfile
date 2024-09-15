# Use the official Flowise image as the base
FROM flowiseai/flowise:latest

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

# Create necessary directories
RUN mkdir -p /opt/flowise/.flowise/logs /opt/flowise/.flowise/storage

# Set the working directory
WORKDIR /usr/src/app

# Start Flowise
CMD ["flowise", "start"]
