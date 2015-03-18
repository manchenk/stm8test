#######################
# SDCC Makefile for making a hexfile from all .C files in this directory.
# Hexfile location is '.', other output files are generated in directory 'output'.
#######################

# define compiler (has to be in PATH)
CC = sdcc

# define output, compiler/linker options etc.
CFLAGS = -mstm8 --std-sdcc99 $(OPTIMIZE)
LFLAGS = -mstm8 -lstm8 $(OPTIMIZE)
OBJDIR = output
DRVSRC = driver/src
DRVINC = driver/inc

# set defaults
TARGET=$(OBJDIR)/main.hex

.PHONY: clean all default objects
.PRECIOUS: $(TARGET) $(OBJECTS)

default: $(TARGET)

all: default
CSOURCE = $(wildcard *.c) $(wildcard $(DRVSRC)/*.c)
OBJECTS = $(patsubst %.c,$(OBJDIR)/%.rel,$(CSOURCE))
HEADERS = $(wildcard *.h) $(wildcard $(DRVINC)/*.h)

# compile all *c files
$(OBJDIR)/%.rel: %.c $(HEADERS)
	$(CC) $(CFLAGS) -I./ -I./$(DRVINC) -c $< -o $@

# link all object files and libaries
$(TARGET): $(OBJECTS)
#	@echo '---- OBJECTS ----'
#	@echo $(wildcard *.c)
#	@echo $(OBJECTS)
#	@echo $(HEADERS)
	$(CC) $(LFLAGS) $(OBJECTS) -o $@

# clean up
clean:
	-rm -f .DS_Store
	-rm -f $(OBJDIR)/*
	-rm -fr Release
	-rm -fr Debug
	-rm -f *.hex
	-rm -r *.map
	-rm -r *.lk
	-rm -r *.dep
	-rm -r *.pdb
	-rm -r *.wdb
	-rm -r *.wed
