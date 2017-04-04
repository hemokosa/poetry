#!/usr/bin/python

# Author: Mark Dadisman (mbomb007)
# Date: Sept. 26, 2015
# Description: Interpret a Self-modifying Brainfuck program
# 	- Language created by Simon Howard <fraggle@removethisbit.gmail.com>
# References:
#	- [https://]esolangs.org/wiki/Self-modifying_Brainfuck
#	- [https://]soulsphere.org/hacks/smbf/

# Edits:
#	10/08/2015 	- Try/Except in Tape.__getitem__
#				- Implemented Tape.__len__
#	10/09/2015	- Fixed bug with pc where dynamically created code wouldn't execute.
#				- Added debug print statments and dynamic code test
#	10/13/2015	- Fixed input not working at all
#	10/19/2015  - Changed error(objs) to error(*objs)
#				- Added errors checks for bracket mismatches
#	03/03/2016	- Added MySTDIN for custom input. Works with non-printable ascii. by ZachGates.
#	22/04/2016	- Print tape during execution by Akihiro Kubota.

from __future__ import print_function
import os, sys

import io

class Tape(bytearray):
	def __init__(self):
		self.data = bytearray(b'\0' * 1000)
		self.center = len(self.data) // 2
		self.end = 0

	def __len__(self):
		return len(self.data)

	def __getitem__(self, index):
		try:
			return self.data[index + self.center]
		except:
			return 0

	def __setitem__(self, index, val):

		i = index + self.center

		if i < 0 or i >= len(self.data):
			# resize the data array to be large enough

			new_size = len(self.data)

			while True:
				new_size *= 2
				test_index = index + (new_size // 2)
				if test_index >= 0 and test_index < new_size:
					# array is big enough now
					break

			# generate the new array
			new_data = bytearray(b'\0' * new_size)
			new_center = new_size // 2

			# copy old data into new array
			for j in range(0, len(self.data)):
				new_data[j - self.center + new_center] = self.data[j]

			self.data = new_data
			self.center = new_center

		self.data[index + self.center] = val & 0xff
		self.end = max(self.end, index+1)

class Interpreter():
	def __init__(self, data):
		self.tape = Tape()

		# copy the data into the tape
		for i in range(0, len(data)):
			self.tape[i - len(data)] = data[i]

		# program start point

		self.entrypoint = -len(data)

	def call(self):
		pc = self.entrypoint
		ptr = 0

		while pc < self.tape.end:
			for i in range(-len(self.tape), len(self.tape)):
				if i == pc and i == ptr:
					print("{ (", chr(self.tape[i]), ") }", end="")
				elif i == pc and i != ptr:
					print("(", chr(self.tape[i]), ")", end="")
				elif i != pc and i == ptr:
					print("{", chr(self.tape[i]), "}", end="")
				else:
					print(chr(self.tape[i]), end="")

			c = chr(self.tape[pc])
			if   c == '>':
				ptr += 1
			elif c == '<':
				ptr -= 1
			elif c == '+':
				self.tape[ptr] += 1
			elif c == '-':
				self.tape[ptr] -= 1
			elif c == '.':
				print(" :", chr(self.tape[ptr]), end="")
			elif c == ',':
				self.tape[ptr] = ord(sys.stdin.read(1) or '\0')
			elif c == '[':
				if self.tape[ptr] == 0:
					# advance to end of loop
					loop_level = 1
					while loop_level > 0:
						pc += 1
						if pc > self.tape.end:
							error("Bracket mismatch")
						if   chr(self.tape[pc]) == '[': loop_level += 1
						elif chr(self.tape[pc]) == ']': loop_level -= 1
			elif c == ']':
				# rewind to the start of the loop
				loop_level = 1
				while loop_level > 0:
					pc -= 1
					if pc < -len(self.tape):
						error("Bracket mismatch")
					if   chr(self.tape[pc]) == '[': loop_level -= 1
					elif chr(self.tape[pc]) == ']': loop_level += 1
				pc -= 1
			pc += 1
			print()

def load_script(filename):
	buf = bytearray(os.path.getsize(filename))
	with open(filename, "rb") as f:
		try:
			f.readinto(buf)
			return buf
		except Exception as e:
			error("Failed to load script file '%s'."%filename, e)

def error(*objs):
	print(*objs, file=sys.stderr)
	sys.exit(1)

# For testing with non-printable input
class MySTDIN(list):
    def __init__(self, obj=''):
        if not isinstance(obj, str):
            raise TypeError("a string is required")
        self._init(obj)

    def __repr__(self):
        return str(self)

    def __str__(self):
        return "".join(self)

    def _init(self, obj=''):
        for k in obj:
            list.append(self, k)

    def read(self, n=1):
        retval = ""
        while n and self:
            retval += self.pop(0)
            n -= 1
        return retval

def main():
	#L = len(sys.argv)
	#if L < 2: error("Please provide a file to interpret.")
	#if L >=2: data = load_script(sys.argv[1])
	#if L > 3: sys.stdin = open(sys.argv[2])

	# Override stdin. Helpful for non-printable input. Comment to use normal input.
	#sys.stdin = MySTDIN("<[.<]")

	#data = bytearray(b',[>,]')
	#data = bytearray(b'<.<.<.<.<.<.<.<.<.<.<.<.<.\x00!dlroW ,olleH')
	#data = bytearray(b'<.<.<.<.<.<.<.<.!001adad')
	#data = bytearray(b'<[.<]>>>>>>>>+\x00!dlroW ,olleH')
	#data = bytearray(b'<[.<]>>>>>>>+\x00!adaD ,olleH')
	#data = bytearray(b'<[.<]>>>>>+\x00!001 ,adaD')
	#data = bytearray(b'>>++++++[<<++++++++++>++++++++>-]<--<1')
	#data = bytearray(b'<+[.<+]ckqnvnkkdg')
	#data = bytearray(b'<+[.<+]//0`c`c')
	#data = bytearray(b'+[+++++-+>++>++-++++++<<]>++.[+.]')
	#data = bytearray(b'++++++++[>+>++>+++>++++>+++++>++++++>+++++++>++++++++>+++++++++>++++++++++>+++++++++++>++++++++++++>+++++++++++++>++++++++++++++>+++++++++++++++>++++++++++++++++<<<<<<<<<<<<<<<<-]>>>>>>>>>>>>>----.++++<<<<<<<<<<<<<>>>>>>>>>>>>+.-<<<<<<<<<<<<>>>>>>>>>>>>>----.++++<<<<<<<<<<<<<>>>>>>>>>>>>+.-<<<<<<<<<<<<>>>>>>+.-<<<<<<>>>>>>.<<<<<<>>>>>>.<<<<<<.')
	#data = bytearray(b'++++[++++>---<]>+.--[-->+++<]>--.+++.---.+[-->+<]>.-..')
	data = bytearray(b'>++++++++[<++++++++>-]<++++.>+++++[<+++++>-]<++++.+++.---.>+++++++[<------->-]<+.-..')
	print(data)

	# I/O without buffer
	#sys.stdout = os.fdopen(sys.stdout.fileno(), 'w', 0)
	#sys.stderr = os.fdopen(sys.stderr.fileno(), 'w', 0)

	intr = Interpreter(data)
	intr.call()

	sys.stdin = sys.__stdin__

	print(intr.tape.data)
	#print(intr.tape.data, end="")
	#print(intr.tape.data.decode('ascii'), end="")
	#print(intr.tape.data.decode('ascii').replace('\0','_').strip('_'), end="")
	#print(bytearray(intr.tape.data.decode('ascii').strip('\0'),'ascii'), end="")

if __name__ == "__main__":
	main()
