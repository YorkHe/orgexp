import PIL.Image as image
import binascii
import re

def img_to_bin(bmp_name):
    res = ""
    bmp_file = image.open(bmp_name+".bmp")
    bmp_bytes = bmp_file.tobytes()
    bmp_ascii = binascii.hexlify(bmp_bytes)


    arr_a = re.findall("........?", bmp_ascii)
    arr = [arr_a[i:i+8] for i in range(0, len(arr_a),8)]

    for sub_arr in arr:
        res = res + "\n .word "
        for i in range(len(sub_arr)):
            if i != len(sub_arr)-1:
                res = res + "0x" + sub_arr[i] + ",";
            else:
                res = res + "0x" + sub_arr[i]

    fopen = open(bmp_name+".hex", 'w')
    fopen.write(res)


if __name__ == '__main__':
    img_to_bin("doodle")
    img_to_bin("background")
    img_to_bin("plate")
