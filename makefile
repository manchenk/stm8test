#######################
# SDCC Makefile for making a hexfile from all .C files in this directory.
# Hexfile location is '.', other output files are generated in directory 'output'.
#######################

# define compiler (has to be in PATH)
CC = sdcc
HEX2BIN = makebin
FLASHER = stm8flash

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

# define modules
#USE_BEEP  = stm8s_beep.c
#USE_EXTI  = stm8s_exti.c
#USE_I2C = stm8s_i2c.c
USE_RST = stm8s_rst.c
#USE_WWDG = stm8s_wwdg.c
#USE_FLASH = stm8s_flash.c
USE_ITC = stm8s_itc.c
#USE_SPI = stm8s_spi.c
#USE_AWU = stm8s_awu.c
USE_CLK = stm8s_clk.c
USE_GPIO = stm8s_gpio.c
#USE_IWDG = stm8s_iwdg.c
#USE_TIM1 = stm8s_tim1.c
#USE_TIM2 = stm8s_tim2.c
#USE_TIM3 = stm8s_tim3.c
#USE_TIM4 = stm8s_tim4.c
#USE_TIM5 = stm8s_tim5.c 
#USE_TIM6 = stm8s_tim6.c
#USE_ADC1 = stm8s_adc1.c
#USE_ADC2 = stm8s_adc2.c
#USE_CAN = stm8s_can.c
#USE_UART1 = stm8s_uart1.c
#USE_UART2 = stm8s_uart2.c
#USE_UART3 = stm8s_uart3.c
#USE_UART4 = stm8s_uart4.c

#optimize level
OPTIMIZE = --opt-code-size

# define output, compiler/linker options etc.
CFLAGS = -mstm8 --std-sdcc99 $(OPTIMIZE)
LFLAGS = -mstm8 -lstm8 $(OPTIMIZE)
OBJDIR = output
DRVSRCPATH = driver/src
DRVINCPATH = driver/inc

# set defaults
TARGET=$(OBJDIR)/main.ihx
OUTBIN=$(OBJDIR)/main.bin

.PHONY: clean all default objects
.PRECIOUS: $(TARGET) $(OBJECTS)

default: $(TARGET)

all: default
DRVSRC = $(USE_BEEP) $(USE_EXTI) $(USE_I2C) $(USE_RST) $(USE_WWDG) $(USE_FLASH) $(USE_ITC) $(USE_SPI) \
         $(USE_AWU) $(USE_CLK) $(USE_GPIO) $(USE_IWDG) $(USE_TIM1)
ifeq ($(findstring $(CPU),STM8S105 STM8S005 STM8S103 STM8S003 STM8S903 STM8AF626x STM8AF622x),$(CPU))
DRVSRC += $(USE_ADC1)
endif
ifeq ($(findstring $(CPU),STM8S208 STM8S207 STM8S007 STM8AF52Ax STM8AF62Ax),$(CPU))
DRVSRC += $(USE_ADC2)
endif
ifeq ($(findstring $(CPU),STM8S208 STM8AF52Ax),$(CPU))
DRVSRC += $(USE_CAN)
endif
ifeq ($(findstring $(CPU),STM8S208 STM8S207 STM8S007 STM8S103 STM8S003 STM8S903 STM8AF52Ax STM8AF62Ax),$(CPU))
DRVSRC += $(USE_UART1)
endif
ifeq ($(findstring $(CPU),STM8S105 STM8S005 STM8AF626x),$(CPU))
DRVSRC += $(USE_UART2)
endif
ifeq ($(findstring $(CPU),STM8S208 STM8S207 STM8S007 STM8AF52Ax),$(CPU))
DRVSRC += $(USE_UART3)
endif
ifeq ($(CPU),STM8AF622x)
DRVSRC += $(USE_UART4)
endif
ifeq ($(findstring $(CPU),STM8S208 STM8S207 STM8S007 STM8S103 STM8S003 STM8S105 STM8S005 STM8AF52Ax \
                          STM8AF62Ax STM8AF626x),$(CPU))
DRVSRC += $(USE_TIM2)
endif
ifeq ($(findstring $(CPU),STM8S208 STM8S207 STM8S007 STM8S105 STM8S005 STM8AF52Ax STM8AF62Ax STM8AF626x),$(CPU))
DRVSRC += $(USE_TIM3)
endif
ifeq ($(findstring $(CPU),STM8S208 STM8S207 STM8S007 STM8S103 STM8S003 STM8S105 STM8S005 STM8AF52Ax \
                          STM8AF62Ax STM8AF626x),$(CPU))
DRVSRC += $(USE_TIM4)
endif
ifeq ($(findstring $(CPU),STM8S903 STM8AF622x),$(CPU))
DRVSRC += $(USE_TIM5) $(USE_TIM6)
endif

CSOURCE = $(wildcard *.c) $(patsubst %.c,$(DRVSRCPATH)/%.c,$(DRVSRC))
OBJECTS = $(patsubst %.c,$(OBJDIR)/%.rel,$(CSOURCE))
HEADERS = $(wildcard *.h) $(wildcard $(DRVINCPATH)/*.h)

# compile all *c files
$(OBJDIR)/%.rel: %.c $(HEADERS)
	$(CC) -D$(CPU) $(CFLAGS) -I./ -I./$(DRVINCPATH) -c $< -o $@

# link all object files and libaries
$(TARGET): $(OBJECTS)
	$(CC) $(LFLAGS) $(OBJECTS) -o $@
#	$(HEX2BIN) -p -s 65536 $@ $(OUTBIN)

# write to flash
program:
	$(FLASHER) -c stlink -p stm8s003 -w $(TARGET)


# clean up
clean:
	-rm -f $(OBJDIR)/*
	-rm -f $(OBJDIR)/$(DRVSRCPATH)/*
#	-rm -f *.hex
#	-rm -r *.map
#	-rm -r *.lk
#	-rm -r *.dep
#	-rm -r *.pdb
#	-rm -r *.wdb
#	-rm -r *.wed
