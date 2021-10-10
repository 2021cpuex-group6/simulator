CFLAGS := -g -Wall
SIMSRCS := $(wildcard sims/*.cpp) $(wildcard utils/*.cpp) main.cpp
ASSEMSRCS := $(wildcard assemble/*.cpp) $(wildcard utils/*.cpp) assembler.cpp
SIMOBJS :=  $(patsubst %.cpp,%.o,$(SIMSRCS))
ASSEMOBJS :=  $(patsubst %.cpp,%.o,$(ASSEMSRCS))
# $(warning $(OBJS))
main: $(SIMOBJS)
	g++ $(CFLAGS) -o $@ $^

assembler: $(ASSEMOBJS)
	g++ $(CFLAGS) -o $@ $^

%.o: %.cpp
	g++ $(CFLAGS) -o $@ -c $<

clean:
	rm  $(SIMOBJS) $(ASSEMOBJS) main assembler code