import sys
import time

# আপনার সব অনলাইন ভিডিও লিঙ্ক এখানে বসান
VIDEO_LINKS = [
    "https://pub-4e135af7e68844d8816cb0f642379557.r2.dev/CINEFREAK.TOP%20-%20Toxic%20%282026%29%20HDTC%20%5BHindi%20LiNE%5D%20720p%20HC-ESub.mkv",
    "https://pub-4e135af7e68844d8816cb0f642379557.r2.dev/CINEFREAK.TOP%20-%20Toxic%20%282026%29%20HDTC%20%5BHindi%20LiNE%5D%20720p%20HC-ESub.mkv",
    "https://pub-4e135af7e68844d8816cb0f642379557.r2.dev/CINEFREAK.TOP%20-%20Toxic%20%282026%29%20HDTC%20%5BHindi%20LiNE%5D%20720p%20HC-ESub.mkv"
]

# অসীম লুপে FFmpeg concat ফরম্যাটে লিঙ্ক প্রিন্ট করবে
while True:
    for link in VIDEO_LINKS:
        print(f"file '{link}'", flush=True)
    time.sleep(0.1)
  
