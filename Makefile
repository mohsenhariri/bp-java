# https://www.gnu.org/software/make/manual/make.html
include .env.dev
export

include *.make

VERSION := $(shell cat VERSION)
PROJECT := $(shell basename $(CURDIR))

# JAVA := /home/mohsen/compiler/jdk/bin/java
JAVA := /usr/bin/java
DOCKER := /usr/bin/docker

PATH := ./bin:$(PATH)

.PHONY: all dev clean
include .env
export

SRC = src
DIST = target

JC = javac
JFLAGS = -g -d $(DIST)

.PHONY: env test all dev clean dev gen-commands $(SRC) $(DIST) $(BUILD)


.DEFAULT_GOAL := test

.ONESHELL:

%: # https://www.gnu.org/software/make/manual/make.html#Automatic-Variables 
		@:

source:
	find $(SRC) -name "*.java" > sources.txt

compile:
		$(JC) $(JFLAGS) @sources.txt

run:
		java -cp $(DIST) main.App

all: source compile run

build:
		find $(DIST) -name "*.class" > classes.txt
		jar cvfm App.jar Manifest.txt @classes.txt

exec:
		java -jar App.jar

clean:
		rm -r ./$(DIST)
