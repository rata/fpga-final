#!/usr/bin/env python
# -*- coding:utf-8 -*-
import serial
import sys
import Image

def recv_pixel(ser):
	while True:
		byte = ser.read(1)
		if byte == '\0':
			continue
		return ord(byte)

if len(sys.argv) != 4:
	print "Usage:", sys.argv[0], "<width> <height> <dst file>"

size = (int(sys.argv[1]), int(sys.argv[2]))
dst_file = sys.argv[3]

ser = serial.Serial("/dev/ttyUSB0", 19200, parity='N', rtscts=False, xonxoff=False)

img = Image.new('RGB', size)
pixels = img.load()

for y in range(img.size[1]):
    for x in range(img.size[0]):
	px = recv_pixel(ser)
        pixels[x, y] = (px, px, px)

img.save(dst_file)
ser.close()
