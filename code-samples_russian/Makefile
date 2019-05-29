PROGRAM_SOURCES:=$(wildcard *.lpr)
PROGRAM_BINARIES:=$(PROGRAM_SOURCES:.lpr=)

.PHONY: all
all:
	fpc -gl -gh *.pas
	$(foreach PROGRAM_NAME,$(PROGRAM_SOURCES),fpc $(PROGRAM_NAME) && ) true

.PHONY: clean
clean:
	rm -Rf *.o *.ppu $(PROGRAM_BINARIES)
