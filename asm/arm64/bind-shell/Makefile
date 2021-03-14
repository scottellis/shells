%.o : %.s
	as $< -o $@

bshell: bshell.o
	ld -o bshell bshell.o


clean:
	rm -f bshell bshell.o

