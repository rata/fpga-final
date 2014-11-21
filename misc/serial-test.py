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
ser = serial.Serial(dev, 19200)

ser.write("5")
byte = ser.read()
print "printing byte in next line"
print byte


ser.close()
