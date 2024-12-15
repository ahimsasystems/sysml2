# Compiler and tools
FLEX = flex
BISON = bison
CC = gcc

# Flags
BISON_FLAGS = -d -v
FLEX_FLAGS = 

# Input files
LEX_FILE = lexer.l
BISON_FILE = parser.y

# Generated files
BISON_HEADER = parser.tab.h
BISON_SOURCE = parser.tab.c
LEX_SOURCE = lex.yy.c
EXECUTABLE = parser

# Rules
all: $(EXECUTABLE)

$(BISON_HEADER) $(BISON_SOURCE): $(BISON_FILE)
	$(BISON) $(BISON_FLAGS) $(BISON_FILE)

$(LEX_SOURCE): $(LEX_FILE) $(BISON_HEADER)
	$(FLEX) $(FLEX_FLAGS) $(LEX_FILE)

$(EXECUTABLE): $(BISON_SOURCE) $(LEX_SOURCE)
	$(CC) $(CFLAGS) -o $(EXECUTABLE) $(BISON_SOURCE) $(LEX_SOURCE)

clean:
	rm -f $(EXECUTABLE) $(BISON_HEADER) $(BISON_SOURCE) $(LEX_SOURCE) parser.output
