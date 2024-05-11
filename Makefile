MODULES = 
PROGRAMS = SampleUsage 

#DEFDIR = def
#MODDIR = mod
#OBJDIR = obj
OBJDIR = .

#EXTRADEFDIR = ../m2-raylib
EXTRALINK = -lraylib
#EXTRALINK = $(OBJDIR)/libraylib.so.4.5.0

GM2 = gm2-14
GM2FLAGS = -fsoft-check-all -fiso -g -O2 -Wall -I$(DEFDIR) -I$(EXTRADEFDIR)

MODULES_DEF = $(addprefix $(DEFDIR)/, $(MODULES:=.def))
MODULES_MOD = $(addprefix $(MODDIR)/, $(MODULES:=.mod))
MODULES_OBJ = $(addprefix $(OBJDIR)/, $(MODULES:=.o))
PROGRAMS_BIN = $(addprefix $(OBJDIR)/, $(PROGRAMS:=.bin))

#all: modules programs
all: $(MODULES_OBJ) $(PROGRAMS_BIN)

#modules: $(addprefix $(OBJDIR)/, $(MODULES:=.o))

#programs: $(addprefix $(OBJDIR)/, $(PROGRAMS:=.bin))

$(OBJDIR)/%.o: $(MODDIR)/%.mod $(DEFDIR)/%.def
	$(GM2) $(GM2FLAGS) -c -o $@ $<

$(OBJDIR)/%.bin: %.mod $(MODULES_DEF) $(MODULES_OBJ)
	$(GM2) $(GM2FLAGS) -o $@ $(MODULES_OBJ) $< $(EXTRALINK)

clean:
	rm -f *.o
	rm -f $(OBJDIR)/*.o
	rm -f $(OBJDIR)/*.bin
