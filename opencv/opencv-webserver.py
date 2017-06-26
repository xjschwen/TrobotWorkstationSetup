#!/usr/bin/python
'''
	Author: Igor Maculan - n3wtron@gmail.com
	A Simple mjpg stream http server
'''
import cv2

import Image
from BaseHTTPServer import BaseHTTPRequestHandler,HTTPServer
import StringIO
import time
capture=None

# Could not locate these in python bindings
# looked them up in the c code 
CV_CAP_PROP_FRAME_WIDTH = 3
CV_CAP_PROP_FRAME_HEIGHT = 4
CV_CAP_PROP_SATURATION = 12


class CamHandler(BaseHTTPRequestHandler):
	def do_GET(self):
		if self.path.endswith('.mjpg'):
			self.send_response(200)
			self.send_header('Content-type','multipart/x-mixed-replace; boundary=--jpgboundary')
			self.end_headers()
			while True:
				try:
					rc,img = capture.read()
					if not rc:
						continue
					imgRGB=cv2.cvtColor(img,cv2.COLOR_BGR2RGB)
					jpg = Image.fromarray(imgRGB)
					tmpFile = StringIO.StringIO()
					jpg.save(tmpFile,'JPEG')
					self.wfile.write("--jpgboundary")
					self.send_header('Content-type','image/jpeg')
					self.send_header('Content-length',str(tmpFile.len))
					self.end_headers()
					jpg.save(self.wfile,'JPEG')
					time.sleep(0.05)
				except KeyboardInterrupt:
					break
			return
		if self.path.endswith('.html'):
			self.send_response(200)
			self.send_header('Content-type','text/html')
			self.end_headers()
			self.wfile.write('<html><head></head><body>')
			self.wfile.write('<img src="http://127.0.0.1:8080/cam.mjpg"/>')
			self.wfile.write('</body></html>')
			return

def main():
	global capture
	for d in dir(cv2):
	  print d
	  
	capture = cv2.VideoCapture(0)
	capture.set(CV_CAP_PROP_FRAME_WIDTH, 320); 
	capture.set(CV_CAP_PROP_FRAME_HEIGHT, 240);
	capture.set(CV_CAP_PROP_SATURATION,0.5);
	
	global img
	try:
		server = HTTPServer(('',8080), CamHandler)
		print "server started"
		server.serve_forever()
	except KeyboardInterrupt:
		capture.release()
		server.socket.close()

if __name__ == '__main__':
	main()

