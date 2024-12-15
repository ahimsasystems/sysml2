%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);  /* Declare yyerror with correct signature */
// int yyinput(void);  // Declare yyinput explicitly
int yylex(void);

%}

%union {
    char *str;
}

%token <str> BASIC_NAME
%token <str> UNRESTRICTED_NAME
%type <str> name

%%

name:
    BASIC_NAME {
        printf("BASIC_NAME: %s\n", $1);
        free($1); // Free memory allocated in Flex
    }
  | UNRESTRICTED_NAME {
        printf("UNRESTRICTED_NAME: %s\n", $1);
        free($1); // Free memory allocated in Flex
    }
  ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
