#!/usr/bin/env python3
"""DevOps Student Application: prints student info (from environment variables)
and then keeps running as a tiny HTTP server so the container stays alive."""
import os
import signal
import sys
import threading
import time
from http.server import BaseHTTPRequestHandler, HTTPServer

NAME = os.getenv("STUDENT_NAME", "not set")
SURNAME = os.getenv("STUDENT_SURNAME", "not set")
GROUP = os.getenv("STUDENT_GROUP", "not set")
STUDENT_ID = os.getenv("STUDENT_ID", "not set")
PORT = int(os.getenv("APP_PORT", "8080"))

BANNER = f"""================================
DevOps Student Application
================================
Name: {NAME}
Surname: {SURNAME}
Group: {GROUP}
Student ID: {STUDENT_ID}

Application is running successfully!"""


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = (BANNER + "\n").encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, fmt, *args):
        print("[http] " + fmt % args, flush=True)


def heartbeat():
    while True:
        time.sleep(15)
        print(time.strftime("%Y-%m-%d %H:%M:%S") + " INFO heartbeat: application is alive", flush=True)


if __name__ == "__main__":
    # docker stop sends SIGTERM: exit quickly instead of waiting for SIGKILL
    signal.signal(signal.SIGTERM, lambda *_: sys.exit(0))
    print(BANNER, flush=True)
    threading.Thread(target=heartbeat, daemon=True).start()
    server = HTTPServer(("0.0.0.0", PORT), Handler)
    print(f"Listening on port {PORT}", flush=True)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
