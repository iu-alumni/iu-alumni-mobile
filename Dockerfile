# Stage 1: Build the Flutter web app
FROM debian:stable-slim AS builder

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

# Build-time args: backend API base URL and analytics keys baked in via --dart-define
ARG API_BASE_URL=http://localhost:8080
ARG APP_METRICA_KEY=""
ARG IU_ALUMNI_WEB_SALT=""
ENV API_BASE_URL=$API_BASE_URL

# Build Flutter web app; API_BASE_URL is baked in via --dart-define
RUN flutter pub get
RUN dart run build_runner build --delete-conflicting-outputs
RUN flutter build web --release \
    --dart-define=API_BASE_URL=$API_BASE_URL \
    --dart-define=APP_METRICA_KEY=$APP_METRICA_KEY \
    --dart-define=IU_ALUMNI_WEB_SALT=$IU_ALUMNI_WEB_SALT

# Stage 2: Serve the built web app
FROM nginx:stable-alpine

# Copy built files from builder stage
COPY --from=builder /ui_alumni_mobile/build/web /usr/share/nginx/html
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
