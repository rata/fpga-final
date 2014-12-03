#!/usr/bin/env python
# -*- coding:utf-8 -*-
import sys
import Image

def to_ascii_hex(val):
	to_ascii = str(hex(val))
	to_ascii = to_ascii[2:]
	to_ascii = to_ascii.zfill(2)
	return to_ascii


fin  = Image.open(sys.argv[1])
fout  = open(sys.argv[2], 'wb')

pixels = fin.load()
y_pxs = range(fin.size[1])
#y_pxs.reverse()
x_pxs = range(fin.size[0])
#x_pxs.reverse()

for y in y_pxs:
    for x in x_pxs:
	buf1, buf2, buf3 = pixels[x, y]
	#print "buf1", buf1
	#print "buf2", buf2
	#print "buf3", buf3
	buf1_ascii = to_ascii_hex(buf1)
	buf2_ascii = to_ascii_hex(buf2)
	buf3_ascii = to_ascii_hex(buf3)
	#print "buf1_ascii es:", buf1_ascii
	#print "buf2_ascii es:", buf2_ascii
	#print "buf3_ascii es:", buf3_ascii
	fout.write(buf1_ascii + buf2_ascii + buf3_ascii + '\n')
