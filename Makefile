SRC = ./src
DIST = ./bin

JC = javac
JFLAGS = -g -d $(DIST)


source:
	find $(SRC) -name "*.java" > sources.txt

compile:
		$(JC) $(JFLAGS) @sources.txt

run:
		java -cp $(DIST) main.App

build:
		find $(DIST) -name "*.class" > classes.txt
		jar cvfm App.jar Manifest.txt @classes.txt

exec:
		java -jar App.jar

clean:
		rm -rf $(DIST)/*
