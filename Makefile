CCFLAGS = -I.
LEX = flex
YACC = bison
#Target File

build: minimalplusplus

minimalplusplus: bison lex.yy.c 
	cc -o bin/minimalplusplus build/lex.yy.c build/y.tab.c build/sym_tab.c $(CCFLAGS)

bison: src/grammar.y
	$(YACC) -dy src/grammar.y
	mv y.tab.c build/y.tab.c
	mv y.tab.h build/y.tab.h
	
lex.yy.c: src/minimalplusplus.l
	$(LEX) src/minimalplusplus.l
	mv lex.yy.c build/lex.yy.c
	cp src/sym_tab.h build/sym_tab.h
	cp src/sym_tab.c build/sym_tab.c
	cp src/defines.h build/defines.h

clean:
	rm bin/minimalplusplus build/lex.yy.c build/defines.h build/sym_tab.h build/sym_tab.c build/y.tab.c build/y.tab.h