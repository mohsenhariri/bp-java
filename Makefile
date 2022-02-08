SRC = ./src
DIST = ./bin


JC = javac
JFLAGS = -g -d $(DIST)



compile:
	$(JC) $(JFLAGS) ./src/*.java


run:
		java -cp $(DIST) App