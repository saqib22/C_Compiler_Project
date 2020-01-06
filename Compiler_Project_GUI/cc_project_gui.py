#!/usr/bin/env python3

from tkinter import *
from tkinter import Tk, RIGHT, BOTH, RAISED, Text
from tkinter.ttk import Frame, Button, Style
from tkinter import filedialog
import os

class compilerUI(Frame):
	def __init__(self):
		super().__init__()
		self.initUI()
		self.filename = ""
		self.compiler_output = ""

	def openfile(self):
		self.filename = filedialog.askopenfilename()
		if self.filename.endswith('.c'):
			self.text.delete('1.0', END)
			self.text.insert(INSERT, "SUCCESS: File at path " + self.filename + "loaded successfully.")
			self.compiler_output  = self.execute_system_command("./prog " + self.filename)
		else:
			self.text.delete('1.0', END)
			self.text.insert(INSERT, "ERROR: Not a valid C file")
			self.filename = ""
	
	def execute_system_command(self, command):
		return os.popen(command).read()

	def scanner(self):
		if self.filename == "":
			return
		self.text.delete('1.0', END)
		scanner_output = self.compiler_output.splitlines()[0]
		self.text.insert(INSERT, scanner_output)	

	def parser(self):
		if self.filename == "":
			return
		self.text.delete('1.0', END)
		parser_output = self.compiler_output.splitlines()[1]
		self.text.insert(INSERT, parser_output)
	
	def parserTree(self):
		if self.filename == "":
			return
		self.text.delete('1.0', END)
		self.parseTree = self.execute_system_command('./parser <' + 'test1.b')
		self.text.insert(INSERT, self.parseTree)

	def initUI(self):

		self.master.title("C Compiler")
		self.style = Style()
		self.style.theme_use("default")

		menu = Menu(self)
		self.master.config(menu=menu)
		filemenu = Menu(menu) 
		menu.add_cascade(label='File', menu=filemenu) 
		filemenu.add_command(label='Open C file...', command=self.openfile) 
		filemenu.add_separator() 
		filemenu.add_command(label='Exit', command=self.quit) 

		frame = Frame(self, relief=RAISED, borderwidth=1)
		frame.pack(fill=BOTH, expand=True)

		self.pack(fill=BOTH, expand=True, side=BOTTOM)

		scannerButton = Button(self, text="Scanner", command=self.scanner)
		scannerButton.pack(side=LEFT, padx=5, pady=5)
		parserButton = Button(self, text="Parser", command=self.parser)
		parserButton.pack(side=LEFT)
		parserTreeButton = Button(self, text="Generate Parse Tree", command=self.parserTree)
		parserTreeButton.pack(side=LEFT, padx=5, pady=5)
		
		self.text = Text(frame, height=30)
		self.text.pack(fill=BOTH)

def main():
	root = Tk()
	root.geometry("600x500+600+600")
	app = compilerUI()
	root.mainloop()

if __name__ == '__main__':
	main()