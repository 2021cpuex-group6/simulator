CFLAGS = -g

main: main.o libs/parser.o libs/simulator.o libs/interactive.o libs/utils.o
	g++ -g main.o libs/interactive.o libs/simulator.o  libs/parser.o libs/utils.o -o main


libs/simulator.o: libs/simulator.cpp
	g++ $(CFLAGS) -c libs/simulator.cpp -o libs/simulator.o

main.o: main.cpp
	g++ $(CFLAGS) -c main.cpp

libs/parser.o: libs/parser.cpp
	g++ $(CFLAGS) -c libs/parser.cpp  -o libs/parser.o

libs/interactive.o: libs/interactive.cpp
	g++ $(CFLAGS) -c libs/interactive.cpp  -o libs/interactive.o

libs/utils.o: libs/utils.cpp
	g++ $(CFLAGS) -c libs/utils.cpp  -o libs/utils.o

clean:
	rm *.o main