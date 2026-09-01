#!/bin/bash

# Start Nginx
nginx

# Configuration
LOGO_URL="https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/YOUR_REPO/main/logo.png"
PLAYLIST_FILE="/start/playlist.txt"
TEXT_FILE="/start/text.txt"

# Run FFmpeg with Reconnect flags
ffmpeg -re -protocol_whitelist file,http,https,tcp,tls,crypto \
  -reconnect 1 -reconnect_streamed 1 -reconnect_delay_max 5 \
  -f concat -safe 0 -stream_loop -1 -i "$PLAYLIST_FILE" -i "$LOGO_URL" \
  -filter_complex \
  "[0:v]scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,fps=30[scaled_v]; \
   [scaled_v][1:v]overlay=main_w-overlay_w-20:20[v1]; \
   [v1]drawbox=y=ih-80:color=black@0.7:width=iw:height=80:t=fill[v2]; \
   [v2]drawtext=textfile='$TEXT_FILE':reload=1:fontcolor=white:fontsize=30:y=h-55:x='w-mod(t*100\,w+tw)':fontfile=/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf[outv]" \
  -map "[outv]" -map 0:a? \
  -c:v libx264 -preset ultrafast -b:v 2000k -c:a aac -b:a 128k \
  -f hls -hls_time 6 -hls_list_size 5 -hls_flags delete_segments \
  /var/www/hls/live.m3u8
  
