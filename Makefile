CC = gcc
CCFLAGS = -I.
LEX = flex

#Target File

build: minimalplusplus

minimalplusplus: lex.yy.c
	$(CC) -o bin/minimalplusplus build/lex.yy.c $(CCFLAGS)
	
lex.yy.c: src/minimalplusplus.l
	$(LEX) src/minimalplusplus.l
	mv lex.yy.c build/lex.yy.c
	cp src/sym_hashing.h build/sym_hashing.h
	cp src/defines.h build/defines.h

clean:
	rm bin/minimalplusplus build/lex.yy.c build/defines.h build/sym_hashing.h