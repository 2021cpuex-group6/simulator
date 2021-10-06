CFLAGS := -g
SRCS := $(wildcard libs/*.cpp) main.cpp
OBJS :=  $(patsubst %.cpp,%.o,$(SRCS))
# $(warning $(OBJS))
main: $(OBJS)
	g++ $(CFLAGS) -o $@ $^

%.o: %.cpp
	g++ $(CFLAGS) -o $@ -c $<

clean:
	rm  libs/*.o *.o main