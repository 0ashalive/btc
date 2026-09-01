FROM alpine:latest

# Python3 সহ প্রয়োজনীয় সব প্যাকেজ ইন্সটল
RUN apk add --no-cache ffmpeg nginx bash font-dejavu python3

RUN mkdir -p /var/www/hls /start
COPY nginx.conf /etc/nginx/nginx.conf
COPY playlist.py /start/playlist.py
COPY text.txt /start/text.txt
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]
