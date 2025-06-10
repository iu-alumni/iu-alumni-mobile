# Stage 1: Build the Flutter web app
FROM debian:stable-slim as builder

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"

# Verify Flutter installation
RUN flutter doctor -v

# Copy project files
WORKDIR /ui_alumni_mobile
COPY . .

# Build Flutter web app
RUN flutter pub get
RUN flutter build web --release

# Stage 2: Serve the built web app
FROM nginx:stable-alpine

# Copy built files from builder stage
COPY --from=builder /ui_alumni_mobile/build/web /usr/share/nginx/html

# Copy custom nginx configuration if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 (default HTTP port for nginx)
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]