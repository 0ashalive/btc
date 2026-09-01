from flask import Flask, Response, request
import requests

app = Flask(__name__)

MEDIA_URL = "https://pub-4e135af7e68844d8816cb0f642379557.r2.dev/CINEFREAK.TOP%20-%20Toxic%20%282026%29%20HDTC%20%5BHindi%20LiNE%5D%20720p%20HC-ESub.mkv"

@app.route('/master/index.m3u8')
def stream_video():
    # Pass range headers for seeking support in HTML5 players
    headers = {}
    if 'Range' in request.headers:
        headers['Range'] = request.headers['Range']
        
    req = requests.get(MEDIA_URL, headers=headers, stream=True)
    
    response_headers = {
        'Content-Type': 'video/x-matroska',  # Or 'video/mp4' for .mp4 files
        'Accept-Ranges': 'bytes',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': '*',
    }
    
    if 'Content-Range' in req.headers:
        response_headers['Content-Range'] = req.headers['Content-Range']
        status_code = 206
    else:
        status_code = 200
        
    return Response(
        req.iter_content(chunk_size=1024*1024),
        status=status_code,
        headers=response_headers
    )
