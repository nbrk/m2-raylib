
EXEMODULES = Driver1.mod

# EXEAUXLIBS = -lm libraylib.a # for static linking
EXEAUXLIBS = libraylib.so

# ----------------------------

all: objects executables

executables: $(EXEMODULES:.mod=)

ALLMODULES = $(wildcard *.mod)
ALLDEFS = $(wildcard *.def)

# Link as an executable: trampoline into the module's initialization block
%: %.mod $(ALLMODULES:.mod=.o)
	gm2 -fiso -fsoft-check-all -g -Wall -fonlylink -o $@ $< $(EXEAUXLIBS)

objects: $(ALLMODULES:.mod=.o)

# %.o: %.mod $(ALLDEFS)
# Just compile the Modula-2 module (TODO: remove ALLDEFS but recompile on def change...)
%.o: %.mod
	gm2 -fiso -fsoft-check-all -g -c -Wall $<

clean:
	rm -f $(ALLMODULES:.mod=.o)
	rm -f $(EXEMODULES:.mod=)
