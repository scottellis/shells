%.o : %.s
	as $< -o $@

rshell: rshell.o
	ld -o rshell rshell.o


clean:
	rm -f rshell rshell.o

