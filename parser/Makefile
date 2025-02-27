# Compiler and tools
FLEX = reflex
BISON = bison
CC = g++

# Flags
BISON_FLAGS = -d -v
FLEX_FLAGS = --bison

# Input files
LEX_FILE = lexer.l
BISON_FILE = parser.y

# Generated files
BISON_HEADER = parser.tab.h
BISON_SOURCE = parser.tab.c
# LEX_SOURCE = lex.yy.c
LEX_SOURCE = lex.cpp_.cpp
EXECUTABLE = parser

# Rules
all: $(EXECUTABLE)

$(BISON_HEADER) $(BISON_SOURCE): $(BISON_FILE)
	$(BISON) $(BISON_FLAGS) $(BISON_FILE)

$(LEX_SOURCE): $(LEX_FILE) $(BISON_HEADER)
	$(FLEX) $(FLEX_FLAGS) $(LEX_FILE)

$(EXECUTABLE): $(BISON_SOURCE) $(LEX_SOURCE)
	$(CC) $(CFLAGS) -I/opt/homebrew/include/ -L/opt/homebrew/lib -o $(EXECUTABLE) $(BISON_SOURCE) $(LEX_SOURCE) -ly -lreflex

clean:
	rm -f $(EXECUTABLE) $(BISON_HEADER) $(BISON_SOURCE) $(LEX_SOURCE) parser.output
