#!/usr/bin/env python
# -*- coding:utf-8 -*-
import sys

fin  = open(sys.argv[1], 'rb')
fout  = open(sys.argv[2], 'wb')

# Salteamos el header de bmp
fin.seek(54)

buf = fin.read(1)
i = 0
while buf:
	#print "buf a secas es", buf
	#print "buf ord es:", ord(buf)
	to_ascii = str(hex(ord(buf)))
	to_ascii = to_ascii[2:]
	to_ascii = to_ascii.zfill(2)
	#print "nosotros nos quedamos con", to_ascii
	fout.write(to_ascii)

	buf = fin.read(1)
	i = i + 1
	if i % 3 == 0:
		fout.write('\n')
