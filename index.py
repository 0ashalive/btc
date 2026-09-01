import datetime
from flask import Flask, Response

app = Flask(__name__)

# আপনার MP4 সোর্স লিংকসমূহ (ভিডিওর সময়কাল অনুযায়ী শিডিউল রাখতে পারেন)
VIDEO_SOURCES = [
    "https://example.com/video1.mp4",
    "https://example.com/video2.mp4",
]


@app.route("/master/index.m3u8")
def generate_manifest():
    # বর্তমান সময়ের ওপর ভিত্তি করে ডাইনামিক প্লেলিস্ট বা VOD-to-Live পয়েন্ট রূপান্তর
    # Vercel lightweight response এর জন্য static HLS segments redirect করা উত্তম

    m3u8_content = """#EXTM3U
#EXT-X-VERSION:3
#EXT-X-TARGETDURATION:10
#EXT-X-MEDIA-SEQUENCE:0
#EXTINF:10.0,
https://example.com/stream/segment1.ts
#EXTINF:10.0,
https://example.com/stream/segment2.ts
"""
    return Response(
        m3u8_content.strip(),
        mimetype="application/x-mpegURL",
        headers={"Access-Control-Allow-Origin": "*"},
    )


if __name__ == "__main__":
    app.run()
  
