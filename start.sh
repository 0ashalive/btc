#!/bin/bash

# Nginx ব্যাকগ্রাউন্ডে চালু করা
nginx

# আপনার সোর্স ভিডিও লিঙ্ক (MP4 / MKV)
INPUT_URL="https://pub-4e135af7e68844d8816cb0f642379557.r2.dev/CINEFREAK.TOP%20-%20Toxic%20%282026%29%20HDTC%20%5BHindi%20LiNE%5D%20720p%20HC-ESub.mkv"

# FFmpeg লুপ স্ট্রিম চালনা
ffmpeg -re -stream_loop -1 -i "$INPUT_URL" \
  -c:v libx264 -preset ultrafast -c:a aac \
  -f hls -hls_time 6 -hls_list_size 5 -hls_flags delete_segments \
  /var/www/hls/live.m3u8
