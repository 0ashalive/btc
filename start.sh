#!/bin/bash

# Nginx ব্যাকগ্রাউন্ডে চালু করা
nginx

# ==================== CONFIGURATION ====================
# ১. আপনার লোগোর সরাসরি ইমেজ লিঙ্ক (GitHub / Direct PNG URL)
LOGO_URL="https://raw.githubusercontent.com/0ashalive/btc/main/logo.png"

# ২. নিচে স্ক্রলিং হওয়া টেক্সট আপডেট করুন
SCROLL_TEXT="BREAKING NEWS: 24/7 Live Stream All Events,Free Movies, series,Live Tv Channel ASHAOTT APP DOWNLOAD https://t.me/ashaott"

# ৩. ভিডিও প্লেলিস্ট ফাইল পাথ
PLAYLIST_FILE="/start/playlist.txt"
# =======================================================

# FFmpeg Command (With Resolution Normalization & Text Overlay)
ffmpeg -re -f concat -safe 0 -stream_loop -1 -i "$PLAYLIST_FILE" -i "$LOGO_URL" \
  -filter_complex \
  "[0:v]scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2[scaled_v]; \
   [scaled_v][1:v]overlay=main_w-overlay_w-20:20[v1]; \
   [v1]drawbox=y=ih-80:color=black@0.7:width=iw:height=80:t=fill[v2]; \
   [v2]drawtext=text='$SCROLL_TEXT':fontcolor=white:fontsize=30:y=h-55:x='w-mod(t*100\,w+tw)':fontfile=/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf[outv]" \
  -map "[outv]" -map 0:a? \
  -c:v libx264 -preset ultrafast -b:v 2000k -c:a aac -b:a 128k \
  -f hls -hls_time 6 -hls_list_size 5 -hls_flags delete_segments \
  /var/www/hls/live.m3u8
