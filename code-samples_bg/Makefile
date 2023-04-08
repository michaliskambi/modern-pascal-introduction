UNIT_SOURCES:=$(wildcard *.pas)
PROGRAM_SOURCES:=$(wildcard *.lpr)
PROGRAM_BINARIES:=$(PROGRAM_SOURCES:.lpr=)

.PHONY: all
all:
	$(foreach UNIT_NAME,$(UNIT_SOURCES),fpc $(UNIT_NAME) && ) true
	$(foreach PROGRAM_NAME,$(PROGRAM_SOURCES),fpc $(PROGRAM_NAME) && ) true

.PHONY: clean
clean:
	rm -Rf *.o *.ppu $(PROGRAM_BINARIES)
