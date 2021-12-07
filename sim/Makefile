CFLAGS := -O3 -Wall -mtune=native -march=native -mfpmath=both
# -O3 -mtune=native -march=native -mfpmath=both
# -pg -Wall -O2 -std=c++17
SIMSRCS := $(wildcard sims/*.cpp) $(wildcard utils/*.cpp) $(wildcard assemble/*.cpp) main.cpp
DEASSEMSRCS = $(wildcard utils/*.cpp) $(wildcard assemble/*.cpp) deassembler.cpp $(wildcard sims/*.cpp)
ASSEMSRCS :=assemble/assemble.cpp $(wildcard utils/*.cpp) assembler.cpp
FPUSRCS := utils/utils.cpp sims/fpu.cpp fpuChecker.cpp
SIMOBJS :=  $(patsubst %.cpp,%.o,$(SIMSRCS))
ASSEMOBJS :=  $(patsubst %.cpp,%.o,$(ASSEMSRCS))
DEASSEMOBJS :=  $(patsubst %.cpp,%.o,$(DEASSEMSRCS))
FPUOBJS :=  $(patsubst %.cpp,%.o,$(FPUSRCS))
# $(warning $(OBJS))
main: $(SIMSRCS)
	g++ $(CFLAGS) -std=c++17 -o $@ $^

fpuChecker: $(FPUSRCS)
	g++ $(CFLAGS) -o $@ $^

tools: tools.cpp
	g++ $(CFLAGS) -o $@ $^

deassembler: $(DEASSEMSRCS)
	g++ $(CFLAGS) -std=c++17 -lstdc++fs -o $@ $^

assembler: $(ASSEMSRCS)
	g++ $(CFLAGS) -std=c++17 -lstdc++fs -o $@ $^

%.o: %.cpp
	g++ $(CFLAGS) -o $@ -c $<

clean:
	rm  $(SIMOBJS) $(ASSEMOBJS) $(DEASSEMOBJS) $(FPUOBJS) main assembler code fpuChecker deassembler tools