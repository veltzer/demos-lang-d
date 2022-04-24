##########
# params #
##########
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1
# do you want to install tools?
DO_TOOLS:=1

########
# code #
########
ALL:=
TOOLS=tools.stamp

ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP

ifeq ($(DO_TOOLS),1)
.EXTRA_PREREQS+=$(TOOLS)
endif # DO_TOOLS

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
$(TOOLS): packages.txt
	@xargs -a packages.txt sudo apt-get install
	@touch $(TOOLS)

.PHONY: clean
clean:
	@rm -f $(TOOLS) $(EXES) $(OBJECTS)
.PHONY: clean_hard
clean_hard:
	@git clean -qffxd
.PHONY: debug
debug:
	$(info SOURCES is $(SOURCES))
	$(info OBJECTS is $(OBJECTS))
	$(info EXES is $(EXES))

############
# patterns #
############
$(EXES): %.exe: %.d
	@ldc2 $(FLAGS) $< -of=$@
