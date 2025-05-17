#!/usr/bin/env python3
import os
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import parse_qs

UPLOAD_DIR = os.path.expanduser("~/LocalDrop/Shared_material")

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b'''
            <html><body>
            <h2>Upload File</h2>
            <form enctype="multipart/form-data" method="post">
            <input name="file" type="file"/>
            <input type="submit" value="Upload"/>
            </form>
            </body></html>
        ''')

    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        content_type = self.headers['Content-Type']

        if "multipart/form-data" not in content_type:
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Unsupported Media Type")
            return

        boundary = content_type.split("boundary=")[1].encode()
        data = self.rfile.read(content_length)

        parts = data.split(b"--" + boundary)
        for part in parts:
            if b"Content-Disposition" in part:
                header, file_data = part.split(b"\r\n\r\n", 1)
                file_data = file_data.rsplit(b"\r\n", 1)[0]  # Strip last boundary
                disposition = header.decode()
                if 'filename="' in disposition:
                    filename = disposition.split('filename="')[1].split('"')[0]
                    filepath = os.path.join(UPLOAD_DIR, filename)
                    with open(filepath, 'wb') as f:
                        f.write(file_data)
                    print(f"[+] Uploaded: {filename}")

        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"File uploaded successfully!")

if __name__ == "__main__":
    os.makedirs(UPLOAD_DIR, exist_ok=True)
    print(f"[*] Upload server running at http://0.0.0.0:8081/")
    httpd = HTTPServer(('0.0.0.0', 8081), SimpleHTTPRequestHandler)
    httpd.serve_forever()
