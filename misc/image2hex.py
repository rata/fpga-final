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

for y in range(fin.size[1]):
    for x in range(fin.size[0]):
	buf1, buf2, buf3 = pixels[x, y]
	buf1_ascii = to_ascii_hex(buf1)
	buf2_ascii = to_ascii_hex(buf2)
	buf3_ascii = to_ascii_hex(buf3)
	fout.write(buf1_ascii + buf2_ascii + buf3_ascii + '\n')
