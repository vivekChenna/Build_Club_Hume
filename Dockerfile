# Use Node.js LTS as the base image
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy only package.json and pnpm-lock.yaml for efficient caching
COPY package.json pnpm-lock.yaml ./

# Install dependencies using PNPM
RUN npm install -g pnpm && pnpm install --frozen-lockfile

# Copy the rest of the application
COPY . .

# Build the application
RUN pnpm build

# Expose the Next.js default port
EXPOSE 9080

# Start the application
CMD ["pnpm", "dev" ,"-p","9080"]
