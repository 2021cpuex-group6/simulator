CFLAGS := -g -Wall -O0 -std=c++17
SIMSRCS := $(wildcard sims/*.cpp) $(wildcard utils/*.cpp) main.cpp
DEASSEMSRCS = $(wildcard utils/*.cpp) $(wildcard assemble/*.cpp) deassembler.cpp $(wildcard sims/*.cpp)
ASSEMSRCS := $(wildcard assemble/*.cpp) $(wildcard utils/*.cpp) assembler.cpp
FPUSRCS := utils/utils.cpp sims/fpu.cpp fpuChecker.cpp
SIMOBJS :=  $(patsubst %.cpp,%.o,$(SIMSRCS))
ASSEMOBJS :=  $(patsubst %.cpp,%.o,$(ASSEMSRCS))
DEASSEMOBJS :=  $(patsubst %.cpp,%.o,$(DEASSEMSRCS))
FPUOBJS :=  $(patsubst %.cpp,%.o,$(FPUSRCS))
# $(warning $(OBJS))
main: $(SIMOBJS)
	g++ $(CFLAGS) -o $@ $^

fpuChecker: $(FPUOBJS)
	g++ $(CFLAGS) -o $@ $^

tools: tools.cpp
	g++ $(CFLAGS) -o $@ $^

deassembler: $(DEASSEMOBJS)
	g++ $(CFLAGS) -lstdc++fs -o $@ $^

assembler: $(ASSEMOBJS)
	g++ $(CFLAGS) -lstdc++fs -o $@ $^

%.o: %.cpp
	g++ $(CFLAGS) -o $@ -c $<

clean:
	rm  $(SIMOBJS) $(ASSEMOBJS) $(DEASSEMOBJS) $(FPUOBJS) main assembler code fpuChecker deassembler tools