%.o : %.s
	as $< -o $@

bshell: bshell.o
	ld -o bshell bshell.o


clean:
	rm -f *.o bshell
	
