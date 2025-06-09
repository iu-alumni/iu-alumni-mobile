FROM nginx:stable-alpine

# Copy built files to nginx's default serving directory
COPY build/web /usr/share/nginx/html

# (Optional) Custom nginx config if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]