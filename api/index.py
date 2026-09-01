from flask import Flask, Response, redirect
import urllib.parse

app = Flask(__name__)

# আপনার লিংকসমূহ
MEDIA_SOURCES = [
    "https://pub-4e135af7e68844d8816cb0f642379557.r2.dev/CINEFREAK.TOP%20-%20Toxic%20%282026%29%20HDTC%20%5BHindi%20LiNE%5D%20720p%20HC-ESub.mkv",
]

@app.route('/master/index.m3u8')
def serve_m3u8():
    current_media = MEDIA_SOURCES[0]
    
    # ১. যদি লিংকটি আগেই M3U8 হয়, সরাসরি রিডাইরেক্ট করবে
    if current_media.endswith('.m3u8'):
        return redirect(current_media, code=302)
    
    # ২. MP4/MKV ফাইলের জন্য direct play stream Response (বিকল্প হিসেবে external streaming engine URL)
    # সতর্কতা: Vercel FFmpeg সমর্থন করে না, তাই MP4/MKV-কে আসল HLS বানাতে external HLS proxy বা CDN প্লেয়ারের সাহায্য নিতে হয়।
    
    m3u8_content = f"""#EXTM3U
#EXT-X-VERSION:3
#EXT-X-INDEPENDENT-SEGMENTS
#EXT-X-STREAM-INF:BANDWIDTH=2000000,RESOLUTION=1280x720
{current_media}
"""
    
    return Response(
        m3u8_content.strip(),
        mimetype='application/vnd.apple.mpegurl',
        headers={
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, OPTIONS',
            'Cache-Control': 'no-cache, no-store, must-revalidate'
        }
    )

# Vercel Serverless Entrypoint
if __name__ == '__main__':
    app.run()
