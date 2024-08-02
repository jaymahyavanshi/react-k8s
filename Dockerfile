# Use Node.js 20 as the base image
FROM node:20

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Use an nginx server to serve the built app
FROM nginx:alpine
COPY --from=0 /app/build /usr/share/nginx/html

# Expose the port that the app will run on
EXPOSE 80

# Start the nginx server
CMD ["nginx", "-g", "daemon off;"]
