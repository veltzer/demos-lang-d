SRC:=src

SOURCES:=$(shell find $(SRC) -name "*.d" -and -type f)
OBJECTS:=$(addsuffix .o, $(basename $(SOURCES)))
EXES:=$(addsuffix .exe, $(basename $(SOURCES)))
# -O3: high optimization
FLAGS:=-O3
ALL_DEP:=Makefile

.PHONY: all
all: $(EXES) $(ALL_DEP)
	@true

$(EXES): %.exe: %.d $(ALL_DEP)
	ldc2 $(FLAGS) $< -of=$@

.PHONY: clean
clean:
	rm -f $(EXES) $(OBJECTS)

.PHONY: debug
debug: $(ALL_DEP)
	$(info SOURCES is $(SOURCES))
	$(info OBJECTS is $(OBJECTS))
	$(info EXES is $(EXES))
	@true
