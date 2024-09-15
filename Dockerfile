# Build local monorepo image
# docker build --no-cache -t  flowise .

# Run image
# docker run -d -p 3000:3000 flowise

FROM node:20-alpine

# Install necessary packages
RUN apk add --update libc6-compat python3 make g++ \
  && apk add --no-cache build-base cairo-dev pango-dev chromium

# Install PNPM globally
RUN npm install -g pnpm

# Set environment variables
ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV NODE_OPTIONS=--max-old-space-size=8192

# Set working directory
WORKDIR /usr/src

# Copy app source code to the container
COPY . .

# Install dependencies using PNPM
RUN pnpm install

# Build the application
RUN pnpm build

# Expose the port your app will run on (Azure will set PORT dynamically)
EXPOSE 3000

# Use the environment variable PORT that Azure sets dynamically
# The application should handle it in the code (e.g., app.listen(process.env.PORT))
ENV PORT 3000

# Run the application
CMD ["pnpm", "start"]
