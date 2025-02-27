%option c++
%option prefix="cpp_"


%{
#include "parser.tab.h" // Include Bison-generated token definitions
#include <string.h>
#include <stdlib.h>
#include <iostream>
#include <string>

// Function to process an UNRESTRICTED_NAME
char *process_unrestricted_name(const char *lexeme) {
    size_t len = strlen(lexeme);
    char *result = (char*) malloc(len); // Allocate memory for the processed string
    if (!result) {
        fprintf(stderr, "Memory allocation failed.\n");
        exit(EXIT_FAILURE);
    }

    const char *src = lexeme + 1; // Skip the initial single quote
    char *dest = result;
    while (*src && *src != '\'') { // Stop at the closing single quote
        if (*src == '\\') {
            src++; // Handle escape sequence
            switch (*src) {
                case 'n': *dest++ = '\n'; break;
                case 't': *dest++ = '\t'; break;
                case 'r': *dest++ = '\r'; break;
                case '\\': *dest++ = '\\'; break;
                case '\'': *dest++ = '\''; break;
                default:  *dest++ = *src; break;
            }
        } else {
            *dest++ = *src;
        }
        src++;
    }
    *dest = '\0'; // Null-terminate the result
    return result;
}
%}

%option noyywrap

%%

[a-zA-Z_][a-zA-Z_0-9]*  {
    // yylval.str = strdup(yytext); // For BASIC_NAME, directly pass the matched lexeme
    yylval.str = strdup(text()); // For BASIC_NAME, directly pass the matched lexeme

    return BASIC_NAME;
}

'([^'\\]|\\.)*'         {
    // yylval.str = process_unrestricted_name(yytext); // Process the UNRESTRICTED_NAME lexeme
    yylval.str = process_unrestricted_name(text()); // Process the UNRESTRICTED_NAME lexeme
    return UNRESTRICTED_NAME;
}

%%
