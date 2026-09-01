FROM alpine:latest

# প্রয়োজনীয় প্যাকেজ ইন্সটল
RUN apk add --no-cache ffmpeg nginx bash font-dejavu

# ডিরেক্টরি সেটআপ ও ফাইল কপি
RUN mkdir -p /var/www/hls /start
COPY nginx.conf /etc/nginx/nginx.conf
COPY playlist.txt /start/playlist.txt
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]
