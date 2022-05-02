##########
# params #
##########
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1
# do you want to show the commands executed ?
DO_MKDBG?=0

########
# code #
########
ALL:=

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP

SRC:=src
SOURCES:=$(shell find $(SRC) -name "*.d" -and -type f)
OBJECTS:=$(addsuffix .o, $(basename $(SOURCES)))
EXES:=$(addsuffix .exe, $(basename $(SOURCES)))
# -O3: high optimization
FLAGS:=-O3
ALL+=$(EXES)

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

.PHONY: clean
clean:
	$(Q)rm -f $(EXES) $(OBJECTS)
.PHONY: clean_hard
clean_hard:
	$(Q)git clean -qffxd
.PHONY: debug
debug:
	$(info SOURCES is $(SOURCES))
	$(info OBJECTS is $(OBJECTS))
	$(info EXES is $(EXES))

############
# patterns #
############
$(EXES): %.exe: %.d
	$(Q)ldc2 $(FLAGS) $< -of=$@
