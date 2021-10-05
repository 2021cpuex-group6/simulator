sim: sim.o parser.o
	g++ -g sim.o parser.o -o sim

sim.o: sim.cpp
	g++ -g -c sim.cpp

parser.o: parser.cpp
	g++ -g -c parser.cpp

clean:
	rm *.o sim