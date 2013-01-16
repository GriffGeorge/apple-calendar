main: main.o
	gcc -o apple-calendar build/main.o -lobjc -framework Foundation -framework EventKit

main.o: main.m
	gcc -c -o build/main.o main.m

