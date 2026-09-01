FROM alpine:latest

# Added jq for direct JSON parsing
RUN apk add --no-cache ffmpeg nginx bash font-dejavu jq

RUN mkdir -p /var/www/hls /start
COPY nginx.conf /etc/nginx/nginx.conf
COPY list.json /start/list.json
COPY text.txt /start/text.txt
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]
