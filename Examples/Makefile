

prueba: y.tab.o lex.yy.o prueba.o
	gcc -o prueba y.tab.o lex.yy.o prueba.o

prueba.o: prueba.c
	gcc -Wall -ansi -pedantic -c -o prueba.o prueba.c

lex.yy.o: lex.yy.c
	gcc -ansi -pedantic -c -o lex.yy.o lex.yy.c

y.tab.o: y.tab.c
	gcc -ansi -pedantic -c -o y.tab.o y.tab.c

y.tab.c: alfa.y
	bison -dyv alfa.y

y.tab.h: alfa.y
	bison -dyv alfa.y

lex.yy.c: alfa.l y.tab.h
	flex alfa.l

clean:
	rm -rf -rf prueba *.o lex.yy.c y.tab.h y.tab.c y.output
