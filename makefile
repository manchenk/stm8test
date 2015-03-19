#######################
# SDCC Makefile for making a hexfile from all .C files in this directory.
# Hexfile location is '.', other output files are generated in directory 'output'.
#######################

# define compiler (has to be in PATH)
CC = sdcc

# define CPU type
# STM8S208       STM8S High density devices with CAN
# STM8S207       STM8S High density devices without CAN
# STM8S007       STM8S Value Line High density devices
# STM8AF52Ax     STM8A High density devices with CAN
# STM8AF62Ax     STM8A High density devices without CAN
# STM8S105       STM8S Medium density devices
# STM8S005       STM8S Value Line Medium density devices
# STM8AF626x     STM8A Medium density devices
# STM8AF622x     STM8A Low density devices
# STM8S103       STM8S Low density devices
# STM8S003       STM8S Value Line Low density devices
# STM8S903       STM8S Low density devices
CPU = STM8S003

# define output, compiler/linker options etc.
CFLAGS = -mstm8 --std-sdcc99 $(OPTIMIZE)
LFLAGS = -mstm8 -lstm8 $(OPTIMIZE)
OBJDIR = output
DRVSRCPATH = driver/src
DRVINCPATH = driver/inc

# set defaults
TARGET=$(OBJDIR)/main.hex

.PHONY: clean all default objects
.PRECIOUS: $(TARGET) $(OBJECTS)

default: $(TARGET)

all: default
DRVSRC = stm8s_beep.c stm8s_exti.c stm8s_i2c.c stm8s_rst.c stm8s_tim2.c stm8s_tim5.c stm8s_uart2.c stm8s_wwdg.c \
         stm8s_flash.c stm8s_itc.c stm8s_spi.c stm8s_tim3.c stm8s_tim6.c stm8s_uart3.c \
         stm8s_awu.c stm8s_clk.c stm8s_gpio.c stm8s_iwdg.c stm8s_tim1.c stm8s_tim4.c stm8s_uart1.c 
ifeq (($(CPU),STM8S105) OR ($(CPU),STM8S005) OR ($(CPU),STM8S103) OR ($(CPU),STM8S003) OR ($(CPU),STM8S903) OR ($(CPU),STM8AF626x) OR ($(CPU),STM8AF622x))
DRVSRC += stm8s_adc1.c
endif
ifeq (($(CPU),STM8S208) OR ($(CPU),STM8S207) OR ($(CPU),STM8S007) OR ($(CPU),STM8AF52Ax) OR ($(CPU),STM8AF62Ax))
DRVSRC += stm8s_adc2.c
endif
ifeq ($(CPU),STM8AF622x)
DRVSRC += stm8s_uart4.c
endif
ifeq (($(CPU),STM8S208) OR ($(CPU),STM8AF52Ax))
DRVSRC += stm8s_can.c
endif

CSOURCE = $(wildcard *.c) $(patsubst %.c,$(DRVSRCPATH)/%.c,$(DRVSRC))
OBJECTS = $(patsubst %.c,$(OBJDIR)/%.rel,$(CSOURCE))
HEADERS = $(wildcard *.h) $(wildcard $(DRVINCPATH)/*.h)

# compile all *c files
$(OBJDIR)/%.rel: %.c $(HEADERS)
	$(CC) -D$(CPU) $(CFLAGS) -I./ -I./$(DRVINC) -c $< -o $@

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
