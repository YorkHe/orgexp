import PIL.Image as image
import binascii
import re

def img_to_bin(bmp_name):
    res = ""
    bmp_file = image.open(bmp_name+".bmp").convert("RGB")
    height, width = bmp_file.size

    arr_a = []
    for i in range(height):
        for j in range(width):
            r, g, b = bmp_file.getpixel((i, j))
            r = int((r / 255.0 * 7))
            g = int((g / 255.0 * 7))
            b = int((b / 255.0 * 3))
            color = r * 2**5 + g * 2 ** 2 + b
            arr_a.append(hex(color));

    arr = [arr_a[i:i+8] for i in range(0, len(arr_a),8)]

    for sub_arr in arr:
        res = res + "\n .word "
        for i in range(len(sub_arr)):
            if i != len(sub_arr)-1:
                res = res + sub_arr[i] + ",";
            else:
                res = res + sub_arr[i]

    fopen = open(bmp_name+".hex", 'w')
    fopen.write(res)


if __name__ == '__main__':
    img_to_bin("0")
    img_to_bin("1")
    img_to_bin("2")
    img_to_bin("3")
    img_to_bin("4")
    img_to_bin("5")
    img_to_bin("6")
    img_to_bin("7")
    img_to_bin("8")
    img_to_bin("9")
