import serial
import sys

# Este ejemplo fue probado con la UART (ver carpeta UART). Se debe ejecutar de
# la siguiente forma para que el ISE endemoniado no haga cagadas:
#
# 1) Conectar la alimentacion de la placa por USB (NO conectar la UART)
# 2) Compilar y programar la placa
# 3) Conectar por USB la UART
# 4) Correr este programa
#
# Si se hacen las cosas en otro orden, el ISE se boludea y no detecta la placa
# para programarla


if len(sys.argv) <= 1:
	dev = "/dev/ttyUSB0"
else:
	dev = sys.argv[1]

#ser = serial.Serial(dev, 19200, timeout=10)
ser = serial.Serial(dev, 19200, parity='N', rtscts=False, xonxoff=False)

while True:
	#ser.write("5")
	byte = ser.read(1)
	
	
	#print ord(byte)
	sys.stdout.write("imprimiendo: ")
	sys.stdout.write(byte)
	sys.stdout.write("\n")
	#print byte, ord(byte), repr(byte), chr(int(byte))

ser.close()
