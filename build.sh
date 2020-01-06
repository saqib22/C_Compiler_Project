flex -o Compiler.lex.c -l Compiler.l
bison -o Compiler.tab.c -vd Compiler.y
g++ -o prog Compiler.lex.c Compiler.tab.c -lm -ll
./prog test