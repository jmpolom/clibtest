CFLAGS 	:= -Wall -Werror

default: all

all: bin/maintest bin/maintest-rpath bin/maintest-static

.PHONY: clean
clean:
	rm -f bin/* lib/*

.PHONY: dirclean
dirclean:
	rm -rf bin lib

bin/:
	mkdir bin/

lib/:
	mkdir lib/

lib/libfoo.so: foo.c | lib/
	$(CC) $(CFLAGS) -fPIC -shared -o lib/libfoo.so foo.c

lib/libfoo-static.a: foo.c | lib/
	$(CC) $(CFLAGS) -c -o lib/libfoo-static.a foo.c

bin/maintest: main.c lib/libfoo.so | bin/
	$(CC) $(CFLAGS) -L$(PWD)/lib -lfoo -o bin/maintest main.c

bin/maintest-rpath: main.c lib/libfoo.so | bin/
	$(CC) $(CFLAGS) -L$(PWD)/lib -lfoo -Wl,-rpath $(PWD)/lib -o bin/maintest-rpath main.c

bin/maintest-static: main.c lib/libfoo-static.a | bin/
	$(CC) $(CFLAGS) -L$(PWD)/lib -lfoo-static -o bin/maintest-static main.c
