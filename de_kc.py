#!/usr/bin/python3

# borrowed (and simplified) from
# https://github.com/Heisenberk/decode-kcpassword (MIT license)

key = [125, 137, 82, 35, 210, 188, 221, 234, 163, 185, 31]
length = len(key)
f = open("/etc/kcpassword", "rb")
byte = list(f.read())
f.close()

end = False
kcpassword = []
for i in range(len(byte)):
    if byte[i] ^ key[i % length] == 0:
        end = True

    if end == False:
        kcpassword.append(str(chr(byte[i] ^ key[i % length])))

print("".join(map(str, kcpassword)))
