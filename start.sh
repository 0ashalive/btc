#!/bin/bash

# Nginx চালু করা
nginx

# ইনপুট অ্যাসেট
PLAYLIST_FILE="/start/playlist.txt"
LOGO_URL="https://i.ibb.co.com/5hpHVM0D/remove-photos-removed-background-2.png"
SCROLL_TEXT="BREAKING NEWS: WATCH FREE MOVIES DOWNLOAD ASHAOTT APP , FREE LIVE TV CHANNEL"

# FFmpeg Multiple Link Concat + Overlay + Scrolling Text Command
ffmpeg -re -f concat -safe 0 -stream_loop -1 -i "$PLAYLIST_FILE" -i "$LOGO_URL" \
  -filter_complex \
  "[0:v][1:v]overlay=main_w-overlay_w-20:20[v1]; \
   [v1]drawbox=y=ih-80:color=black@0.7:width=iw:height=80:t=fill[v2]; \
   [v2]drawtext=text='$SCROLL_TEXT':fontcolor=white:fontsize=32:y=h-60:x='w-mod(t*120\,w+tw)':fontfile=/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf[outv]" \
  -map "[outv]" -map 0:a \
  -c:v libx264 -preset ultrafast -c:a aac \
  -f hls -hls_time 6 -hls_list_size 5 -hls_flags delete_segments \
  /var/www/hls/live.m3u8
