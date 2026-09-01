from flask import Flask, Response, request
import time

app = Flask(__name__)

# আপনার ভিডিও লিংকগুলো (MP4/MKV/M3U8) এখানে অ্যাড করুন
MEDIA_SOURCES = [
    "https://pub-4e135af7e68844d8816cb0f642379557.r2.dev/CINEFREAK.TOP%20-%20Toxic%20%282026%29%20HDTC%20%5BHindi%20LiNE%5D%20720p%20HC-ESub.mkv",
]

@app.route('/master/index.m3u8')
def serve_m3u8():
    # সরাসরি MKV/MP4 লিংক থাকলে প্লেয়ার যেন প্লে করতে পারে তার জন্য M3U8 হেডার জেনারেট করা
    current_media = MEDIA_SOURCES[0]
    
    # যদি সোর্স সরাসরি .m3u8 হয়
    if current_media.endswith('.m3u8'):
        m3u8_content = f"""#EXTM3U
#EXT-X-VERSION:3
#EXT-X-STREAM-INF:BANDWIDTH=1280000
{current_media}
"""
    else:
        # MKV বা MP4 লিঙ্ককে M3U8 প্লেলিস্ট ফরম্যাটে মোড়ানো
        m3u8_content = f"""#EXTM3U
#EXT-X-VERSION:3
#EXT-X-TARGETDURATION:3600
#EXT-X-MEDIA-SEQUENCE:0
#EXTINF:3600.0,
{current_media}
#EXT-X-ENDLIST
"""
    
    return Response(
        m3u8_content.strip(),
        mimetype='application/x-mpegURL',
        headers={
            'Access-Control-Allow-Origin': '*',
            'Cache-Control': 'no-cache'
        }
    )
  
