%{
  #include <cstdio>
  #include <iostream>
  using namespace std;

  // stuff from flex that bison needs to know about:
  extern int yylex();
  extern int yyparse();
  extern int yylineno;
  extern FILE *yyin;
 
  void yyerror(const char *s);

%}

%token INT FLOAT VOID
%token WHILE IF ELSE SWITCH CASE BREAK DEFAULT
%token NUM DNUM ID
%token INCLUDE
%token INC DEC
%right ASGN 
%left LOR
%left LAND
%left BOR
%left BXOR
%left BAND
%left EQ NE 
%left LE GE LT GT
%left '+' '-' 
%left '*' '/'

%nonassoc IF
%nonassoc ELSE

%%

pgmstart    : TYPE ID '(' ')' STMTS
            ;

STMTS       : '{' STMT1 '}'
            ;

STMT1       : STMT  STMT1
            |
            ;

STMT        : STMT_DECLARE    //all types of statements
            | STMT_ASSGN
            | STMT_IF
            | STMT_WHILE
            | STMT_SWITCH
            | ';'
            ;

STMT_DECLARE    : TYPE ID IDS   //setting type for that line
                ;

STMT_ASSGN      : ID ASGN EXP ';'
                ;

STMT_IF         : IF EXP STMT %prec IF
                | IF EXP STMT ELSE_STMT
                | IF EXP STMTS ELSE_STMT
                ;

ELSE_STMT       : ELSE STMT
                | ELSE STMTS
                |
                ;

STMT_WHILE      : WHILE EXP WHILEBODY  
                ;

WHILEBODY       : STMTS
                | STMT
                ;

STMT_SWITCH     : SWITCH EXP '{' SWITCHBODY '}'
                ;

SWITCHBODY      : CASES  
                | CASES DEFAULTSTMT
                ;

CASES           : CASE NUM ':' SWITCHEXP BREAKSTMT
                | 
                ;
BREAKSTMT       : BREAK ';' CASES
                | CASES 
                ;

DEFAULTSTMT     : DEFAULT ':' SWITCHEXP DE  
                ;

DE              : BREAK ';'
                |
                ;

SWITCHEXP       : STMTS
                | STMT
                ;

IDS       : ';'
          | ','  ID IDS 
          ;

TYPE      : INT
          | FLOAT
          | VOID
          ;

EXP       : EXP LT EXP
          | EXP LE EXP
          | EXP GT EXP
          | EXP GE EXP
          | EXP NE EXP
          | EXP EQ EXP
          | EXP '+' EXP
          | EXP '-' EXP
          | EXP '*' EXP
          | EXP '/' EXP
          | EXP LOR EXP
          | EXP LAND EXP
          | EXP BOR EXP
          | EXP BXOR EXP
          | EXP BAND EXP
          | EXP INC
          | EXP DEC
          | '(' EXP ')'
          | ID
          | NUM
          | DNUM
          ;

%%


int main(int argc, char *argv[]) {

  // set lex to read from it instead of defaulting to STDIN:
  yyin = fopen(argv[1], "r");

  // parse through the input until there is no more:
  
  do {
    yyparse();
  } while (!feof(yyin));

  cout<< endl <<"Parse Successful !!" << endl;

  }

void yyerror(const char *s) {
  cout << endl << "EEK, parse error on line " << yylineno << "!  Message: " << s << endl;
  // might as well halt now:
  exit(-1);
}