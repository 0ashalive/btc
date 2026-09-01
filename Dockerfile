FROM alpine:latest

# FFmpeg এবং Nginx ইন্সটল
RUN apk add --no-cache ffmpeg nginx bash

# ডিরেক্টরি তৈরি ও ফাইল কপি
RUN mkdir -p /var/www/hls
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]

