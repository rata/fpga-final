
import serial
import sys
import Image


def recv_pixel(ser):
	while True:
		byte = ser.read(1)
		if byte == '\0':
			#print "skipping"
			continue
		#print "byte es", byte
		return ord(byte)

if len(sys.argv) != 4:
	print "Usage:", sys.argv[0], "<width> <height> <dst file>"

size = (int(sys.argv[1]), int(sys.argv[2]))
dst_file = sys.argv[3]

ser = serial.Serial("/dev/ttyUSB0", 19200, parity='N', rtscts=False, xonxoff=False)
#byte = ser.read(1)
#byte = ser.read(1)

img = Image.new('RGB', size) # create a new black image
pixels = img.load()

y_pxs = range(img.size[1])
#y_pxs.reverse()
x_pxs = range(img.size[0])
#x_pxs.reverse()

for y in y_pxs:
    for x in x_pxs:
	px = recv_pixel(ser)
	#print "receiving", px
        pixels[x, y] = (px, px, px) # set the colour accordingly

img.save(dst_file)
img.show()

ser.close()