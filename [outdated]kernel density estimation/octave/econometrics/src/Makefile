MKOCTFILE = mkoctfile -Wall

PROGS = $(patsubst %.cc,%.oct,$(wildcard *.cc))

all: $(PROGS)

%.oct: %.cc
	$(MKOCTFILE) $<

clean:
	rm -f *.o octave-core core *.oct *~
