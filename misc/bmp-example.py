import Image

img = Image.new('RGB', (255,255)) # create a new black image
pixels = img.load() # create the pixel map

for i in range(img.size[0]):    # for every pixel:
    for j in range(img.size[1]):
        pixels[i, j] = (255, 255, 255) # set the colour accordingly

img.save("/tmp/rata.bmp")
img.show()
