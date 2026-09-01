#!/bin/bash

# Ensure output directory exists
mkdir -p /var/www/hls

# Start Nginx
nginx

# Configuration
LOGO_URL="https://raw.githubusercontent.com/0ashalive/btc/main/logo.png"
TEXT_FILE="/start/text.txt"
JSON_FILE="/start/list.json"
TEMP_PLAYLIST="/tmp/generated_playlist.txt"

# Extract URLs directly from list.json using jq and build FFmpeg playlist format
jq -r '.[] | "file '\''" + . + "'\''"' "$JSON_FILE" > "$TEMP_PLAYLIST"

# Run Stream Pipeline
# [1:v]scale=150:-1 -> লোগোর সাইজ ছোট করে 150px করা হয়েছে
# overlay=main_w-overlay_w-20:20 -> লোগোটিকে উপরে ডানদিকের কর্নারে বসানো হয়েছে
ffmpeg -re -protocol_whitelist file,http,https,tcp,tls,crypto \
  -f concat -safe 0 -stream_loop -1 -i "$TEMP_PLAYLIST" -i "$LOGO_URL" \
  -filter_complex \
  "[0:v]scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,fps=30[scaled_v]; \
   [1:v]scale=150:-1[scaled_logo]; \
   [scaled_v][scaled_logo]overlay=main_w-overlay_w-20:20[v1]; \
   [v1]drawbox=y=ih-80:color=black@0.7:width=iw:height=80:t=fill[v2]; \
   [v2]drawtext=textfile='$TEXT_FILE':reload=1:fontcolor=white:fontsize=30:y=h-55:x='w-mod(t*100\,w+tw)':fontfile=/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf[outv]" \
  -map "[outv]" -map 0:a? \
  -c:v libx264 -preset ultrafast -b:v 2000k -c:a aac -b:a 128k \
  -f hls -hls_time 6 -hls_list_size 5 -hls_flags delete_segments \
  /var/www/hls/live.m3u8
