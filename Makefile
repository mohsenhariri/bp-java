SRC = ./src
DIST = ./bin

JC = javac
JFLAGS = -g -d $(DIST)



compile:
		$(JC) $(JFLAGS) $(SRC)/*.java

run:
		java -cp $(DIST) App

build:
		jar -cvmf  Manifest.txt  app.jar $(DIST)/*.class

exec:
		java -jar app.jar
