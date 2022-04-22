##########
# params #
##########
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1

########
# code #
########
# dependency on the makefile itself
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif

SRC:=src
SOURCES:=$(shell find $(SRC) -name "*.d" -and -type f)
OBJECTS:=$(addsuffix .o, $(basename $(SOURCES)))
EXES:=$(addsuffix .exe, $(basename $(SOURCES)))
# -O3: high optimization
FLAGS:=-O3

#########
# rules #
#########
.PHONY: all
all: $(EXES)
	@true
.PHONY: clean
clean:
	rm -f $(EXES) $(OBJECTS)
.PHONY: debug
debug:
	$(info SOURCES is $(SOURCES))
	$(info OBJECTS is $(OBJECTS))
	$(info EXES is $(EXES))
	@true

############
# patterns #
############
$(EXES): %.exe: %.d
	@ldc2 $(FLAGS) $< -of=$@
