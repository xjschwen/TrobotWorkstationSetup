#!/bin/python
# import the necessary packages
import numpy as np
import cv2
import sys

# load the games image
image = cv2.imread("high-goals.png")
blur = cv2.blur(image,(7,7))
 
cv2.imwrite("blur.jpg", blur)

# find the red color game in the image
upper = np.array([125, 125, 15])
lower = np.array([80, 80, 0])

mask = cv2.inRange(blur, lower, upper)

 
# find contours in the masked image and keep the largest one
(_, cnts, _) = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

print cnts

if (cnts == None):
	print "contour not found"
	sys.exit()
else:
	c = max(cnts, key=cv2.contourArea)
 
# approximate the contour
peri = cv2.arcLength(c, True)
approx = cv2.approxPolyDP(c, 0.05 * peri, True)

 
# draw a green bounding box surrounding the red game
cv2.drawContours(blur, [approx], -1, (0, 255, 0), 4)
cv2.imshow("mask", mask)
cv2.imshow("Blur", blur)
#cv2.imshow("Image", image)
cv2.waitKey(0)

