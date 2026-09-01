FROM alpine:latest

RUN apk add --no-cache ffmpeg nginx bash font-dejavu

RUN mkdir -p /var/www/hls /start
COPY nginx.conf /etc/nginx/nginx.conf
COPY playlist.txt /start/playlist.txt
COPY text.txt /start/text.txt
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]
