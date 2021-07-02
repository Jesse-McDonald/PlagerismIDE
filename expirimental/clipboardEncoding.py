import itertools
ec='​'
#I really should have documented what this does at the time
#there where 2 options, either assign 0 to be ec and 1 to be letter
#Or assign letter to be flip flop, and ec to be the number of 0/1 in this flip
#the later uses more data, but since we are limited by letters only, it is ideal
#Note, all encodings begin with a letter to make copy past safer
#revise for final, all encodeings begin with a non whitespace letter
def encode(bytes,string):
	bytes=bytearray(bytes,'utf-8')
	ret=""
	last=1
	for byte in bytes:
		bits=[]
		for i in range(8):#apparently we are doing something I never expected, inverse big endian?

			bits.append((1<<i&byte)>>i)
		for bit in bits:
			if(last!=bit):
				last=bit
				ret+=string[0]
				string=string[1:]
			ret+=ec 
	ret+=string
	return ret
def decode(string):
	bits=[]
	bit=1
	for ch in string:
		if(ch==ec):
			bits.append(bit)
		else:
			bit^=1

	bytes = [sum([byte[b] << b for b in range(0,8)])
            for byte in zip(*(iter(bits),) * 8)
        ]
	for i in range(len(bytes)):
		bytes[i]=chr(bytes[i])
	return bytes
coded=encode("Test","This is a long encoder string that should be logn enough for the test")

print(coded)
print(decode(coded))