CFLAGS = -g

main: main.o parser.o simulator.o
	g++ -g main.o simulator.o  parser.o -o main


simulator.o: simulator.cpp
	g++ $(CFLAGS) -c simulator.cpp

main.o: main.cpp
	g++ $(CFLAGS) -c main.cpp

parser.o: parser.cpp
	g++ $(CFLAGS) -c parser.cpp

clean:
	rm *.o main