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

# Stream Pipeline (Strictly Forced 480p Output)
ffmpeg -re -protocol_whitelist file,http,https,tcp,tls,crypto,hls \
  -f concat -safe 0 -stream_loop -1 -i "$TEMP_PLAYLIST" -i "$LOGO_URL" \
  -filter_complex \
  "[0:v]scale=854:480,fps=30[scaled_v]; \
   [1:v]scale=300:-1[scaled_logo]; \
   [scaled_v][scaled_logo]overlay=main_w-overlay_w-15:15[v1]; \
   [v1]drawbox=y=ih-60:color=black@0.7:width=iw:height=60:t=fill[v2]; \
   [v2]drawtext=textfile='$TEXT_FILE':reload=1:fontcolor=white:fontsize=22:y=h-42:x='w-mod(t*90\,w+tw)':fontfile=/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf[outv]" \
  -map "[outv]" -map 0:a? \
  -c:v libx264 -preset ultrafast -b:v 1200k -maxrate 1500k -bufsize 3000k -c:a aac -b:a 96k \
  -f hls -hls_time 6 -hls_list_size 5 -hls_flags delete_segments \
  /var/www/hls/live.m3u8
  
